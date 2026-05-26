import { loadSchema } from './src/schema/schemaLoader.js';

const tables = loadSchema('./data/cm_fresh.sql');
const recurr = tables.find(t => t.name === 'recurr');
console.log(recurr.sql);