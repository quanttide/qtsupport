# =============================================================================
# Site CDN + DNS（support.quanttide.com）
#
# 链路：OSS 静态网站桶（site-bucket.tf，私有）→ CDN 加速 + 私有回源鉴权
#   → CNAME 接入（云解析）→ 用户浏览器
#
# 说明（对齐 qtorg manifests/terraform/cdn.tf 的成熟实践）：
#   - 桶 ACL 私有，回源鉴权：l2_oss_key 私有回源开关（private_oss_auth=on）
#   - SPA 回退改写：React Router 深链 404 → 统一改写 /index.html
#   - 证书：泛域名证书 *.quanttide.com（acme.sh 管理，support 为单层子域可覆盖）
#   - 前置：quanttide.com 已完成 ICP 备案
# =============================================================================

resource "alicloud_cdn_domain_new" "site" {
  domain_name = "support.quanttide.com"
  cdn_type    = "web"

  # 源站：OSS 静态网站桶（site 专用桶 qtsupport-site）
  sources {
    content  = "qtsupport-site.oss-cn-hangzhou.aliyuncs.com"
    type     = "oss"
    port     = 80
    priority = 20
  }
}

# ── 私有 Bucket 回源开关（l2_oss_key：private_oss_auth=on，自动 STS 同账号回源） ──
resource "alicloud_cdn_domain_config" "site_private_back" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "l2_oss_key"
  function_args {
    arg_name  = "private_oss_auth"
    arg_value = "on"
  }
}

# SPA 回退改写：React Router（BrowserRouter）直接访问/刷新子路由（如 /solutions/xxx）
# 时回源 OSS 会 404，统一改写为 /index.html；真实产物保持原样回源。
resource "alicloud_cdn_domain_config" "site_spa_fallback" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "back_to_origin_url_rewrite"
  function_args {
    arg_name  = "source_url"
    arg_value = "^/(?!index\\.html$|assets/|vite\\.svg$).*"
  }
  function_args {
    arg_name  = "target_url"
    arg_value = "/index.html"
  }
  function_args {
    arg_name  = "flag"
    arg_value = "break"
  }
}

# 强制 HTTPS：HTTP 请求 301 跳转 HTTPS
resource "alicloud_cdn_domain_config" "site_https_force" {
  domain_name   = alicloud_cdn_domain_new.site.domain_name
  function_name = "https_force"
  function_args {
    arg_name  = "enable"
    arg_value = "on"
  }
}

# ── 账号级授权：CDN 回源私有 OSS（阿里云官方命名，幂等；多站点共用） ─────────

# 自定义策略：OSS 只读（List/Get）——qtorg 已建同名资源，此处幂等声明保证独立可部署
resource "alicloud_ram_policy" "cdn_private_oss" {
  policy_name     = "AliyunCDNAccessingPrivateOSSRolePolicy"
  description     = "用于CDN/DCDN回源私有OSS Bucket角色的授权策略，包含OSS的只读权限"
  policy_document = <<-EOT
    {
      "Version": "1",
      "Statement": [
        { "Action": ["oss:List*", "oss:Get*"], "Resource": "*", "Effect": "Allow" }
      ]
    }
  EOT
}

# 角色：信任 CDN 服务
resource "alicloud_ram_role" "cdn_private_oss" {
  name        = "AliyunCDNAccessingPrivateOSSRole"
  description = "用于CDN回源私有OSS Bucket"
  document    = <<-EOT
    {
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Effect": "Allow",
          "Principal": { "Service": ["cdn.aliyuncs.com"] }
        }
      ],
      "Version": "1"
    }
  EOT
}

# 策略绑定到角色
resource "alicloud_ram_role_policy_attachment" "cdn_private_oss" {
  role_name   = alicloud_ram_role.cdn_private_oss.name
  policy_name = alicloud_ram_policy.cdn_private_oss.policy_name
  policy_type = "Custom"
}

# ── DNS：CNAME 接入 ─────────────────────────────────────────────────

resource "alicloud_alidns_record" "site" {
  domain_name = "quanttide.com"
  rr          = "support"
  type        = "CNAME"
  value       = alicloud_cdn_domain_new.site.cname
  ttl         = 600
}
