/**
 * @module mergeDescriptions
 * @description Merges all batch description JSON files into a single
 * tableDescriptions.json file. Run once after all batches are complete.
 * Usage: node scripts/mergeDescriptions.js
 */
import { readFileSync, writeFileSync, readdirSync } from 'fs';

const dir = './data/descriptions';
const files = readdirSync(dir).filter(f => f.endsWith('.json'));

let merged = {};

for (const file of files) {
  const content = JSON.parse(readFileSync(`${dir}/${file}`, 'utf8'));
  merged = { ...merged, ...content };
}

writeFileSync('./data/tableDescriptions.json', JSON.stringify(merged, null, 2));
console.log(`Merged ${Object.keys(merged).length} table descriptions into data/tableDescriptions.json`);