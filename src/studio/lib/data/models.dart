/// 工单（Ticket）：客户提交的问题，格式对齐 GitHub Issue。
/// 种子快照来自 data/journal（assets/data/tickets.json）。
class Ticket {
  const Ticket({
    required this.no,
    required this.title,
    required this.customer,
    required this.body,
    required this.status,
    required this.createdAt,
    this.reply,
    this.source,
  });

  final String no;
  final String title;
  final String customer;
  final String body;

  /// open | closed
  final String status;
  final String createdAt;

  /// 支持人员的解答（closed 后填写）
  final String? reply;
  final String? source;

  bool get isClosed => status == 'closed';

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        no: json['no'] as String,
        title: json['title'] as String,
        customer: json['customer'] as String,
        body: json['body'] as String,
        status: json['status'] as String,
        createdAt: json['created_at'] as String,
        reply: json['reply'] as String?,
        source: json['source'] as String?,
      );
}
