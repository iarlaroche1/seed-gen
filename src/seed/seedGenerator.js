import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// Columns auto-managed by the ORM / DB — skip them in INSERT statements.
const BOILERPLATE_COLS = new Set([
  'id', 'created', 'deleted', 'createdBy', 'deletedBy', 'updated', 'updatedBy',
]);

// Parses column definitions from a CREATE TABLE SQL string.
// Returns [{ name, type }] in declaration order, excluding boilerplate columns
// and any lines that don't look like column definitions (KEY, CONSTRAINT, etc.).
function parseColumns(createTableSql) {
  const body = createTableSql
    .replace(/^CREATE TABLE `\w+` \(/i, '')
    .replace(/\) ENGINE=[\s\S]*$/, '');

  const columns = [];
  for (const rawLine of body.split('\n')) {
    const line = rawLine.trim();
    if (!line || line.startsWith('--')) continue;

    // Column definition lines start with a backtick-quoted name.
    const colMatch = line.match(/^`(\w+)`\s+(\w+)/);
    if (!colMatch) continue;

    const [, name, type] = colMatch;
    if (BOILERPLATE_COLS.has(name)) continue;
    columns.push({ name, type: type.toLowerCase() });
  }

  return columns;
}

// Returns a sensible SQL placeholder value for a column based on name/type heuristics.
// Ticket context (companyDbNumber, locationId) is wired in for the two most common FKs.
function placeholderFor(colName, colType, ticket) {
  const n = colName.toLowerCase();

  if (n === 'companyid' || n === 'companydbnumber') {
    return ticket?.companyDbNumber ?? 1;
  }
  if (n === 'locationid') {
    return ticket?.locationId ?? 1;
  }
  if (n === 'clientid') return 9001;
  if (n === 'carerid') return 8001;

  if (n.includes('name') || n.includes('fname') || n.includes('sname')) {
    return `'Test'`;
  }
  if (n.includes('date')) return 'CURDATE()';
  if (n.includes('time')) return 'CURTIME()';

  // Type-based fallbacks
  if (colType === 'varchar' || colType === 'text' || colType === 'tinytext' ||
      colType === 'mediumtext' || colType === 'longtext' || colType === 'char' ||
      colType === 'enum') {
    return `'seed-gen-placeholder'`;
  }
  if (colType === 'float' || colType === 'double' ||
      colType === 'decimal' || colType === 'numeric') {
    return '0.00';
  }
  // int, tinyint, smallint, mediumint, bigint, bit, boolean, year
  return 1;
}

// Builds a single INSERT statement for one table.
function buildInsert(tableName, createTableSql, ticket) {
  const columns = parseColumns(createTableSql);
  if (columns.length === 0) {
    return `-- INSERT INTO \`${tableName}\` — no non-boilerplate columns found`;
  }

  const colList = columns.map(c => `\`${c.name}\``).join(', ');
  const valList = columns.map(c => placeholderFor(c.name, c.type, ticket)).join(', ');
  return `INSERT INTO \`${tableName}\` (${colList})\nVALUES (${valList});`;
}

/**
 * Generates a structured MySQL seed file for the matched tables.
 *
 * @param {object} opts
 * @param {object|null}   opts.ticket     - Parsed ticket (id, summary, companyDbNumber, locationId)
 * @param {Array}         opts.tables     - [{ name, score, description }] from vector search
 * @param {object}        opts.fkGraph    - Full fkGraph object (insertionOrder, fkMap, …)
 * @param {object}        opts.schemaMap  - { tableName: createTableSQL } for all schema tables
 * @returns {{ sql: string, tablesUsed: string[], ticketId: string|null, stubbed: true }}
 */
export function generateSeed({ ticket, tables, fkGraph, schemaMap }) {
  const matchedNames = new Set(tables.map(t => t.name));
  const { insertionOrder = [] } = fkGraph;

  // Respect FK insertion order — keep only matched tables, parents before children.
  const sorted = insertionOrder.filter(name => matchedNames.has(name));

  // Any matched tables not in insertionOrder (shouldn't happen, but be safe) go last.
  for (const t of tables) {
    if (!sorted.includes(t.name)) sorted.push(t.name);
  }

  const ticketId = ticket?.id ?? null;
  const timestamp = new Date().toISOString();

  const header = [
    `-- seed-gen · ${ticketId ?? 'no-ticket'}`,
    `-- generated: ${timestamp}`,
    `-- tables: ${sorted.join(', ')}`,
    `-- NOTE: AI generation not yet enabled.`,
    `--       Values are structural placeholders only.`,
  ].join('\n');

  const inserts = sorted.map(name => {
    const ddl = schemaMap[name];
    if (!ddl) return `-- WARNING: no DDL found for \`${name}\``;
    return buildInsert(name, ddl, ticket);
  });

  const sql = [
    header,
    '',
    'SET FOREIGN_KEY_CHECKS=0;',
    '',
    inserts.join('\n\n'),
    '',
    'SET FOREIGN_KEY_CHECKS=1;',
  ].join('\n');

  return { sql, tablesUsed: sorted, ticketId, stubbed: true };
}
