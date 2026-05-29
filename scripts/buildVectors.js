import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';
import { loadSchema } from '../src/schema/schemaLoader.js';
import { buildVectorStore } from '../src/schema/vectorStore.js';

const __dirname = dirname(fileURLToPath(import.meta.url));

const schemaPath = resolve(__dirname, '../data/cm_fresh.sql');
console.log('Loading schema…');
const tables = loadSchema(schemaPath);
console.log(`${tables.length} tables loaded.`);

console.log('Building vector store…');
await buildVectorStore(tables);
console.log('Done — data/vectors.json written.');
