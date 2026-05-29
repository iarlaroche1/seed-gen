import { useMemo } from 'react'

const NW = 148  // node width
const NH = 34   // node height
const COL_GAP = 96
const ROW_GAP = 58
const PAD = 20

export default function FKGraph({ tables, fkGraph }) {
  const graph = useMemo(() => {
    if (!tables?.length || !fkGraph?.fkMap) return null

    const tableSet = new Set(tables)
    const fkMap = fkGraph.fkMap

    // Build subgraph: only edges where BOTH endpoints are in matched tables
    // Edge direction: prereq → dependent (prereq goes left)
    const rawEdges = []
    for (const [dependent, fks] of Object.entries(fkMap)) {
      if (!tableSet.has(dependent)) continue
      for (const fk of fks) {
        if (tableSet.has(fk.referencesTable) && fk.referencesTable !== dependent) {
          rawEdges.push({ from: fk.referencesTable, to: dependent, column: fk.column })
        }
      }
    }

    // Deduplicate from→to pairs
    const seen = new Set()
    const edges = rawEdges.filter(e => {
      const k = `${e.from}→${e.to}`
      return seen.has(k) ? false : (seen.add(k), true)
    })

    // Assign column depths: prereqs get smaller depth
    const depth = Object.fromEntries(tables.map(t => [t, 0]))
    for (let pass = 0; pass < tables.length; pass++) {
      for (const { from, to } of edges) {
        if (depth[to] <= depth[from]) depth[to] = depth[from] + 1
      }
    }

    // Group tables by column
    const cols = {}
    for (const t of tables) {
      const d = depth[t]
      ;(cols[d] = cols[d] || []).push(t)
    }

    // Assign pixel positions
    const pos = {}
    const sortedCols = Object.keys(cols).map(Number).sort((a, b) => a - b)
    let x = PAD
    for (const c of sortedCols) {
      cols[c].forEach((t, i) => {
        pos[t] = { x, y: PAD + i * ROW_GAP }
      })
      x += NW + COL_GAP
    }

    const maxRows = Math.max(...Object.values(cols).map(c => c.length), 1)
    const svgW = x - COL_GAP + PAD
    const svgH = PAD * 2 + maxRows * ROW_GAP

    return { nodes: tables.map(t => ({ name: t, ...pos[t] })), edges, pos, svgW, svgH }
  }, [tables, fkGraph])

  if (!graph) {
    return (
      <p className="text-xs text-text-faint font-mono py-4">
        fk graph unavailable
      </p>
    )
  }

  const { nodes, edges, pos, svgW, svgH } = graph

  return (
    <div className="rounded-lg border border-[var(--border)] bg-surface overflow-x-auto">
      {edges.length === 0 && (
        <p className="px-4 pt-3 text-xs text-text-faint font-mono">
          no cross-dependencies between matched tables
        </p>
      )}
      <svg
        width={svgW}
        height={svgH}
        className="block"
        style={{ minWidth: svgW }}
      >
        <defs>
          <marker
            id="arrow"
            viewBox="0 0 8 8"
            refX="7"
            refY="4"
            markerWidth="5"
            markerHeight="5"
            orient="auto-start-reverse"
          >
            <path d="M 0 1 L 7 4 L 0 7 z" fill="rgba(124,58,237,0.45)" />
          </marker>
        </defs>

        {edges.map((e, i) => {
          const s = pos[e.from]
          const t = pos[e.to]
          if (!s || !t) return null
          const sx = s.x + NW
          const sy = s.y + NH / 2
          const tx = t.x
          const ty = t.y + NH / 2
          const mx = (sx + tx) / 2
          return (
            <path
              key={i}
              d={`M ${sx} ${sy} C ${mx} ${sy}, ${mx} ${ty}, ${tx} ${ty}`}
              fill="none"
              stroke="rgba(124,58,237,0.28)"
              strokeWidth="1"
              markerEnd="url(#arrow)"
            />
          )
        })}

        {nodes.map(n => (
          <g key={n.name} transform={`translate(${n.x},${n.y})`}>
            <rect
              width={NW}
              height={NH}
              rx={6}
              fill="#111215"
              stroke="rgba(255,255,255,0.07)"
              strokeWidth="0.5"
            />
            <text
              x={NW / 2}
              y={NH / 2}
              dominantBaseline="middle"
              textAnchor="middle"
              fontSize={11}
              fontFamily='"JetBrains Mono", monospace'
              fill="#7c3aed"
            >
              {n.name.length > 19 ? `${n.name.slice(0, 17)}…` : n.name}
            </text>
          </g>
        ))}
      </svg>
    </div>
  )
}
