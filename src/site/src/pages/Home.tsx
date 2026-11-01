import { Link } from 'react-router-dom'
import { solutions } from '../data/solutions'

export default function Home() {
  // 业务 - 问题结构：按业务线分组，组内是问题列表
  const businesses = [...new Set(solutions.map((s) => s.business ?? '其他'))]
  return (
    <div className="page">
      <section className="hero">
        <h1>量潮客户支持中心</h1>
        <p className="hero-sub">在这里找到答案。</p>
        <Link to="/solutions" className="hero-search">
          <span>浏览全部问题</span>
        </Link>
      </section>

      {businesses.map((biz) => (
        <section className="section" key={biz}>
          <h2>{biz}</h2>
          <div className="solution-grid">
            {solutions.filter((s) => (s.business ?? '其他') === biz).map((s) => (
              <Link key={s.id} to={`/solutions/${s.id}`} className="solution-card">
                <h3>{s.title}</h3>
              </Link>
            ))}
          </div>
        </section>
      ))}
    </div>
  )
}
