class AuditModel {
  final String id;
  final String date;
  final String time;
  final String adminName;
  final String action;
  final String systemModule;
  final String securityContext;

  AuditModel({
    required this.id,
    required this.date,
    required this.time,
    required this.adminName,
    required this.action,
    required this.systemModule,
    required this.securityContext,
  });
}

// Generate dummy data to simulate database logs
List<AuditModel> getDummyAuditLogs() {
  return List.generate(
    12,
    (index) {
      bool isAdmin = index % 2 == 0;
      bool isLogin = index % 3 != 1;
      return AuditModel(
        id: index.toString(),
        date: index < 2 ? '22 Aug 2026' : (index < 5 ? '21 Aug 2026' : '14 Aug 2026'),
        time: '10:55:${10 + index}',
        adminName: isAdmin ? 'admin' : 'veerasamy',
        action: isLogin ? 'LOGIN' : 'LOGOUT',
        systemModule: 'AUTHENTICATION',
        securityContext: isLogin
            ? 'User ${isAdmin ? 'admin' : 'veerasamy'} successfully logged into the system.'
            : 'User ${isAdmin ? 'admin' : 'veerasamy'} logged out of the session.',
      );
    },
  );
}