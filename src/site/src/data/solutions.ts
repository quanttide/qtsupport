// 解决方案条目——与领域模型 Solution 一致（id/title/content）
// 数据源：第二大脑档案仓库 quanttide-profile-of-customer-support（去重问答库）
export interface Solution {
  id: string
  /** 问题（一句话） */
  title: string
  /** 解答本体（Markdown 文本） */
  content: string
  /** 业务线：qtclass（量潮课堂）等，随档案业务线目录扩展 */
  business?: string
}

// 当前静态种子数据（后续由 qtcloud-support API / distill 管线提供）
export const solutions: Solution[] = [
  {
    id: 's-course-material-access',
    title: '官网课程的资料怎么获取',
    business: '量潮课堂',
    content: `在 class.quanttide.com 看到课程、想获取配套学习资料的同学：课程资料尚未整理开源，官网之外没有公开获取路径。

发邮件到 **class@quanttide.com** 索取，我们会把资料发给申请人。`,
  },
]
