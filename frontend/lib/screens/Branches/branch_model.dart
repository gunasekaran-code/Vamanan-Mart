// lib/models/branch.dart

class Branch {
  final String id;
  final String name;
  final String address;
  final String gstin;
  final String phone;
  final String email;
  final String identifier;
  final bool isActive;

  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.gstin,
    required this.phone,
    required this.email,
    required this.identifier,
    required this.isActive,
  });
}