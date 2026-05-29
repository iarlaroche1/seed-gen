#!/usr/bin/env node
/**
 * @module scanJiraTickets
 * @description Fetches a batch of Jira tickets from any project and extracts
 * the vocabulary developers use when describing bugs. The output bridges
 * ticket language to database table names for better vector search results.
 *
 * Outputs:
 *   data/ticketVocabulary.json  — top words and bigrams by frequency
 *   data/ticketSample.json      — cleaned ticket text for inspection
 *
 * Usage: node scripts/scanJiraTickets.js [PROJECT_KEYS]
 *   e.g. node scripts/scanJiraTickets.js                   # scans OTR, OTD, OTB
 *        node scripts/scanJiraTickets.js OTR,OTD,OTB,CM    # scans all four
 * Requires JIRA_TOKEN, JIRA_EMAIL, JIRA_BASE_URL in .env
 */
import 'dotenv/config';
import { writeFileSync } from 'fs';
import { resolve, dirname } from 'path';
import { fileURLToPath } from 'url';
import { extractText } from '../src/ticket/ticketParser.js';

const __dirname = dirname(fileURLToPath(import.meta.url));

const token    = process.env.JIRA_TOKEN;
const email    = process.env.JIRA_EMAIL;
const baseUrl  = process.env.JIRA_BASE_URL;

if (!token || !email || !baseUrl) {
  console.error('Missing required env vars: JIRA_TOKEN, JIRA_EMAIL, JIRA_BASE_URL');
  process.exit(1);
}

const AUTH = `Basic ${btoa(`${email}:${token}`)}`;
const HEADERS = { Authorization: AUTH, Accept: 'application/json' };

const PROJECTS = (process.argv[2] || 'OTR,OTD,OTB')  // default: all three projects
  .split(',')
  .map(p => p.trim().toUpperCase())
  .filter(Boolean);

// ─── Jira search ────────────────────────────────────────────────────────────

const BASE = baseUrl.replace(/\/$/, '');

// Lists all projects the current API token can access.
// Run once at startup so we can validate PROJECTS and surface the real keys.
async function discoverProjects() {
  const url = `${BASE}/rest/api/3/project/search?maxResults=50`;
  const res = await fetch(url, { headers: HEADERS });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`Project discovery failed: ${res.status} ${res.statusText}\n${body}`);
  }
  const data = await res.json();
  return (data.values ?? []).map(p => ({ key: p.key, name: p.name }));
}

async function searchIssues(startAt, maxResults, projects) {
  const jql = encodeURIComponent(`project IN (${projects.join(', ')}) AND issuetype = Bug ORDER BY created DESC`);
  const url = `${BASE}/rest/api/3/search/jql?jql=${jql}&maxResults=${maxResults}&startAt=${startAt}&fields=summary,description,status,priority,assignee,issuetype`;
  console.log('  GET', url);
  const res = await fetch(url, { headers: HEADERS });
  if (!res.ok) {
    const body = await res.text();
    throw new Error(`Jira search failed: ${res.status} ${res.statusText}\n${body}`);
  }
  return res.json();
}

// ─── Description cleaning ────────────────────────────────────────────────────

// Mirrors the cleanDescription logic in src/ticket/ticketParser.js.
// Duplicated here deliberately — this script must not import private helpers
// that aren't exported, and cleanDescription is not exported from ticketParser.
const CUTOFF_RE = /Company DB Number|Server \(|Location ID|Steps to Replicate|URLs:|Screenshots|Governance ID/i;
const METADATA_RE = /https?:\/\/|Problem Statement\s*\(Please include[^)]*\)\s*:?|PDF attached to Jira Task/gi;

function cleanDescription(text) {
  const cutoff = text.search(CUTOFF_RE);
  const prose = cutoff !== -1 ? text.slice(0, cutoff) : text;
  return prose.replace(METADATA_RE, '').replace(/\s+/g, ' ').trim();
}

// ─── Vocabulary extraction ───────────────────────────────────────────────────

const STOP_WORDS = new Set([
  'a','an','the','and','or','but','in','on','at','to','for','of','with',
  'by','from','is','it','its','as','be','was','are','were','been','has',
  'have','had','will','would','could','should','may','might','can','do',
  'does','did','not','no','so','if','this','that','these','those','their',
  'they','them','we','our','you','your','he','she','his','her','i','me',
  'my','up','out','about','when','which','who','how','what','all','also',
  'into','than','then','just','now','only','even','any','each','after',
  'before','between','because','there','here','more','other','some','such',
  'same','still','back','off','get','set','page','using','used','been',
  'being','through',
]);

