import { getTicket } from './src/ticket/jiraClient.js';
import { parseTicket } from './src/ticket/ticketParser.js';
import { createTicket } from './src/ticket/ticket.js';

// Fetch raw data from Jira
const raw = await getTicket('OTB-601'); // from './src/ticket/jiraClient.js'

// Translate raw Jira JSON into a clean ticket object
const parsed = parseTicket(raw);        // from './src/ticket/ticketParser.js'

// Create the domain object
const ticket = createTicket(parsed);    // from './src/ticket/ticket.js'

console.log(ticket);