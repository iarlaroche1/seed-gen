/**
 * @module vectorStore
 * @description Handles embedding and similarity search for table schemas.
 * Converts table definitions into vectors using a local Hugging Face model,
 * stores them locally as JSON, and searches them by similarity to a query.
 * 
 * Currently uses Xenova/all-MiniLM-L6-v2 running locally — no API calls needed.
 * To swap to Anthropic embeddings when API access is available, only the
 * embed() function needs to change — nothing else in the system is affected.
 * To scale to a proper vector DB later, only this file needs to change.
 */
import { writeFileSync, readFileSync, existsSync } from 'fs';
import { pipeline } from '@xenova/transformers';
import 'dotenv/config';

const STORE_PATH = './data/vectors.json';

let embedder = null;

/**
 * Lazily loads the local embedding model on first use.
 * Downloads the model files on first run (~25mb), then caches them locally.
 * @returns {Promise<Function>} The embedding pipeline
 */
async function getEmbedder() {
  if (!embedder) {
    console.log('Loading embedding model (downloads on first run)...');
    embedder = await pipeline('feature-extraction', 'Xenova/all-MiniLM-L6-v2');
  }
  return embedder;
}

/**
 * Converts a string of text into a vector using a local embedding model.
 * @param {string} text - The text to embed
 * @returns {Promise<number[]>} A vector of numbers representing the text
 */
async function embed(text) {
  const embedder = await getEmbedder();
  const output = await embedder(text, { pooling: 'mean', normalize: true });
  return Array.from(output.data);
}

/**
 * Calculates cosine similarity between two vectors.
 * Returns a value between 0 and 1 — closer to 1 means more similar.
 * This is how we measure how relevant a table is to a ticket.
 * @param {number[]} a - First vector
 * @param {number[]} b - Second vector
 * @returns {number} Similarity score between 0 and 1
 */
function cosineSimilarity(a, b) {
  const dot = a.reduce((sum, val, i) => sum + val * b[i], 0);
  const magA = Math.sqrt(a.reduce((sum, val) => sum + val * val, 0));
  const magB = Math.sqrt(b.reduce((sum, val) => sum + val * val, 0));
  return dot / (magA * magB);
}

/**
 * Builds the vector store from an array of table objects.
 * Embeds each table's description (from tableDescriptions.json) if available,
 * falling back to the raw SQL. Descriptions embed much better than raw SQL
 * because they use natural language the embedding model understands.
 * Only needs to be run once, or when the schema or descriptions change.
 * @param {Array<{name: string, sql: string}>} tables - Array of table objects from schemaLoader
 * @returns {Promise<void>}
 */
export async function buildVectorStore(tables) {
  const descriptions = JSON.parse(readFileSync('./data/tableDescriptions.json', 'utf8'));

  console.log(`Embedding ${tables.length} tables — this may take a minute...`);
  const store = [];

  for (let i = 0; i < tables.length; i++) {
    const table = tables[i];
    process.stdout.write(`\r${i + 1}/${tables.length} — ${table.name}`);
    const textToEmbed = descriptions[table.name] 
      ? `Table: ${table.name}. ${descriptions[table.name]}`
      : table.sql;
    const vector = await embed(textToEmbed);
    store.push({ name: table.name, sql: table.sql, vector });
  }

  writeFileSync(STORE_PATH, JSON.stringify(store));
  console.log(`\nVector store saved to ${STORE_PATH}`);
}

/**
 * Searches the vector store for tables most relevant to a query string.
 * Combines vector similarity with keyword matching for better results.
 * @param {string} query - Natural language query e.g. ticket description
 * @param {number} topK - Number of results to return (default 10)
 * @returns {Promise<Array<{name: string, sql: string, score: number}>>}
 */
export async function searchVectorStore(query, topK = 10) {
  const store = JSON.parse(readFileSync(STORE_PATH, 'utf8'));
  const queryVector = await embed(query);

  return store
    .map(entry => {
      const vecScore = cosineSimilarity(queryVector, entry.vector);
      const kwScore = keywordScore(query, entry.name, entry.sql);
      const combined = (vecScore * 0.6) + (kwScore * 0.4);

      return {
        name: entry.name,
        sql: entry.sql,
        score: combined
      };
    })
    .sort((a, b) => b.score - a.score)
    .slice(0, topK);
}

/**
 * Returns true if the vector store file already exists on disk.
 * Used to avoid rebuilding unnecessarily.
 * @returns {boolean}
 */
export function vectorStoreExists() {
  return existsSync(STORE_PATH);
}

/**
 * Scores a table based on keyword matches between the query and
 * the table name and column names. Splits camelCase names into
 * individual words before matching.
 * Complements vector search by catching domain-specific abbreviations
 * like 'recurr' that the embedding model won't recognise.
 * @param {string} query - The search query
 * @param {string} tableName - The table name
 * @param {string} tableSql - The full CREATE TABLE SQL
 * @returns {number} A score between 0 and 1
 */
function keywordScore(query, tableName, tableSql) {
  // split camelCase into individual words
  const splitCamel = str => str
    .replace(/([a-z])([A-Z])/g, '$1 $2')
    .toLowerCase()
    .split(/\s+/);

  const queryWords = splitCamel(query);

  // extract all column names from the SQL
  const columnMatches = tableSql.match(/`(\w+)`/g) || [];
  const columnWords = columnMatches.flatMap(c => splitCamel(c.replace(/`/g, '')));

  // combine table name words and column words
  const tableWords = [...splitCamel(tableName), ...columnWords];

  // count how many query words appear in the table words
  const matches = queryWords.filter(word => 
    word.length > 2 && tableWords.includes(word)
  );

  return matches.length / queryWords.length;
}