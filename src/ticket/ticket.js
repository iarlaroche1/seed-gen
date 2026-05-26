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