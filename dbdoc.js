#!/usr/bin/env node
/**
 * @module dbdoc
 * @description CLI tool for searching OneTouch Health table descriptions.
 * Searches tableDescriptions.json by table name or keyword.
 * Supports multiple queries separated by spaces or commas.
 * 
 * Usage:
 *   dbdoc recurr                    — exact table lookup
 *   dbdoc schedule                  — keyword search
 *   dbdoc recurr carer client       — multiple lookups
 *   dbdoc recurr,carer,client       — comma separated
 *   dbdoc list                      — list all table names
 */
import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const descriptions = JSON.parse(
  readFileSync(resolve(__dirname, 'data/tableDescriptions.json'), 'utf8')
);

const raw = process.argv.slice(2).join(' ');
const queries = raw.split(/[\s,]+/).map(q => q.toLowerCase().trim()).filter(Boolean);

if (queries.length === 0) {
  console.log('Usage: dbdoc <table name or keyword>');
  console.log('       dbdoc table1 table2 table3');
  console.log('       dbdoc table1,table2,table3');
  console.log('       dbdoc list');
  process.exit(0);
}

if (queries.length === 1 && queries[0] === 'list') {
  Object.keys(descriptions).forEach(name => console.log(name));
  process.exit(0);
}

for (const query of queries) {
  const exact = Object.entries(descriptions).find(
    ([name]) => name.toLowerCase() === query
  );

  if (exact) {
    console.log(`\n📋 ${exact[0]}\n   ${exact[1]}`);
    continue;
  }

  const matches = Object.entries(descriptions).filter(
    ([name, desc]) =>
      name.toLowerCase().includes(query) ||
      desc.toLowerCase().includes(query)
  );

  if (matches.length === 0) {
    console.log(`\n❌ No tables found for "${query}"`);
    continue;
  }

  console.log(`\n🔍 ${matches.length} result(s) for "${query}":`);
  matches.forEach(([name, desc]) => {
    console.log(`\n📋 ${name}\n   ${desc}`);
  });
}