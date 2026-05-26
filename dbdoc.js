#!/usr/bin/env node
/**
 * @module dbdoc
 * @description CLI tool for searching OneTouch Health table descriptions.
 * Searches tableDescriptions.json by table name or keyword.
 * 
 * Usage:
 *   dbdoc recurr                 — exact table lookup
 *   dbdoc schedule               — keyword search across all descriptions
 *   dbdoc list                   — list all table names
 */
import { readFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const descriptions = JSON.parse(
  readFileSync(resolve(__dirname, 'data/tableDescriptions.json'), 'utf8')
);

const query = process.argv.slice(2).join(' ').toLowerCase().trim();

if (!query) {
  console.log('Usage: dbdoc <table name or keyword>');
  console.log('       dbdoc list');
  process.exit(0);
}

if (query === 'list') {
  Object.keys(descriptions).forEach(name => console.log(name));
  process.exit(0);
}

// exact match first
const exact = Object.entries(descriptions).find(
  ([name]) => name.toLowerCase() === query
);

if (exact) {
  console.log(`\n📋 ${exact[0]}\n${exact[1]}\n`);
  process.exit(0);
}

// keyword search across names and descriptions
const matches = Object.entries(descriptions).filter(
  ([name, desc]) =>
    name.toLowerCase().includes(query) ||
    desc.toLowerCase().includes(query)
);

if (matches.length === 0) {
  console.log(`No tables found for "${query}"`);
  process.exit(0);
}

console.log(`\n🔍 ${matches.length} result(s) for "${query}":\n`);
matches.forEach(([name, desc]) => {
  console.log(`📋 ${name}\n   ${desc}\n`);
});