import 'package:flutter/material.dart';

import '../data/models.dart';

/// 提交工单：客户侧入口。提交后在内存中生成 open 工单并回传给首页列表。
class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key, required this.onSubmitted});

  final ValueChanged<Ticket> onSubmitted;

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _customer = TextEditingController();
  bool _submitted = false;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _customer.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _title.text.trim();
    final body = _body.text.trim();
    final customer = _customer.text.trim();
    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请填写问题标题与详细描述。')),
      );
      return;
    }
    final ticket = Ticket(
      no: '#new',
      title: title,
      customer: customer.isEmpty ? '未署名客户' : customer,
      body: body,
      status: 'open',
      createdAt: DateTime.now().toIso8601String(),
    );
    widget.onSubmitted(ticket);
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 64, color: Colors.green),
              SizedBox(height: 16),
              Text('工单已提交，支持人员将尽快处理。', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('可在「我的工单」中查看处理进度。', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('提交工单', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            const Text(
              '描述你遇到的问题，支持人员会以工单形式跟进，解决后沉淀为解决方案。',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: '问题标题 *',
                hintText: '一句话描述问题（如：代金券怎么用？）',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _customer,
              decoration: const InputDecoration(
                labelText: '称呼（可选）',
                hintText: '怎么称呼你',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _body,
              minLines: 6,
              maxLines: 12,
              decoration: const InputDecoration(
                labelText: '问题描述 *',
                hintText: '详细说明问题背景、你已尝试过的步骤等',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('提交工单'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
