/**
 * @module schemaLoader
 * @description Reads cm_fresh.sql and splits it into individual
 * table definitions. Each table definition is a self contained
 * CREATE TABLE statement that can be embedded and searched.
 * 
 * NOTE: This uses a static file which can go stale if the schema changes.
 * Future improvement: replace with live DB introspection via information_schema
 * once direct DB access is available from local machine.
 */
import { readFileSync } from 'fs';

/**
 * Reads the schema SQL file and extracts individual table definitions.
 * Ignores everything that isn't a CREATE TABLE statement.
 * @param {string} filePath - Path to the SQL schema file
 * @returns {Array<{name: string, sql: string}>} Array of table objects
 */
export function loadSchema(filePath) {
  const sql = readFileSync(filePath, 'utf8');
  const tables = [];

  const regex = /CREATE TABLE `(\w+)` \([\s\S]*?\) ENGINE=[\s\S]*?;/g;
  let match;

  while ((match = regex.exec(sql)) !== null) {
    tables.push({
      name: match[1],
      sql: match[0]
    });
  }

  return tables;
}