# 量潮客户支持门户（qtsupport-site）

量潮客户支持官网：解决方案检索与浏览，风格对齐 support.apple.com。

## 页面

- 首页 `/`：搜索入口 + 热门方案 + 更多支持方式
- 方案列表 `/solutions`：全部解决方案
- 方案详情 `/solutions/:solutionId`：方案正文

## 数据

方案条目在 `src/data/solutions.ts`，与领域模型 Solution 一致（id/title/content）。
当前为静态种子数据（来自第二大脑 profile/qtclass），后续由 qtcloud-support API / distill 管线提供。

## 开发

```bash
npm install
npm run dev      # 启动开发服务器
npm run build    # 构建生产版本
npm run lint     # ESLint
```
