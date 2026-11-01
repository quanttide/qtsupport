import { Link } from 'react-router-dom'
import { solutions } from '../data/solutions'

export default function SolutionIndex() {
  const businesses = [...new Set(solutions.map((s) => s.business ?? '其他'))]
  return (
    <div className="page">
      <section className="page-header">
        <h1>全部问题</h1>
        <p>共 {solutions.length} 条</p>
      </section>
      {businesses.map((biz) => (
        <section key={biz}>
          <h2 className="biz-heading">{biz}</h2>
          <div className="solution-list">
            {solutions.filter((s) => (s.business ?? '其他') === biz).map((s) => (
              <Link key={s.id} to={`/solutions/${s.id}`} className="solution-row">
                <div>
                  <h3>{s.title}</h3>
                </div>
              </Link>
            ))}
          </div>
        </section>
      ))}
    </div>
  )
}
