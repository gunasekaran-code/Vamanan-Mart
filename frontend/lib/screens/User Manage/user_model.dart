// lib/models/user_model.dart

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String role; // CUSTOMER, STAFF, ADMIN, SUPERADMIN
  final String status; // Active, Locked
  final String dateJoined;
  final bool is2FAEnabled;
  final bool emailNotifications;
  final bool paymentReminders;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.role,
    required this.status,
    required this.dateJoined,
    this.is2FAEnabled = false,
    this.emailNotifications = true,
    this.paymentReminders = true,
  });

  String get fullName => '$firstName $lastName';
}