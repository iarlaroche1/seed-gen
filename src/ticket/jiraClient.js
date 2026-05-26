import 'dotenv/config';

const token = process.env.JIRA_TOKEN;
const email = process.env.JIRA_EMAIL;
const baseUrl = process.env.JIRA_BASE_URL;

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