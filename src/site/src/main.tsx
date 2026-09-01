import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import './index.css'
import Home from './pages/Home'
import SolutionIndex from './pages/SolutionIndex'
import SolutionDetail from './pages/SolutionDetail'
import NotFound from './pages/NotFound'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <BrowserRouter>
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
        <main>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/solutions" element={<SolutionIndex />} />
            <Route path="/solutions/:solutionId" element={<SolutionDetail />} />
            <Route path="*" element={<NotFound />} />
          </Routes>
        </main>
        <footer className="site-footer">
          <div className="footer-inner">
            <p>© 2026 量潮科技 · 客户支持</p>
            <p className="footer-note">答案由量潮支持知识库提供 · 没有找到答案？在实训基地群提问，或联系支持人员</p>
          </div>
        </footer>
      </div>
    </BrowserRouter>
  </StrictMode>,
)
