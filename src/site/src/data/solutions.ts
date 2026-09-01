// 解决方案条目——与领域模型 Solution 一致（id/title/content）
// 数据源：第二大脑档案仓库 quanttide-profile-of-customer-support
export interface Solution {
  id: string
  title: string
  /** 适用场景 + 解答本体 + 升级说明（Markdown 文本） */
  content: string
  /** 条目类型：faq / guide / policy / background */
  label?: string
}

// 当前静态种子数据（后续由 qtcloud-support API / distill 管线提供）
export const solutions: Solution[] = [
  {
    id: 's-voucher-usage',
    title: '代金券怎么用、怎么挣',
    label: 'faq',
    content: `**使用规则**

代金券用于一对一沟通（咨询/预约），按小时计价；群内沟通免费，不消耗代金券。

预约价格与支持者职级对应：

| 职级 | 价格 |
|---|---|
| L5 | 500 元/小时 |
| L4 | 300 元/小时 |
| L3 | 200 元/小时 |
| L1 | 100 元/小时 |

**挣券渠道**

- 课堂实训任务：100 代金券/个（class.quanttide.com/learn）
- 众包任务：基准 1000 元/个（crowd.quanttide.com）

**需要人工处理**：兑换纠纷、过期争议请联系支持人员核实。`,
  },
  {
    id: 's-task-application-email',
    title: '课题申请发到哪个邮箱',
    label: 'faq',
    content: `两个邮箱职能不同：

- **hr 邮箱**：提交课题申请
- **class@quanttide.com**：获取课堂任务（如 GitHub 协作入门任务），免费

申请邮件要求简明扼要、有礼貌。发出 3 个工作日无回复，可在群内确认是否收到。`,
  },
  {
    id: 's-doc-permission-check',
    title: '提交课题/申请前检查文档访问权限',
    label: 'guide',
    content: `提交前先用**未参与编辑的账号**打开链接自查：

1. 飞书云文档：分享范围设为"互联网上获得链接的人可阅读"，或明确添加评审人
2. GitHub 仓库：确认仓库 public，或已邀请评审账号为 collaborator
3. 附带的项目文档、素材链接逐个检查，不要只查主文档

自查后评审方仍无法访问，请联系支持人员处理授权。`,
  },
  {
    id: 's-topic-deadline',
    title: '课题有 deadline 吗？错过会怎样',
    label: 'policy',
    content: `**制度分情况**：

- 到 deadline 后仍未提交 → 默认视为不再参与
- **活跃参与者有保留权利**：已参与课堂教学活动、有提交记录的同学，可随时发起课题
- 通过首个教学任务后开通正式实训基地账号 = 长期学习权限，课题可以慢慢来

**长期免费学员通道**：向 class@quanttide.com 报名"我要成为长期免费学员"。`,
  },
  {
    id: 's-rank-progress',
    title: '实训基地职级与成长进度条',
    label: 'policy',
    content: `实训基地把学员、众包、招聘统一管理，用**负数职级**标明相对公司招聘标准的位置（"负数是商场地下楼层，不代表能力是负的"）：

| 职级 | 含义 |
|---|---|
| -3 | 纯学员，尚未能参与实际贡献 |
| -2 | 可参与一些小的贡献 |
| -1 | 可较独立地参与贡献 |
| 0 | 可入职（拥有公司身份） |

**成长速度参考**：长期参与 3-6 个月，工作能力普遍高出同龄人一截。`,
  },
  {
    id: 's-business-info-channels',
    title: '商务信息从哪里了解',
    label: 'faq',
    content: `**渠道按优先级**

1. **GitHub 组织**（最主要来源）：github.com/quanttide——能开源的业务资料已基本开源
2. **微信公众号**：业务活动信息

**深度商务咨询**：商务专家资源稀缺，建议路径：开源资料自学 → 群内提问（免费）→ 确需深度一对一再用代金券预约。

涉及具体报价、合同、合作意向，请直接联系商务。`,
  },
  {
    id: 's-email-workflow-evolution',
    title: '从邮件工作流到商务平台：业务演进背景',
    label: 'background',
    content: `量潮的商务流程经历三个阶段：

1. **群聊时代（过去）**：流程靠群聊维系——散、乱，企业微信接口受限
2. **邮件工作流（当前，过渡态）**：E1-E18 编号节点，关键流程强制走邮箱。局限：批量自动化难判断工作状态
3. **自研平台（目标态）**：商务前台 + 通用商务后台，客户点击步骤替代通知步骤

**真正痛点在交付中后期**：客户变 + 内部变 → 项目中后期开始失控。对策：交付验收清单管理 + 沟通云"共识链条"。`,
  },
]
