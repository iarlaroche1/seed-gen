import { getTicket } from './jira.js';

const ticket = await getTicket('OTB-601');
console.log(JSON.stringify(ticket, null, 2));