import { loadSchema } from './src/schema/schemaLoader.js';
import { buildVectorStore, searchVectorStore } from './src/schema/vectorStore.js';

const tables = loadSchema('./data/cm_fresh.sql');
await buildVectorStore(tables);

const results = await searchVectorStore('carer cannot see their schedule', 10);
results.forEach(r => console.log(`${r.score.toFixed(3)} — ${r.name}`));