export function extractText(adfNode) {
  if (!adfNode) return '';
  if (adfNode.type === 'text') return adfNode.text || '';
  if (adfNode.type === 'hardBreak') return '\n';
  if (adfNode.content) {
    return adfNode.content.map(extractText).join('');
  }
  return '';
}

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