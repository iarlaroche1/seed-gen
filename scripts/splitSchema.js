/**
 * @module splitSchema
 * @description Splits cm_fresh.sql into batches of 100 tables each.
 * Used to generate table descriptions via Claude UI in manageable chunks.
 * Run once: node scripts/splitSchema.js
 */
import { readFileSync, writeFileSync, mkdirSync } from 'fs';

const sql = readFileSync('./data/cm_fresh.sql', 'utf8');
const regex = /CREATE TABLE `(\w+)` \([\s\S]*?\) ENGINE=[\s\S]*?;/g;

const tables = [];
let match;
while ((match = regex.exec(sql)) !== null) {
  tables.push({ name: match[1], sql: match[0] });
}

const BATCH_SIZE = 100;
mkdirSync('./data/batches', { recursive: true });

for (let i = 0; i < tables.length; i += BATCH_SIZE) {
  const batch = tables.slice(i, i + BATCH_SIZE);
  const batchNum = Math.floor(i / BATCH_SIZE) + 1;
  const content = batch.map(t => t.sql).join('\n\n');
  writeFileSync(`./data/batches/batch_${batchNum}.sql`, content);
  console.log(`Wrote batch_${batchNum}.sql — ${batch.length} tables`);
}

console.log(`Done — ${Math.ceil(tables.length / BATCH_SIZE)} batch files created`);