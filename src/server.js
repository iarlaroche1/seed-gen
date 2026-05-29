import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';
import { getTicket, getTicketComments } from './ticket/jiraClient.js';
import { parseTicket, parseComments } from './ticket/ticketParser.js';
import { searchVectorStore, vectorStoreExists } from './schema/vectorStore.js';
import { generateSeed } from './seed/seedGenerator.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const app = express();

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;

// Loaded at startup so every request doesn't hit disk.
// descriptions is a flat { tableName: string } map from tableDescriptions.json.
// fkGraph is the precomputed dependency graph written by fkExtractor.js.
// glossary maps business/ticket language to table names, bridging the gap
// between how developers describe bugs and how the schema is named.
// schemaMap is { tableName: createTableSQL } built from cm_fresh.sql — used by
// generateSeed to extract real column names without re-reading the file per request.
const descriptions = JSON.parse(
  readFileSync(resolve(__dirname, '../data/tableDescriptions.json'), 'utf8')
);
const fkGraph = JSON.parse(
  readFileSync(resolve(__dirname, '../data/fkGraph.json'), 'utf8')
);
const glossary = JSON.parse(
  readFileSync(resolve(__dirname, '../data/domainGlossary.json'), 'utf8')
);

const TABLE_REGEX = /CREATE TABLE `(\w+)` \([\s\S]*?\) ENGINE=[\s\S]*?;/g;
const rawSchema = readFileSync(resolve(__dirname, '../data/cm_fresh.sql'), 'utf8');
const schemaMap = {};
let _m;
TABLE_REGEX.lastIndex = 0;
while ((_m = TABLE_REGEX.exec(rawSchema)) !== null) {
  schemaMap[_m[1]] = _m[0];
}

// Matches Jira-style keys like OTR-123 or PROJ-4567.
// Used to decide whether the query should trigger a Jira fetch first.
const TICKET_RE = /^[A-Z]+-\d+$/i;

