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
            <a className="brand" href="/">量潮客户支持中心</a>
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
          </div>
        </footer>
      </div>
    </BrowserRouter>
  </StrictMode>,
)
