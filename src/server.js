import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';
import { getTicket } from './ticket/jiraClient.js';
import { parseTicket } from './ticket/ticketParser.js';
import { searchVectorStore, vectorStoreExists } from './schema/vectorStore.js';

const __dirname = dirname(fileURLToPath(import.meta.url));
const app = express();

app.use(cors());
app.use(express.json());

const PORT = process.env.PORT || 3001;

// Loaded at startup so every request doesn't hit disk.
// descriptions is a flat { tableName: string } map from tableDescriptions.json.
// fkGraph is the precomputed dependency graph written by fkExtractor.js.
const descriptions = JSON.parse(
  readFileSync(resolve(__dirname, '../data/tableDescriptions.json'), 'utf8')
);
const fkGraph = JSON.parse(
  readFileSync(resolve(__dirname, '../data/fkGraph.json'), 'utf8')
);

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
      const raw = await getTicket(query.trim().toUpperCase());
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

      searchQuery = [ticket.summary, cleanedSentences]
        .filter(Boolean)
        .join(' ')
        .trim()
        .slice(0, 300);
      console.log('search query:', searchQuery);
    }

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
// NOT IMPLEMENTED — stubbed to unblock frontend development.
// Replace this with real seed generation (Claude API + topological insert ordering)
// once the src/seed/ module is built.
app.post('/api/seed', async (req, res) => {
  const { ticketId, tables = [] } = req.body ?? {};
  await new Promise(r => setTimeout(r, 1800));
  res.json({
    stubbed: true,
    ticketId: ticketId ?? null,
    tables,
    sql: buildStubSql(ticketId, tables),
  });
});

// Produces a skeleton SQL file showing the shape of real output.
// FOREIGN_KEY_CHECKS=0/1 will be needed in the real implementation because
// topological sort can't resolve self-referencing tables (e.g. clientInfectionsMcGeer).
function buildStubSql(ticketId, tables) {
  return [
    `-- Generated seed SQL${ticketId ? ` for ${ticketId}` : ''}`,
    `-- Tables: ${tables.join(', ')}`,
    '',
    'SET FOREIGN_KEY_CHECKS=0;',
    '',
    ...tables.map(t => `-- INSERT INTO \`${t}\` (...) VALUES (...);`),
    '',
    'SET FOREIGN_KEY_CHECKS=1;',
  ].join('\n');
}

app.listen(PORT, () => {
  console.log(`seed-gen API · http://localhost:${PORT}`);
});
