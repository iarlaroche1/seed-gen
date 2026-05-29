/**
 * @module jiraClient
 * @description Handles all HTTP communication with the Jira REST API.
 * This is the only file in the system that talks to Jira directly.
 * It reads credentials from environment variables so they are never
 * hardcoded or committed to version control.
 *
 * In clean architecture terms this is an "infrastructure" file —
 * it lives at the outer layer and knows about the outside world,
 * but the rest of the system does not depend on it directly.
 *
 * Credentials required in .env:
 *   JIRA_TOKEN     - Atlassian personal API token
 *   JIRA_EMAIL     - Atlassian account email
 *   JIRA_BASE_URL  - e.g. https://onetouchgroup.atlassian.net
 */
import 'dotenv/config';
// get credentials from.env
const token = process.env.JIRA_TOKEN;
const email = process.env.JIRA_EMAIL;
const baseUrl = process.env.JIRA_BASE_URL;

/**
 * Fetches a single Jira ticket by ID from the Jira REST API.
 * Returns the full raw API response — use ticketParser.js to
 * convert this into a clean Ticket domain object.
 * @param {string} ticketId - The Jira ticket ID e.g. "OTB-601"
 * @returns {Promise<Object>} Raw Jira API response as a JSON object
 * @throws {Error} If the API request fails or returns a non-OK status
 */
export async function getTicket(ticketId) {
  const response = await fetch(`${baseUrl}/rest/api/3/issue/${ticketId}`, {
    headers: {
      'Authorization': `Basic ${btoa(`${email}:${token}`)}`,
      'Accept': 'application/json'
    }
  });

  if (!response.ok) {
    throw new Error(`Jira API error: ${response.status} ${response.statusText}`);
  }

  return await response.json();
}

/**
 * Fetches comments for a Jira ticket and returns them as plain text strings.
 * Comments are in ADF format — each body is extracted and cleaned the same way
 * as ticket descriptions to strip metadata noise before embedding.
 * @param {string} ticketId - The Jira ticket ID e.g. "OTB-601"
 * @returns {Promise<Array<{text: string, created: string}>>} Comment bodies as plain text, newest first
 * @throws {Error} If the API request fails or returns a non-OK status
 */
export async function getTicketComments(ticketId) {
  const response = await fetch(
    `${baseUrl}/rest/api/3/issue/${ticketId}/comment?orderBy=-created`,
    {
      headers: {
        'Authorization': `Basic ${btoa(`${email}:${token}`)}`,
        'Accept': 'application/json',
      },
    }
  );

  if (!response.ok) {
    throw new Error(`Jira comments API error: ${response.status} ${response.statusText}`);
  }

  const data = await response.json();
  return data.comments ?? [];
}