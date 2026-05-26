/**
 * @module ticketParser
 * @description Translates raw Jira API responses into clean Ticket domain objects.
 * Jira returns descriptions in Atlassian Document Format (ADF) — a deeply nested
 * JSON structure. This module flattens that into plain text and picks out only
 * the fields the rest of the system cares about.
 * This is the only file that should know about Jira's data format.
 */

/**
 * Recursively extracts plain text from an Atlassian Document Format (ADF) node.
 * ADF is Jira's rich text format — descriptions come back as nested JSON
 * rather than plain strings. This function walks the tree and pulls out the text.
 * @param {Object} adfNode - A single node from the ADF document tree
 * @returns {string} Plain text extracted from the node and all its children
 */
export function extractText(adfNode) {
  if (!adfNode) return '';
  if (adfNode.type === 'text') return adfNode.text || '';
  if (adfNode.type === 'hardBreak') return '\n';
  if (adfNode.content) {
    return adfNode.content.map(extractText).join('');
  }
  return '';
}

/**
 * Converts a raw Jira API response into a clean Ticket domain object.
 * Strips out the hundreds of unused fields Jira returns and produces
 * only what this system needs.
 * @param {Object} raw - The raw JSON response from the Jira REST API
 * @returns {Object} A clean Ticket object matching the shape defined in ticket.js
 */
export function parseTicket(raw) {
  return {
    id: raw.key,
    summary: raw.fields.summary,
    description: extractText(raw.fields.description),
    status: raw.fields.status?.name,
    priority: raw.fields.priority?.name,
    assignee: raw.fields.assignee?.displayName,
  };
}