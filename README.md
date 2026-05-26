# seed-gen

AI-powered CLI tool that generates MySQL seed files from Jira tickets for local development environments.

Built as an internship project at [OneTouch Health](https://onetouchhealth.net), Oranmore.

---

## What it does

Developers at OneTouch currently reproduce bugs by working against a shared database containing real user data. This project aims to replace that workflow — given a Jira ticket, the tool fetches the ticket, identifies which database tables are relevant, and generates synthetic SQL seed data to recreate the broken state locally.

---

## Project status

| Step | Status |
|------|--------|
| Jira ticket fetching + parsing | ✅ Done |
| Schema loading (902 tables) | ✅ Done |
| Vector store with hybrid search | ✅ Done |
| Table descriptions (all 902 tables) | ✅ Done |
| `dbdoc` CLI tool | ✅ Done |
| Query rewriting | ⬜ Needs Claude API key |
| Seed SQL generation | ⬜ Needs Claude API key |
| `index.js` entry point | ⬜ Not started |

---

## Architecture

Built with DDD and clean architecture principles. Each domain owns its own logic and the outside world (Jira API, Claude API) lives at the edges.

```
src/
  ticket/
    ticket.js          ← domain object — what a Ticket IS
    ticketParser.js    ← converts raw Jira JSON → Ticket
    jiraClient.js      ← talks to Jira REST API
  schema/
    schemaLoader.js    ← parses 902 tables from cm_fresh.sql
    vectorStore.js     ← embeds tables, hybrid search
  seed/                ← not yet built
data/
  cm_fresh.sql              ← full DB schema dump
  tableDescriptions.json    ← plain English descriptions for all 902 tables
  vectors.json              ← embedded vector store (generated, gitignored)
scripts/
  splitSchema.js       ← splits schema into batches for description generation
  mergeDescriptions.js ← merges batch description files into one
dbdoc.js               ← CLI tool for searching table descriptions
```

---

## dbdoc

A CLI tool for looking up what any table in the OneTouch database does.

### Setup

```bash
# clone the repo
git clone https://github.com/iarlaroche1/seed-gen.git
cd seed-gen
npm install

# install globally
npm install -g .
```

**Windows (PowerShell):** Add this to your `$PROFILE` file:
```powershell
function dbdoc { & "C:\Users\YourName\AppData\Roaming\npm\dbdoc.ps1" @args }
```

**Mac/Linux:** Works immediately after `npm install -g .`

### Usage

```bash
# look up a specific table
dbdoc recurr

# keyword search across all descriptions
dbdoc schedule

# multiple tables at once
dbdoc recurr carer client

# comma separated also works
dbdoc recurr,carer,client

# list all 902 table names
dbdoc list
```

### Example output

```
📋 recurr
   Core table defining recurring visit schedules between carers and clients
   with full scheduling, pay, billing, and shift configuration. Central table
   referenced by timesheets, cancellations, and travel calculations.
```

---

## Setup (full project)

### Prerequisites

- Node.js v18+
- Access to OneTouch VPN (for DB connection, future feature)

### Installation

```bash
git clone https://github.com/iarlaroche1/seed-gen.git
cd seed-gen
npm install
```

### Environment variables

Create a `.env` file in the root:

```
JIRA_TOKEN=your_atlassian_api_token
JIRA_EMAIL=your@email.com
JIRA_BASE_URL=https://onetouchgroup.atlassian.net
ANTHROPIC_API_KEY=your_key_here
```

Generate a Jira API token at [id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens).

### Build the vector store

Run once after cloning to embed all 902 table descriptions:

```bash
node scripts/buildVectors.js
```

---

## Key technical decisions

**Why local embeddings?** The Anthropic API key wasn't available during development so `Xenova/all-MiniLM-L6-v2` is used locally. The `embed()` function in `vectorStore.js` is the only thing that needs to change when swapping to a better model.

**Why hybrid search?** Pure vector search misses domain-specific abbreviated table names like `recurr`. Combining vector similarity (60%) with keyword matching on camelCase-split column names (40%) catches these cases.

**Why table descriptions?** Embedding raw SQL gives poor results — the model doesn't understand that `carerId int(11)` relates to scheduling. Plain English descriptions (generated via Claude UI for all 902 tables) dramatically improve search quality, raising max scores from 0.38 to 0.54.

**Why query rewriting?** Jira tickets describe symptoms from a user perspective. Vector search works better with data-focused queries. A query rewriting step using Claude translates "carer cannot see their schedule" into "recurring scheduled visits carer client" before searching.

---

## Limitations

- Only useful for **data-layer bugs** — bugs caused by code logic can't be reproduced by seeding
- `cm_fresh.sql` is a static schema dump — will go stale if the schema changes. Future fix: replace with live `information_schema` queries once direct DB access is available
- Query rewriting and seed generation require an Anthropic API key

---

## Built with

- [Node.js](https://nodejs.org/)
- [@xenova/transformers](https://github.com/xenova/transformers.js) — local embeddings
- [mysql2](https://github.com/sidorares/node-mysql2) — MySQL client
- [dotenv](https://github.com/motdotla/dotenv) — environment variables
- [Jira REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/)