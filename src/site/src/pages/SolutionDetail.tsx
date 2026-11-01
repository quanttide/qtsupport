import { Link, useParams } from 'react-router-dom'
import { solutions } from '../data/solutions'

/** 极简 Markdown 渲染：标题/加粗/表格/列表/段落（无第三方依赖，够用为主） */
function renderContent(text: string) {
  const blocks = text.split(/\n\n+/)
  return blocks.map((block, i) => {
    if (block.startsWith('|')) {
      const rows = block.trim().split('\n').filter((r) => !/^\|[\s-|]+\|$/.test(r))
      const cells = rows.map((r) => r.split('|').slice(1, -1).map((c) => c.trim()))
      const [head, ...body] = cells
      return (
        <table key={i}>
          <thead><tr>{head.map((c, j) => <th key={j}>{c}</th>)}</tr></thead>
          <tbody>{body.map((r, j) => <tr key={j}>{r.map((c, k) => <td key={k}>{c}</td>)}</tr>)}</tbody>
        </table>
      )
    }
    if (/^#{1,4}\s/.test(block)) {
      const level = block.match(/^#+/)![0].length
      const Tag = `h${Math.min(level + 1, 5)}` as 'h2'
      return <Tag key={i}>{block.replace(/^#+\s/, '')}</Tag>
    }
    const lines = block.split('\n')
    const isList = lines.every((l) => /^\s*([-*]|\d+\.)\s/.test(l))
    if (isList) {
      const items = lines.map((l) => l.replace(/^\s*([-*]|\d+\.)\s/, ''))
      const ordered = /^\s*\d+\./.test(lines[0])
      const rendered = items.map((item, j) => <li key={j} dangerouslySetInnerHTML={{ __html: inline(item) }} />)
      return ordered ? <ol key={i}>{rendered}</ol> : <ul key={i}>{rendered}</ul>
    }
    return <p key={i} dangerouslySetInnerHTML={{ __html: inline(block) }} />
  })
}

/** 行内：加粗 + 链接 */
function inline(text: string) {
  return text
    .replace(/&/g, '&amp;').replace(/</g, '&lt;')
    .replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>')
    .replace(/\[(.+?)\]\((https?:\/\/[^\s)]+)\)/g, '<a href="$2" target="_blank" rel="noreferrer">$1</a>')
}

export default function SolutionDetail() {
  const { solutionId } = useParams()
  const solution = solutions.find((s) => s.id === solutionId)
  if (!solution) {
    return (
      <div className="page">
        <section className="page-header">
          <h1>未找到该方案</h1>
          <p>它可能已被更新或归档。</p>
          <Link to="/solutions" className="back-link">← 返回全部方案</Link>
        </section>
      </div>
    )
  }
  return (
    <div className="page solution-page">
      <nav className="breadcrumb">
        <Link to="/">首页</Link> / <Link to="/solutions">问题</Link> / <span>{solution.title}</span>
      </nav>
      <article className="solution-article">
        <h1>{solution.title}</h1>
        {renderContent(solution.content)}
      </article>
    </div>
  )
}
