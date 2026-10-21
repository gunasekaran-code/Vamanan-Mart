import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/permission_service.dart';
import '../services/session_service.dart';

import '../widgets/app_shell.dart';
import '../widgets/app_toast.dart';

import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/not_found_screen.dart';
import '../screens/unauthorized_screen.dart';
import '../screens/verify/verify_screen.dart';

import '../screens/Dashboard/dashboard_screen.dart';
import '../screens/Daily Report/daily_report_dashboard.dart';
import '../screens/members/members_screen.dart';
import '../screens/Compliance/Compliance_Screen.dart';
import '../screens/loan/loan_screen.dart';
import '../screens/payments/payments_screen.dart';

import '../screens/EMI Collection/collection_history_screen.dart';
import '../screens/Chit Auctions/chit_auctions_screen.dart';
import '../screens/Chit Groups/Gold_dashboard.dart';
import '../screens/Chit Groups/chit_groups_screen.dart';
import '../screens/Overdue EMI/overdue_recovery_queue_screen.dart';
import '../screens/Settlements/settlements_screen.dart';

import '../screens/Loan Verification/loan_verificatin.dart';
import '../screens/Loan Customer/loan_customers_screen.dart';
import '../screens/Loan Report/loan_portfolio_summary_screen.dart';

import '../screens/Branches/branches_page.dart';
import '../screens/Analytics/analytics_page.dart';
import '../screens/Broadcast/broadcast_page.dart';
import '../screens/User Manage/user_directory_page.dart';
import '../screens/System Settings/settings_page.dart';
import '../screens/Audit Log/audit_page.dart';

import '../screens/profile/profile_screen.dart';
import '../screens/reports/reports_screen.dart';

import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    navigatorKey: ToastService.navigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,

    refreshListenable: SessionService.instance,
    redirect: _redirect,
    routes: [
      GoRoute(path: AppRoutes.root, redirect: (_, __) => AppRoutes.splash),
      GoRoute(path: AppRoutes.splash, builder: (_, __) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(
          path: AppRoutes.unauthorized,
          builder: (_, __) => const UnauthorizedScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.dashboard,
                builder: (_, __) => const DashboardScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.members,
                builder: (_, __) => const MembersScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.loans, builder: (_, __) => const LoansScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.dailyCollectionReport,
                builder: (_, __) => const DailyReportScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.paymentVerifications,
                builder: (_, __) => const VerifyScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.payments,
                builder: (_, __) => const FinanceStreamScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.reports,
                builder: (_, __) => const ReportsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.profile,
                builder: (_, __) => const ProfileScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.kycCompliance,
                builder: (_, __) => const ComplianceNexusScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.chits,
                builder: (_, __) => const ChitGroupsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.auctions,
                builder: (_, __) => const ChitAuctionsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.settlements,
                builder: (_, __) => const FinancialSettlementsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.loanCustomers,
                builder: (_, __) => const LoanCustomersScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.emiCollections,
                builder: (_, __) => const CollectionHistoryScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.overdueEmis,
                builder: (_, __) => const OverdueRecoveryQueueScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.loanVerifications,
                builder: (_, __) => const LoanVerifyScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.loanReports,
                builder: (_, __) => const LoanPortfolioScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.branches,
                builder: (_, __) => const BranchesScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.analytics,
                builder: (_, __) => const AnalyticsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.broadcastHub,
                builder: (_, __) => const BroadcastScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.userManager,
                builder: (_, __) => const UserDirectoryPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.engineSettings,
                builder: (_, __) => const SystemSettingsScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.auditControls,
                builder: (_, __) => const AuditLogScreen()),
          ]),

          StatefulShellBranch(routes: [
            GoRoute(
                path: AppRoutes.golddash,
                builder: (_, __) => const GoldDashboardScreen(
                      group: ChitGroup(
                        id: '1',
                        name: 'Gold',
                        code: 'CHIT-001',
                        value: 25000.00,
                        installment: 1000.00,
                        duration: '25 Months',
                        startDate: 'Apr 2026',
                        status: 'ACTIVE',
                      ),
                    )),
          ]),
        ],
      ),
    ],
    // Any path that doesn't match a route above (typo, stale link,
    // removed page) lands here instead of crashing or showing a blank
    // screen.
    errorBuilder: (_, __) => const NotFoundScreen(),
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final loggedIn = SessionService.instance.isLoggedIn;
    final path = state.matchedLocation;

    // Let the splash screen finish restoring the session before any
    // guard logic runs against it.
    if (path == AppRoutes.splash) return null;

    final isPublic = path == AppRoutes.login || path == AppRoutes.unauthorized;

    if (!loggedIn) {
      return isPublic ? null : AppRoutes.login;
    }

    final role = SessionService.instance.currentUser!.role;

    // Signed in: never show the login screen again.
    if (path == AppRoutes.login) {
      return PermissionService.landingRouteFor(role);
    }

    // Role guard: a direct/deep link to a page this role can't see
    // gets redirected instead of rendering a disallowed page.
    if (path != AppRoutes.unauthorized &&
        !PermissionService.canAccess(path, role)) {
      return AppRoutes.unauthorized;
    }

    return null;
  }
}
