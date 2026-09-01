import 'package:flutter/material.dart';

import 'data/models.dart';
import 'data/seed_loader.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QtsupportStudioApp());
}

class QtsupportStudioApp extends StatelessWidget {
  const QtsupportStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '量潮客户支持 · 提交工单',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0969DA)),
        useMaterial3: true,
      ),
      home: const _Bootstrap(),
    );
  }
}

class _Bootstrap extends StatefulWidget {
  const _Bootstrap();

  @override
  State<_Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<_Bootstrap> {
  late final Future<List<Ticket>> _future = SeedLoader.loadTickets();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ticket>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('种子数据加载失败：${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return HomeScreen(seedTickets: snapshot.data!);
      },
    );
  }
}
