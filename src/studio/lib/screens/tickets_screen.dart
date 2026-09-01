import 'package:flutter/material.dart';

import '../data/models.dart';

/// 我的工单：列表 + 详情（状态、解答、来源）。
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key, required this.tickets});

  final List<Ticket> tickets;

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    final list = widget.tickets.reversed.toList(); // 新提交在前
    if (list.isEmpty) {
      return const Center(child: Text('还没有工单，去「提交工单」创建一个吧。'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, i) => _TicketTile(ticket: list[i]),
    );
  }
}

class _TicketTile extends StatelessWidget {
  const _TicketTile({required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: ticket.isClosed
              ? Colors.green.shade50
              : Colors.orange.shade50,
          child: Icon(
            ticket.isClosed ? Icons.check : Icons.schedule,
            size: 20,
            color: ticket.isClosed ? Colors.green.shade700 : Colors.orange.shade800,
          ),
        ),
        title: Text(ticket.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${ticket.no} · ${ticket.customer} · ${ticket.createdAt.substring(0, 16).replaceAll('T', ' ')}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: ticket.isClosed ? Colors.green.shade50 : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            ticket.isClosed ? '已解决' : '处理中',
            style: TextStyle(
              fontSize: 12,
              color: ticket.isClosed ? Colors.green.shade800 : Colors.orange.shade800,
            ),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Block(label: '问题描述', text: ticket.body),
                if (ticket.reply != null) _Block(label: '支持解答', text: ticket.reply!),
                if (ticket.source != null)
                  Text('来源：${ticket.source}', style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(text, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
