import { loadSchema } from './src/schema/schemaLoader.js';

const tables = loadSchema('./data/cm_fresh.sql');
console.log(`Loaded ${tables.length} tables`);
console.log('First table:', tables[0].name);