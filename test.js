import { getTicket } from './src/ticket/jiraClient.js';
import { parseTicket } from './src/ticket/ticketParser.js';
import { createTicket } from './src/ticket/ticket.js';

// Fetch raw data from Jira
const raw = await getTicket('OTB-601');

// Translate raw Jira JSON into a clean ticket object
const parsed = parseTicket(raw);

// Create the domain object
const ticket = createTicket(parsed);

console.log(ticket);