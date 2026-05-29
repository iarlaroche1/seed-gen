import { useState } from 'react'

export default function TableCard({ table, index }) {
  const [expanded, setExpanded] = useState(false)

  const scoreLabel = `${Math.round(table.score * 100)}%`
  const hasLongDesc = table.description && table.description.length > 120

  return (
    <div
      className="animate-fade-in rounded-lg border border-[var(--border)] bg-surface px-4 py-3
        hover:border-[var(--border-accent)] hover:bg-[var(--surface-hover)]
        transition-all duration-150 cursor-default"
      style={{ animationDelay: `${index * 55}ms` }}
      onMouseEnter={() => hasLongDesc && setExpanded(true)}
      onMouseLeave={() => setExpanded(false)}
    >
      <div className="flex items-baseline justify-between gap-4">
        <span className="font-mono text-sm text-accent">{table.name}</span>
        <span className="shrink-0 text-[11px] font-mono text-text-faint tabular-nums">
          {scoreLabel}
        </span>
      </div>

      {table.description && (
        <p
          className="mt-1.5 text-xs text-text-muted leading-relaxed transition-all duration-200"
          style={{
            display: '-webkit-box',
            WebkitBoxOrient: 'vertical',
            WebkitLineClamp: expanded ? 'unset' : 2,
            overflow: 'hidden',
          }}
        >
          {table.description}
        </p>
      )}
    </div>
  )
}
