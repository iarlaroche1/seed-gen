import { searchVectorStore } from './src/schema/vectorStore.js';

const results = await searchVectorStore('carer cannot see their schedule', 10);

results.forEach(r => {
  console.log(`${r.score.toFixed(3)} — ${r.name}`);
});