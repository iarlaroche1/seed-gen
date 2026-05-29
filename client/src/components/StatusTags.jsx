export default function StatusTags({ ticket, tableCount }) {
  return (
    <div className="flex flex-wrap items-center gap-2 mt-6">
      {ticket && (
        <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-surface border border-[var(--border)] text-xs font-mono text-text-muted">
          <span className="text-accent">{ticket.id}</span>
          <span className="text-text-faint">·</span>
          <span>{ticket.status ?? 'resolved'}</span>
        </span>
      )}
      <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-md bg-surface border border-[var(--border)] text-xs font-mono text-text-muted">
        <span className="text-text-primary font-medium">{tableCount}</span>
        <span>tables matched</span>
      </span>
    </div>
  )
}
