# 量潮客户支持官网 (`qtsupport`)

量潮客户支持领域的公网支持门户：产品支持、常见问题、解决方案检索，风格对齐 support.apple.com。

## 仓库目录

```
qtsupport/
├── .github/workflows/ # CI/CD：deploy-site.yml（site/* tag → 构建 + Terraform + 上传 OSS + 刷新 CDN）
├── manifests/terraform/ # IaC：OSS 桶 + CDN + DNS（support.quanttide.com）
└── src/               # 源代码
    └── site/          # 公网支持门户（React + Vite）
```

## 线上站点

<https://support.quanttide.com>

## 关联

- 领域第二大脑：`quanttide-support`（客户支持）
- 应用：`qtcloud-support`（客户支持云，本仓库挂载于其 apps/）
