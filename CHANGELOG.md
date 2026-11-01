# CHANGELOG

## [Unreleased]

### Changed
- `src/site` 解决方案种子数据同步档案现况：六条旧条目下线（内部指引/过时制度/售卖与招聘内容），仅存「官网课程的资料怎么获取」（源自 data/profile 去重问答库）

### Added
- `CONTRIBUTING.md` 新增：提交规则从 `AGENTS.md` 分解而来；`AGENTS.md` 收敛为指向领域仓与本仓 CONTRIBUTING 的指引
- `src/studio`：客户提交工单前台（Flutter Web）——侧边导航（提交工单 / 我的工单），种子工单在 `assets/data`（journal 案例快照 × 3）

## [0.0.1] - 2026-09-01

### Added
- 初始版本：`src/site` 客户支持门户（React + Vite，对齐 support.apple.com 风格）
- `manifests/terraform`：support.quanttide.com 基础设施（OSS + CDN + DNS）
- `.github/workflows/deploy-site.yml`：site/* tag 自动部署
