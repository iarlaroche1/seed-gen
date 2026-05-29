import { Loader2, CheckCircle2 } from 'lucide-react'

export default function SeedSection({ seedPhase, seedResult, showSql, onSeed, onToggleSql }) {
  return (
    <div className="mt-6 space-y-3">
      {seedPhase === 'success' ? (
        <div className="flex items-start gap-3 px-4 py-3 rounded-lg
          bg-emerald-950/25 border border-emerald-500/15 text-sm">
          <CheckCircle2 size={15} className="text-emerald-400 shrink-0 mt-0.5" />
          <span className="text-emerald-300 leading-relaxed">
            database seeded successfully
            <span className="mx-1.5 text-emerald-600">·</span>
            <span className="font-mono text-emerald-400">
              {seedResult.tablesSeeded} tables
            </span>
            <span className="mx-1.5 text-emerald-600">·</span>
            <span className="font-mono text-emerald-400">
              {seedResult.rowsInserted} rows inserted
            </span>
            {seedResult.ticketId && (
              <>
                <span className="mx-1.5 text-emerald-600">·</span>
                <span className="font-mono text-emerald-300">{seedResult.ticketId}</span>
              </>
            )}
          </span>
        </div>
      ) : (
        <button
          onClick={onSeed}
          disabled={seedPhase === 'loading'}
          className="w-full flex items-center justify-center gap-2
            bg-accent hover:bg-violet-700 active:bg-violet-800
            disabled:opacity-60 disabled:cursor-not-allowed
            text-white text-sm font-medium tracking-wide
            px-4 py-3 rounded-lg
            transition-colors duration-150"
        >
          {seedPhase === 'loading' ? (
            <>
              <Loader2 size={14} className="animate-spin" />
              seeding database…
            </>
          ) : (
            'seed local database'
          )}
        </button>
      )}

      {seedPhase === 'success' && seedResult?.sql && (
        <button
          onClick={onToggleSql}
          className="text-xs text-text-faint hover:text-text-muted transition-colors"
        >
          {showSql ? 'hide sql' : 'view generated sql'}
        </button>
      )}

      {showSql && seedResult?.sql && (
        <pre className="p-4 rounded-lg bg-[#0a0b0d] border border-[var(--border)]
          text-xs font-mono text-text-muted leading-relaxed overflow-x-auto">
          {seedResult.sql}
        </pre>
      )}
    </div>
  )
}
