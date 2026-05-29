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

const descriptions = JSON.parse(
  readFileSync(resolve(__dirname, '../data/tableDescriptions.json'), 'utf8')
);
const fkGraph = JSON.parse(
  readFileSync(resolve(__dirname, '../data/fkGraph.json'), 'utf8')
);

const TICKET_RE = /^[A-Z]+-\d+$/i;

app.post('/api/search', async (req, res) => {
  const { query } = req.body ?? {};
  if (!query?.trim()) return res.status(400).json({ error: 'query is required' });

  try {
    let ticket = null;
    let searchQuery = query.trim();

    if (TICKET_RE.test(query.trim())) {
      const raw = await getTicket(query.trim().toUpperCase());
      ticket = parseTicket(raw);
      searchQuery = [ticket.summary, ticket.problemStatement].filter(Boolean).join(' ');
    }

    if (!vectorStoreExists()) {
      return res.status(503).json({
        error: 'Vector store not built. Run: node scripts/buildVectors.js first.',
      });
    }

    const results = await searchVectorStore(searchQuery, 10);
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

app.get('/api/fkgraph', (_req, res) => res.json(fkGraph));

app.post('/api/seed', async (req, res) => {
  const { ticketId, tables = [] } = req.body ?? {};
  await new Promise(r => setTimeout(r, 1800));
  const rowsInserted = tables.length * (Math.floor(Math.random() * 6) + 3);
  res.json({
    success: true,
    tablesSeeded: tables.length,
    rowsInserted,
    ticketId: ticketId ?? null,
    sql: buildStubSql(ticketId, tables),
  });
});

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
