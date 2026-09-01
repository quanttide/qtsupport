import { Link } from 'react-router-dom'
import { solutions } from '../data/solutions'
import { labelNames } from './Home'

export default function SolutionIndex() {
  return (
    <div className="page">
      <section className="page-header">
        <h1>解决方案</h1>
        <p>来自量潮支持知识库的 {solutions.length} 条方案 · 持续沉淀更新</p>
      </section>
      <section className="solution-list">
        {solutions.map((s) => (
          <Link key={s.id} to={`/solutions/${s.id}`} className="solution-row">
            <div>
              <h3>{s.title}</h3>
              <p className="card-excerpt">{s.content.replace(/[#*]|来源：Ticket #\d+/g, '').slice(0, 80)}…</p>
            </div>
            {s.label && <span className={`label label-${s.label}`}>{labelNames[s.label] ?? s.label}</span>}
          </Link>
        ))}
      </section>
    </div>
  )
}
