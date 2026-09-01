export default function App() {
  return (
    <div className="app">
      <header className="site-header">
        <div className="header-inner">
          <a className="brand" href="/">量潮支持</a>
          <nav>
            <a href="https://www.quanttide.com" target="_blank" rel="noreferrer">量潮官网</a>
            <a href="https://class.quanttide.com/learn" target="_blank" rel="noreferrer">量潮课堂</a>
            <a href="https://crowd.quanttide.com" target="_blank" rel="noreferrer">众包平台</a>
          </nav>
        </div>
      </header>
      <main>{/* 路由页面由 main.tsx 渲染 */}</main>
    </div>
  )
}
