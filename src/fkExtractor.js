#!/usr/bin/env node
/**
 * @module fkExtractor
 * @description Parses FOREIGN KEY constraints from the schema SQL, builds a
 * dependency graph, performs topological sort for insertion-safe ordering,
 * and detects circular dependencies. Writes data/fkGraph.json when run directly.
 */
import { readFileSync, writeFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

const TABLE_REGEX = /CREATE TABLE `(\w+)` \([\s\S]*?\) ENGINE=[\s\S]*?;/g;
const FK_REGEX = /FOREIGN KEY \(`(\w+)`\) REFERENCES `(\w+)` \(`(\w+)`\)/g;

/**
 * Parses all FOREIGN KEY constraints from a SQL schema string.
 * @param {string} sql
 * @returns {{ [tableName: string]: Array<{column: string, referencesTable: string, referencesColumn: string}> }}
 */
export function extractForeignKeys(sql) {
  const fkMap = {};
  TABLE_REGEX.lastIndex = 0;
  let tableMatch;

  while ((tableMatch = TABLE_REGEX.exec(sql)) !== null) {
    const tableName = tableMatch[1];
    const tableSQL = tableMatch[0];
    const fks = [];

    FK_REGEX.lastIndex = 0;
    let fkMatch;
    while ((fkMatch = FK_REGEX.exec(tableSQL)) !== null) {
      fks.push({
        column: fkMatch[1],
        referencesTable: fkMatch[2],
        referencesColumn: fkMatch[3],
      });
    }

    if (fks.length > 0) fkMap[tableName] = fks;
  }

  return fkMap;
}

/**
 * Topological sort of tables by FK dependency (Kahn's BFS).
 * Tables with no prerequisites come first (safe to insert first).
 * Tables involved in cycles are appended at the end in sorted order.
 * @param {{ [tableName: string]: Array<{referencesTable: string}> }} fkMap
 * @returns {string[]}
 */
export function topologicalSort(fkMap) {
  const allTables = new Set(Object.keys(fkMap));
  for (const fks of Object.values(fkMap)) {
    for (const { referencesTable } of fks) allTables.add(referencesTable);
  }

  // adjacency[X] = tables that must come AFTER X
  const adjacency = {};
  const inDegree = {};
  for (const t of allTables) {
    adjacency[t] = [];
    inDegree[t] = 0;
  }

  const seenEdges = new Set();
  for (const [table, fks] of Object.entries(fkMap)) {
    for (const { referencesTable } of fks) {
      if (referencesTable === table) continue; // self-references don't affect order
      const edge = `${referencesTable}=>${table}`;
      if (!seenEdges.has(edge)) {
        seenEdges.add(edge);
        adjacency[referencesTable].push(table);
        inDegree[table]++;
      }
    }
  }

  const queue = [...allTables].filter(t => inDegree[t] === 0).sort();
  const order = [];

  while (queue.length > 0) {
    const table = queue.shift();
    order.push(table);
    for (const dependent of adjacency[table].sort()) {
      if (--inDegree[dependent] === 0) queue.push(dependent);
    }
  }

  // Tables not reached by Kahn's are part of cycles — append sorted
  const cycleNodes = [...allTables].filter(t => !order.includes(t)).sort();
  return [...order, ...cycleNodes];
}

/**
 * Detects circular FK dependencies using DFS with path tracking.
 * Returns deduplicated cycles as arrays of table names (each cycle is a loop,
 * the first element repeats as the last to show closure: [A, B, C] means A→B→C→A).
 * @param {{ [tableName: string]: Array<{referencesTable: string}> }} fkMap
 * @returns {string[][]}
 */
export function detectCycles(fkMap) {
  const dependsOn = {};
  const allTables = new Set();

  for (const [table, fks] of Object.entries(fkMap)) {
    allTables.add(table);
    dependsOn[table] = [...new Set(
      fks
        .filter(fk => fk.referencesTable !== table)
        .map(fk => fk.referencesTable)
    )];
    for (const ref of dependsOn[table]) allTables.add(ref);
  }

  const WHITE = 0, GRAY = 1, BLACK = 2;
  const color = Object.fromEntries([...allTables].map(t => [t, WHITE]));
  const rawCycles = [];

  function dfs(table, path) {
    color[table] = GRAY;
    path.push(table);
    for (const dep of (dependsOn[table] || [])) {
      if (color[dep] === GRAY) {
        const start = path.indexOf(dep);
        rawCycles.push(path.slice(start)); // dep appears at start; closing edge dep is implied
      } else if (color[dep] === WHITE) {
        dfs(dep, path);
      }
    }
    path.pop();
    color[table] = BLACK;
  }

  for (const table of allTables) {
    if (color[table] === WHITE) dfs(table, []);
  }

  // Deduplicate: normalize by rotating each cycle to start at the lexicographically smallest name
  const seen = new Set();
  const cycles = [];
  for (const cycle of rawCycles) {
    const minIdx = cycle.reduce((mi, t, i) => (t < cycle[mi] ? i : mi), 0);
    const key = [...cycle.slice(minIdx), ...cycle.slice(0, minIdx)].join('->');
    if (!seen.has(key)) {
      seen.add(key);
      cycles.push(cycle);
    }
  }

  return cycles;
}

// Generate fkGraph.json when run directly
const isMain = resolve(fileURLToPath(import.meta.url)) === resolve(process.argv[1] ?? '');
if (isMain) {
  const schemaPath = resolve(__dirname, '../data/cm_fresh.sql');
  const outputPath = resolve(__dirname, '../data/fkGraph.json');

  const sql = readFileSync(schemaPath, 'utf8');
  const fkMap = extractForeignKeys(sql);

  const fkCount = Object.values(fkMap).reduce((sum, fks) => sum + fks.length, 0);
  console.log(`Found ${fkCount} FK constraints across ${Object.keys(fkMap).length} tables.`);

  const selfReferences = [];
  for (const [table, fks] of Object.entries(fkMap)) {
    for (const fk of fks) {
      if (fk.referencesTable === table) selfReferences.push(table);
    }
  }
  if (selfReferences.length > 0) {
    console.log(`Self-referencing tables (${selfReferences.length}): ${[...new Set(selfReferences)].join(', ')}`);
  }

  const insertionOrder = topologicalSort(fkMap);
  const cycles = detectCycles(fkMap);

  if (cycles.length > 0) {
    console.warn(`\nWarning: ${cycles.length} circular FK dependency cycle(s) detected:`);
    for (const cycle of cycles) {
      console.warn(`  ${cycle.join(' -> ')} -> ${cycle[0]}`);
    }
  } else {
    console.log('No circular dependencies detected.');
  }

  writeFileSync(outputPath, JSON.stringify({ fkMap, insertionOrder, cycles, selfReferences: [...new Set(selfReferences)] }, null, 2));
  console.log(`\nWritten to ${outputPath}`);
}
