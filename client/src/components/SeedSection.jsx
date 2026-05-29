import { Loader2, FlaskConical } from 'lucide-react'

export default function SeedSection({ seedPhase, seedResult, showSql, onSeed, onToggleSql }) {
  return (
    <div className="mt-6 space-y-3">
      {seedPhase === 'success' ? (
        <div className="flex items-start gap-3 px-4 py-3 rounded-lg
          bg-amber-950/20 border border-amber-500/20 text-sm">
          <FlaskConical size={15} className="text-amber-400 shrink-0 mt-0.5" />
          <span className="text-amber-300 leading-relaxed">
            placeholder values — AI-driven value generation not yet enabled
            {seedResult.ticketId && (
              <>
                <span className="mx-1.5 text-amber-700">·</span>
                <span className="font-mono text-amber-400">{seedResult.ticketId}</span>
              </>
            )}
            <p className="mt-1 text-amber-600 text-xs">
              column names and insert order are real. values are typed placeholders only.
            </p>
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
            'generate seed sql'
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
