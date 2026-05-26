/**
 * @module ticketParser
 * @description Translates raw Jira API responses into clean Ticket domain objects.
 * Jira returns descriptions in Atlassian Document Format (ADF) — a deeply nested
 * JSON structure. This module flattens that into plain text, extracts structured
 * fields from the description body, and produces a clean Ticket object.
 */

/**
 * Recursively extracts plain text from an Atlassian Document Format (ADF) node.
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
 * Extracts a specific labelled field from a block of plain text.
 * Looks for lines matching "Label: Value" and returns the value.
 * Returns null if the field is not found.
 * @param {string} text - The full plain text to search through
 * @param {string} label - The field label to look for e.g. "Server"
 * @returns {string|null} The extracted value or null if not found
 */
function extractField(text, label) {
  const regex = new RegExp(`${label}\\s*:\\s*(.+)`, 'i');
  const match = text.match(regex);
  return match ? match[1].trim() : null;
}

/**
 * Extracts just the problem description — the text before the structured fields begin.
 * @param {string} text - Full plain text description
 * @returns {string} Just the human-written problem description
 */
function extractProblemStatement(text) {
  const match = text.match(/Problem Statement\s*:\s*([\s\S]*?)(?=Expected Behaviour|$)/i);
  return match ? match[1].trim() : text.trim();
}

/**
 * Converts a raw Jira API response into a clean Ticket domain object.
 * Extracts structured fields from the description body so they are
 * available as separate properties rather than buried in a text block.
 * @param {Object} raw - The raw JSON response from the Jira REST API
 * @returns {Object} A clean Ticket object
 */
export function parseTicket(raw) {
  const fullText = extractText(raw.fields.description);

  return {
    id: raw.key,
    summary: raw.fields.summary,
    problemStatement: extractProblemStatement(fullText),
    server: extractField(fullText, 'Server \\(Care1/Care2/Care3/Care4/HCM/LS\\?\\)') 
            || extractField(fullText, 'Server'),
    companyDbNumber: extractField(fullText, 'Company DB Number'),
    companyName: extractField(fullText, 'Company Name'),
    locationId: extractField(fullText, 'Location ID'),
    locationName: extractField(fullText, 'Location Name'),
    status: raw.fields.status?.name,
    priority: raw.fields.priority?.name,
    assignee: raw.fields.assignee?.displayName,
  };
}