// POST /api/search
// Accepts a free-text query or a Jira ticket ID.
// For ticket IDs: fetches the ticket, extracts summary + problem statement,
// then uses that as the vector search query so the frontend doesn't need
// to know about Jira at all.
app.post('/api/search', async (req, res) => {
  const { query } = req.body ?? {};
  if (!query?.trim()) return res.status(400).json({ error: 'query is required' });

  try {
    let ticket = null;
    let searchQuery = query.trim();

    if (TICKET_RE.test(query.trim())) {
      const ticketId = query.trim().toUpperCase();
      const [raw, rawComments] = await Promise.all([
        getTicket(ticketId),
        getTicketComments(ticketId).catch(() => []), // comments are non-fatal
      ]);
      ticket = parseTicket(raw);
      console.log('parsed ticket:', JSON.stringify(ticket, null, 2));

      // Split on '. ' rather than '\n' because the ADF parser produces long
      // runs of text with few real line breaks. Sentence splitting gives finer
      // control and avoids passing metadata labels into the embedding.
      const METADATA_RE = /https?:\/\/|company|server|location|steps|vimeo|screenshot|governance id|care[1-4]/i;
      const cleanedSentences = ticket.problemStatement
        .split('. ')
        .map(s => s.trim())
        .filter(s => s.length > 20 && !METADATA_RE.test(s))
        .slice(0, 3)
        .join('. ');

      const comments = parseComments(rawComments);
      console.log(`comments found: ${comments.length}`);
      console.log('parsed comments:', comments);

      // Drop automated noise: git-bot messages, bare branch names, commit hashes.
      // A comment that is only alphanumerics/dashes/slashes with no spaces is
      // almost certainly a branch name or hash, not human text.
      const NOISE_RE = /mentioned this issue in a (commit|merge request)|merged branch|^resolve$|^merge branch/i;
      const NO_SPACES_RE = /^[a-z0-9_\-/']+$/i;
      const substantiveComments = comments.filter(
        c => !NOISE_RE.test(c) && !NO_SPACES_RE.test(c)
      );
      console.log('filtered comments:', substantiveComments);

      // Second pass: domain relevance. Only keep comments that mention a known
      // table name, a glossary term, or a generic DB keyword. An off-topic comment
      // (e.g. "Can you check this with the client?") adds noise to the embedding.
      const DB_KEYWORDS = new Set([
        'table', 'column', 'row', 'query', 'database', 'field', 'record',
        'insert', 'update', 'delete', 'select', 'sql', 'schema',
      ]);
      const tableNames = new Set(Object.keys(descriptions).map(k => k.toLowerCase()));
      const glossaryTerms = Object.keys(glossary).map(t => t.toLowerCase());

      const domainComments = substantiveComments.filter(c => {
        const lower = c.toLowerCase();
        // Check DB keywords and table names via word boundary splits for speed
        const words = lower.split(/\W+/);
        if (words.some(w => DB_KEYWORDS.has(w) || tableNames.has(w))) return true;
        // Glossary terms can be multi-word so check as substrings
        if (glossaryTerms.some(term => lower.includes(term))) return true;
        return false;
      });
      console.log(`domain-relevant comments: ${domainComments.length} / ${substantiveComments.length}`);

      // For Done/Closed tickets, comments describe the fix (code changes, PR links)
      // rather than the bug — appending them pulls the embedding toward the solution
      // rather than the problem, degrading table match quality.
      const CLOSED_STATUSES = new Set(['done', 'closed']);
      const ticketIsClosed = CLOSED_STATUSES.has((ticket.status ?? '').toLowerCase());

      // If the problem statement contains SQL syntax, strip the syntax and replace
      // it with just the table names — SQL keywords and backtick-quoted identifiers
      // hurt embeddings while the bare table names help.
      const SQL_STATEMENT_RE = /\b(SELECT|FROM|WHERE|INSERT|UPDATE)\b/i;
      // Matches `tableName` or plain word after FROM/JOIN/INTO/UPDATE/TABLE keywords
      const SQL_TABLE_RE = /(?:FROM|JOIN|INTO|UPDATE|TABLE)\s+`?(\w+)`?/gi;
      // Extract SQL table names from text, filtering to only known schema tables
      // to eliminate false positives like SQL keywords or English words ("the", "set").
      function extractSqlTableNames(text) {
        const found = [];
        let m;
        SQL_TABLE_RE.lastIndex = 0;
        while ((m = SQL_TABLE_RE.exec(text)) !== null) found.push(m[1]);
        return [...new Set(found)].filter(name => tableNames.has(name.toLowerCase()));
      }

      // Normalise a block of text: if it contains SQL, replace the SQL with just
      // the verified table names so the embedding sees schema refs, not syntax noise.
      function normaliseSql(text) {
        if (!SQL_STATEMENT_RE.test(text)) return text;
        const sqlTables = extractSqlTableNames(text);
        return sqlTables.length > 0 ? sqlTables.join(' ') : text;
      }

      let effectiveBase = normaliseSql(cleanedSentences);
      if (effectiveBase !== cleanedSentences) {
        console.log('SQL detected in problem statement — extracted table names:', effectiveBase);
      }

      // Join all domain-relevant comments and trim to the space remaining after the
      // base query (summary + problem statement). Total cap is 600 chars.
      const baseQuery = [ticket.summary, effectiveBase].filter(Boolean).join(' ').trim();
      const commentBudget = 600 - baseQuery.length - 1; // -1 for the joining space
      console.log(`comment budget: ${commentBudget} chars (base query: ${baseQuery.length})`);

      const normalisedComments = domainComments.map(normaliseSql);
      const commentSnippet = !ticketIsClosed && commentBudget > 0 && normalisedComments.length > 0
        ? normalisedComments.join(' ').slice(0, commentBudget)
        : '';
      if (ticketIsClosed) console.log(`skipping comments — ticket status is "${ticket.status}"`);
      console.log('comment snippet:', commentSnippet);

      searchQuery = [baseQuery, commentSnippet]
        .filter(Boolean)
        .join(' ')
        .trim();
      console.log('search query:', searchQuery);
    }

    // Enrich the query with table names from the domain glossary.
    // Ticket language ("governance", "rota") rarely matches schema names directly;
    // appending the mapped table names gives the vector store concrete anchors.
    const lowerQuery = searchQuery.toLowerCase();
    const glossaryHits = Object.entries(glossary)
      .filter(([term]) => lowerQuery.includes(term))
      .flatMap(([, tables]) => tables);

    if (glossaryHits.length > 0) {
      searchQuery = `${searchQuery} ${[...new Set(glossaryHits)].join(' ')}`.trim().slice(0, 400);
    }
    console.log('enriched query:', searchQuery);

    // vectors.json is gitignored and must be built locally before searching.
    if (!vectorStoreExists()) {
      return res.status(503).json({
        error: 'Vector store not built. Run: node scripts/buildVectors.js first.',
      });
    }

    const results = await searchVectorStore(searchQuery, 10);
    // Merge vector results with plain-English descriptions from tableDescriptions.json.
    // The vector store only returns name + sql + score; descriptions are richer for display.
    const tables = results.map(r => ({
      name: r.name,
      score: r.score,
      description: descriptions[r.name] ?? '',
    }));

    res.json({ ticket, tables });
  } catch (err) {
    console.error('[/api/search]', err.message);
    res.status(500).json({ error: err.message });
  }
});

// GET /api/fkgraph
// Serves the precomputed FK dependency graph for the frontend's SVG visualisation.
app.get('/api/fkgraph', (_req, res) => res.json(fkGraph));

// POST /api/seed
// Generates a structured seed SQL file for the matched tables using real column
// names from the schema and FK-ordered inserts. Values are typed placeholders —
// AI-driven value generation is not yet wired in (see src/seed/seedGenerator.js).
app.post('/api/seed', async (req, res) => {
  const { ticket, tables = [] } = req.body ?? {};
  try {
    const result = generateSeed({ ticket, tables, fkGraph, schemaMap });
    res.json(result);
  } catch (err) {
    console.error('[/api/seed]', err.message);
    res.status(500).json({ error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`seed-gen API · http://localhost:${PORT}`);
});
