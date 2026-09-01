import { Link } from 'react-router-dom'

export default function NotFound() {
  return (
    <div className="page">
      <section className="page-header">
        <h1>页面不存在</h1>
        <p>你要找的内容可能已移动或不存在。</p>
        <Link to="/" className="back-link">← 返回支持首页</Link>
      </section>
    </div>
  )
}