// Domain-irrelevant metadata words that appear frequently but carry no signal.
const NOISE_WORDS = new Set([
  'company','server','location','steps','url','screenshot','vimeo',
  'care1','care2','care3','care4','hcm','otr','jira','task','attached',
  'governance','number','id','name','please','include','problem',
  'statement','expected','behaviour','replicate',
]);

function tokenise(text) {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter(w => w.length > 2 && !STOP_WORDS.has(w) && !NOISE_WORDS.has(w));
}

function countFrequencies(tokens) {
  const freq = {};
  for (const t of tokens) freq[t] = (freq[t] || 0) + 1;
  return freq;
}

function extractBigrams(tokens) {
  const freq = {};
  for (let i = 0; i < tokens.length - 1; i++) {
    const phrase = `${tokens[i]} ${tokens[i + 1]}`;
    freq[phrase] = (freq[phrase] || 0) + 1;
  }
  return freq;
}

function topN(freqMap, n) {
  return Object.entries(freqMap)
    .sort((a, b) => b[1] - a[1])
    .slice(0, n);
}

// ─── Main ────────────────────────────────────────────────────────────────────

const PAGE_SIZE   = 50;
const MAX_TICKETS = 100;

// Discover accessible projects first so we can validate and surface the real keys.
console.log('Discovering accessible Jira projects…');
const accessible = await discoverProjects();
console.log(`Accessible projects (${accessible.length}):`);
accessible.forEach(p => console.log(`  ${p.key.padEnd(12)} ${p.name}`));

const accessibleKeys = new Set(accessible.map(p => p.key));
const validProjects = PROJECTS.filter(p => accessibleKeys.has(p));
const invalidProjects = PROJECTS.filter(p => !accessibleKeys.has(p));

if (invalidProjects.length > 0) {
  console.warn(`\nWarning: project key(s) not found or not accessible: ${invalidProjects.join(', ')}`);
}
if (validProjects.length === 0) {
  console.error('No valid projects to search. Exiting.');
  process.exit(1);
}

console.log(`\nSearching projects: ${validProjects.join(', ')}\n`);

const tickets = [];

for (let startAt = 0; startAt < MAX_TICKETS; startAt += PAGE_SIZE) {
  const want = Math.min(PAGE_SIZE, MAX_TICKETS - startAt);
  console.log(`Fetching tickets ${startAt + 1}–${startAt + want}…`);

  const data = await searchIssues(startAt, want, validProjects);
  const issues = data.issues ?? [];

  // Log issue types on the first page so we know what's available in this project.
  if (startAt === 0) {
    const types = [...new Set(issues.map(i => i.fields.issuetype?.name).filter(Boolean))];
    console.log(`  Issue types found: ${types.join(', ')}`);
  }

  for (const issue of issues) {
    const rawText = issue.fields.description ? extractText(issue.fields.description) : '';
    const problemStatement = cleanDescription(rawText);
    tickets.push({
      id: issue.key,
      summary: issue.fields.summary ?? '',
      problemStatement,
    });
  }

  console.log(`  → ${tickets.length} tickets collected so far`);

  // Stop early if Jira returned fewer results than requested (end of results).
  if (issues.length < want) break;
}

console.log(`\nTotal tickets fetched: ${tickets.length}`);

// Build combined token stream across all tickets.
const allTokens = tickets.flatMap(t =>
  tokenise(`${t.summary} ${t.problemStatement}`)
);

console.log(`Total tokens extracted: ${allTokens.length}`);

const wordFreq   = countFrequencies(allTokens);
const bigramFreq = extractBigrams(allTokens);

const topWords   = topN(wordFreq,   100).map(([word, count])     => ({ word, count }));
const topBigrams = topN(bigramFreq,  50).map(([phrase, count])   => ({ phrase, count }));

// Write outputs.
const vocabPath  = resolve(__dirname, '../data/ticketVocabulary.json');
const samplePath = resolve(__dirname, '../data/ticketSample.json');

writeFileSync(vocabPath,  JSON.stringify({ words: topWords, bigrams: topBigrams }, null, 2));
writeFileSync(samplePath, JSON.stringify(tickets, null, 2));

console.log(`\nTop 20 words:`);
topWords.slice(0, 20).forEach(({ word, count }) =>
  console.log(`  ${count.toString().padStart(4)}  ${word}`)
);

console.log(`\nVocabulary: ${topWords.length} words, ${topBigrams.length} bigrams`);
console.log(`Written to ${vocabPath}`);
console.log(`Written to ${samplePath}`);
