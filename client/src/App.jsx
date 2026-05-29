import { useState } from 'react'
import Logo from './components/Logo.jsx'
import SearchInput from './components/SearchInput.jsx'
import StatusTags from './components/StatusTags.jsx'
import TableCard from './components/TableCard.jsx'
import FKGraph from './components/FKGraph.jsx'
import SeedSection from './components/SeedSection.jsx'

export default function App() {
  const [phase, setPhase] = useState('idle') // idle | loading | done | error
  const [error, setError] = useState(null)
  const [ticket, setTicket] = useState(null)
  const [tables, setTables] = useState([])
  const [showFkGraph, setShowFkGraph] = useState(false)
  const [fkGraph, setFkGraph] = useState(null)
  const [seedPhase, setSeedPhase] = useState('idle') // idle | loading | success
  const [seedResult, setSeedResult] = useState(null)
  const [showSql, setShowSql] = useState(false)

  async function handleSearch(query) {
    setPhase('loading')
    setError(null)
    setTicket(null)
    setTables([])
    setShowFkGraph(false)
    setSeedPhase('idle')
    setSeedResult(null)
    setShowSql(false)

    try {
      const res = await fetch('/api/search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query }),
      })
      const data = await res.json()
      if (!res.ok) throw new Error(data.error || 'Search failed')
      setTicket(data.ticket)
      setTables(data.tables)
      setPhase('done')
    } catch (err) {
      setError(err.message)
      setPhase('error')
    }
  }

  async function handleToggleFkGraph() {
    if (!showFkGraph && !fkGraph) {
      try {
        const res = await fetch('/api/fkgraph')
        setFkGraph(await res.json())
      } catch {
        // non-fatal — graph just won't render
      }
    }
    setShowFkGraph(v => !v)
  }

  async function handleSeed() {
    setSeedPhase('loading')
    try {
      const res = await fetch('/api/seed', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ ticket, tables }),
      })
      const data = await res.json()
      setSeedResult(data)
      setSeedPhase('success')
    } catch {
      setSeedPhase('idle')
    }
  }

  return (
    <div className="min-h-screen bg-bg font-sans">
      <div className="max-w-2xl mx-auto px-6 py-12">

        <Logo />

        <div className="mt-16">
          <SearchInput onSearch={handleSearch} isLoading={phase === 'loading'} />
        </div>

        {phase === 'error' && (
          <p className="mt-4 font-mono text-sm text-red-400">{error}</p>
        )}

        {phase === 'done' && (
          <>
            <StatusTags ticket={ticket} tableCount={tables.length} />

            <div className="mt-5 space-y-2">
              {tables.map((table, i) => (
                <TableCard key={table.name} table={table} index={i} />
              ))}
            </div>

            {tables.length > 0 && (
              <>
                <div className="mt-8 border-t border-[var(--border)]" />

                <button
                  onClick={handleToggleFkGraph}
                  className="mt-4 text-xs text-text-muted hover:text-text-primary transition-colors tracking-wide"
                >
                  {showFkGraph ? 'hide fk graph ↑' : 'show fk graph ↓'}
                </button>

                {showFkGraph && (
                  <div className="mt-3">
                    <FKGraph tables={tables.map(t => t.name)} fkGraph={fkGraph} />
                  </div>
                )}

                <div className="mt-8 border-t border-[var(--border)]" />

                <SeedSection
                  seedPhase={seedPhase}
                  seedResult={seedResult}
                  showSql={showSql}
                  onSeed={handleSeed}
                  onToggleSql={() => setShowSql(v => !v)}
                />
              </>
            )}
          </>
        )}
      </div>
    </div>
  )
}
