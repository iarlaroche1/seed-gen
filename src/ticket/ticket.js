/**
 * @module ticket
 * @description Domain object representing a ticket in this system.
 * This is the core definition of what a Ticket IS — independent of
 * where it came from (Jira, a file, hardcoded etc).
 * If the ticket source ever changes, this file stays the same.
 */

/**
 * Creates a clean Ticket domain object.
 * @param {Object} params
 * @param {string} params.id - The ticket ID e.g. "OTB-601"
 * @param {string} params.summary - One line summary of the ticket
 * @param {string} params.description - Full plaintext description
 * @param {string} params.status - Current status e.g. "In Progress"
 * @param {string} params.priority - Priority level e.g. "Minor"
 * @param {string} params.assignee - Name of the assigned developer
 * @returns {Object} A clean Ticket object
 */
export function createTicket({ id, summary, description, status, priority, assignee }) {
  return {
    id,
    summary,
    description,
    status,
    priority,
    assignee
  };
}