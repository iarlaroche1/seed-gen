/**
 * @module ticket
 * @description Domain object representing a ticket in this system.
 * Independent of where the ticket came from — Jira, a file, or hardcoded.
 */

/**
 * Creates a clean Ticket domain object.
 * @param {Object} params
 * @param {string} params.id - Ticket ID e.g. "OTB-601"
 * @param {string} params.summary - One line summary
 * @param {string} params.problemStatement - The human written problem description
 * @param {string} params.server - Which server e.g. "Care2"
 * @param {string} params.companyDbNumber - Company DB number e.g. "240"
 * @param {string} params.companyName - Company name e.g. "Sonderwell"
 * @param {string} params.locationId - Location identifier
 * @param {string} params.locationName - Location name
 * @param {string} params.status - Current ticket status
 * @param {string} params.priority - Priority level
 * @param {string} params.assignee - Assigned developer
 * @returns {Object} A clean Ticket object
 */
export function createTicket({ id, summary, problemStatement, server, companyDbNumber, companyName, locationId, locationName, status, priority, assignee }) {
  return {
    id,
    summary,
    problemStatement,
    server,
    companyDbNumber,
    companyName,
    locationId,
    locationName,
    status,
    priority,
    assignee
  };
}