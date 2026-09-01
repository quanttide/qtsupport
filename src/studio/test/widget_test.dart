import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qtsupport_studio/main.dart';

/// 种子数据经 rootBundle 异步加载（真实 IO），须在 runAsync 中完成，
/// 否则 fake async 环境下 future 不推进（多测试连跑时尤为明显）。
Future<void> pumpApp(WidgetTester tester) async {
  await tester.runAsync(() async {
    await tester.pumpWidget(const QtsupportStudioApp());
  });
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('app boots and shows side nav', (tester) async {
    await pumpApp(tester);
    expect(find.text('提交工单'), findsWidgets);
    expect(find.text('我的工单'), findsOneWidget);
  });

  testWidgets('submit requires title and body', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.widgetWithText(FilledButton, '提交工单'));
    await tester.pump();
    expect(find.text('请填写问题标题与详细描述。'), findsOneWidget);
    // 等 SnackBar 过期，避免遗留定时器
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('submitted ticket shows success state', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byType(TextField).at(0), '测试问题');
    await tester.enterText(find.byType(TextField).at(2), '详细描述内容');
    await tester.tap(find.widgetWithText(FilledButton, '提交工单'));
    await tester.pumpAndSettle();
    expect(find.text('工单已提交，支持人员将尽快处理。'), findsOneWidget);
  });
}
