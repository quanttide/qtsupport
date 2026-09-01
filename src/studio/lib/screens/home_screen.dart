import 'package:flutter/material.dart';

import '../data/models.dart';
import 'submit_screen.dart';
import 'tickets_screen.dart';

/// 主界面：客户工单前台——左侧导航（提交工单 / 我的工单）。
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.seedTickets});

  final List<Ticket> seedTickets;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  late final List<Ticket> _tickets = [...widget.seedTickets];
  int _nextNo = 195;

  void _addTicket(Ticket t) {
    setState(() {
      _tickets.add(Ticket(
        no: '#$_nextNo',
        title: t.title,
        customer: t.customer,
        body: t.body,
        status: 'open',
        createdAt: t.createdAt,
      ));
      _nextNo += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('量潮客户支持 · 提交工单'),
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.add_comment_outlined),
                selectedIcon: Icon(Icons.add_comment),
                label: Text('提交工单'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.inbox_outlined),
                selectedIcon: Icon(Icons.inbox),
                label: Text('我的工单'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: [
                SubmitScreen(onSubmitted: _addTicket),
                TicketsScreen(tickets: _tickets),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
