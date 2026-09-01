import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'models.dart';

/// 种子数据加载器：原始交互档案单一事实源在 data/journal，
/// 本目录 assets/data 是原型快照。
class SeedLoader {
  const SeedLoader._();

  static Future<List<Ticket>> loadTickets() async {
    final raw = await rootBundle.loadString('assets/data/tickets.json');
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
