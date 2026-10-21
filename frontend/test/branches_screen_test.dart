import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartfinance_app/main.dart';
import 'package:smartfinance_app/routes/app_router.dart';
import 'package:smartfinance_app/routes/app_routes.dart';
import 'package:smartfinance_app/services/session_service.dart';

void main() {
  testWidgets('renders /branches content on a mobile viewport', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await SessionService.instance.login(
      username: 'superadmin',
      password: 'test-password',
    );
    await tester.pumpWidget(const SmartFinanceApp());
    AppRouter.router.go(AppRoutes.branches);
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Regional Footprint'), findsOneWidget);
    expect(find.text('Main Office'), findsOneWidget);
    expect(find.text("Teacher's Colony Branch"), findsOneWidget);
  });
}
