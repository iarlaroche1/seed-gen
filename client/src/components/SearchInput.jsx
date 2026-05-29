import { useState } from 'react'
import { ArrowRight, Loader2 } from 'lucide-react'

export default function SearchInput({ onSearch, isLoading }) {
  const [value, setValue] = useState('')

  function handleSubmit(e) {
    e?.preventDefault()
    if (value.trim() && !isLoading) onSearch(value.trim())
  }

  return (
    <form onSubmit={handleSubmit} className="relative">
      <input
        type="text"
        value={value}
        onChange={e => setValue(e.target.value)}
        placeholder="ticket id or search tables…"
        disabled={isLoading}
        autoFocus
        className="
          w-full bg-surface border border-[var(--border)] rounded-lg
          px-4 py-3 pr-12
          font-mono text-sm text-text-primary placeholder:text-text-faint
          focus:outline-none focus:border-[var(--border-accent)] focus:bg-[var(--surface-hover)]
          disabled:opacity-50
          transition-all duration-150
        "
      />
      <button
        type="submit"
        disabled={isLoading || !value.trim()}
        className="
          absolute right-3 top-1/2 -translate-y-1/2
          text-text-muted hover:text-accent
          disabled:opacity-25
          transition-colors
        "
      >
        {isLoading
          ? <Loader2 size={15} className="animate-spin" />
          : <ArrowRight size={15} />
        }
      </button>
    </form>
  )
}
