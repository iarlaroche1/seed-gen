import { loadSchema } from './src/schema/schemaLoader.js';

const tables = await loadSchema();
console.log(`Loaded ${tables.length} tables`);
console.log('Sample:', tables[0]);