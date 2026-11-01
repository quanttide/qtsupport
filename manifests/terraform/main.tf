# 应用级资源命名：<app>-<env>（系统级资源由 quanttide-platform 管理）
locals {
  app_name_prefix = "${var.project}-${var.environment}"
  # 站点桶：命名对齐站点规范 {repo}-site（qtsupport-site）；OSS 全局唯一
  oss_bucket = var.oss_bucket_name
}

variable "region" {
  description = "阿里云地域"
  type        = string
  default     = "cn-hangzhou"
}

variable "project" {
  description = "项目名（资源命名前缀）"
  type        = string
  default     = "qtsupport"
}

variable "environment" {
  description = "环境：dev / prod"
  type        = string
  default     = "prod"
}

variable "oss_bucket_name" {
  description = "站点桶名（OSS 全局唯一；静态网站模式）"
  type        = string
  default     = "qtsupport-site"
}

# 平台远程状态：资源组等系统级资源引用（state 在 env:/quanttide-platform/terraform.tfstate，prefix 为 OSS backend 默认）
data "terraform_remote_state" "platform" {
  backend = "oss"
  config = {
    bucket   = "quanttide-terraform-state"
    key      = "quanttide-platform/terraform.tfstate"
    region   = "cn-hangzhou"
    endpoint = "oss-cn-hangzhou.aliyuncs.com"
  }
}

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.235"
    }
  }
  backend "oss" {
    bucket   = "quanttide-terraform-state"
    key      = "qtsupport/site.tfstate"
    region   = "cn-hangzhou"
    endpoint = "oss-cn-hangzhou.aliyuncs.com"
  }
}

provider "alicloud" {
  region = var.region
}
