import { Link } from 'react-router-dom'
import { solutions } from '../data/solutions'

/** label → 展示名 */
const labelNames: Record<string, string> = {
  faq: '常见问题',
  guide: '操作指引',
  policy: '制度说明',
  background: '背景知识',
}

export { labelNames }

export default function Home() {
  const featured = solutions.slice(0, 6)
  return (
    <div className="page">
      {/* Hero：搜索即入口（苹果 support 首页范式） */}
      <section className="hero">
        <h1>量潮支持</h1>
        <p className="hero-sub">在这里找到答案。知识来自量潮支持知识库，持续更新。</p>
        <Link to="/solutions" className="hero-search">
          <span className="search-icon">🔍</span>
          <span>搜索或浏览解决方案</span>
        </Link>
      </section>

      {/* 推荐方案 */}
      <section className="section">
        <h2>热门方案</h2>
        <div className="solution-grid">
          {featured.map((s) => (
            <Link key={s.id} to={`/solutions/${s.id}`} className="solution-card">
              {s.label && <span className={`label label-${s.label}`}>{labelNames[s.label] ?? s.label}</span>}
              <h3>{s.title}</h3>
              <p className="card-excerpt">{s.content.replace(/[#*\n]|来源：Ticket #\d+/g, '').slice(0, 60)}…</p>
            </Link>
          ))}
        </div>
      </section>

      {/* 支持渠道（苹果式"更多支持方式"） */}
      <section className="section channels">
        <h2>更多支持方式</h2>
        <div className="channel-grid">
          <div className="channel-card">
            <h3>实训基地群提问</h3>
            <p>群内提问免费，支持人员与社区共同解答，工作时间内通常当日回复。</p>
          </div>
          <div className="channel-card">
            <h3>一对一深度咨询</h3>
            <p>使用代金券预约按职级定价的一对一咨询，适合需要深入讨论的问题。</p>
          </div>
          <div className="channel-card">
            <h3>开源文档自学</h3>
            <p>
              <a href="https://github.com/quanttide" target="_blank" rel="noreferrer">GitHub 组织</a>
              {' '}提供完整的手册、教程与业务文档，多数问题可自助解决。
            </p>
          </div>
        </div>
      </section>
    </div>
  )
}
