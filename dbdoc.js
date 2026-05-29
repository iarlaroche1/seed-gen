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
 *   dbdoc fks <tableName>           — show FK relationships for a table
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
  console.log('       dbdoc fks <tableName>');
  process.exit(0);
}

if (queries[0] === 'fks') {
  const target = queries[1];
  if (!target) {
    console.log('Usage: dbdoc fks <tableName>');
    process.exit(1);
  }

  let fkGraph;
  try {
    fkGraph = JSON.parse(readFileSync(resolve(__dirname, 'data/fkGraph.json'), 'utf8'));
  } catch {
    console.log('fkGraph.json not found. Run: node src/fkExtractor.js');
    process.exit(1);
  }

  const { fkMap } = fkGraph;
  const allKnownTables = new Set([
    ...Object.keys(fkMap),
    ...Object.values(fkMap).flat().map(fk => fk.referencesTable),
  ]);
  const tableName = [...allKnownTables].find(t => t.toLowerCase() === target.toLowerCase());

  if (!tableName) {
    console.log(`No FK relationships found for "${target}"`);
    process.exit(0);
  }

  const outgoing = fkMap[tableName] || [];
  if (outgoing.length > 0) {
    const byRef = {};
    for (const fk of outgoing) {
      (byRef[fk.referencesTable] = byRef[fk.referencesTable] || []).push(fk);
    }
    console.log(`\n${tableName} depends on (${Object.keys(byRef).length}):`);
    for (const ref of Object.keys(byRef).sort()) {
      const cols = byRef[ref].map(fk => `${fk.column} -> ${ref}.${fk.referencesColumn}`).join(', ');
      console.log(`  ${ref}  [${cols}]`);
    }
  } else {
    console.log(`\n${tableName} has no outgoing foreign keys.`);
  }

  const incoming = [];
  for (const [t, fks] of Object.entries(fkMap)) {
    for (const fk of fks) {
      if (fk.referencesTable === tableName) incoming.push({ table: t, ...fk });
    }
  }
  if (incoming.length > 0) {
    const byTable = {};
    for (const fk of incoming) {
      (byTable[fk.table] = byTable[fk.table] || []).push(fk);
    }
    console.log(`\n${tableName} is referenced by (${Object.keys(byTable).length}):`);
    for (const t of Object.keys(byTable).sort()) {
      const cols = byTable[t].map(fk => `${fk.table}.${fk.column} -> ${fk.referencesColumn}`).join(', ');
      console.log(`  ${t}  [${cols}]`);
    }
  } else {
    console.log(`\n${tableName} is not referenced by any other table.`);
  }

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