class LoanCustomer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String memberSince;
  final String branch;
  final int activeLoans;
  final String status;
  
  // Extended Profile Data
  final String? dob;
  final String? gender;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? pincode;
  final String? idType;
  final String? idNumber;

  const LoanCustomer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.memberSince,
    required this.branch,
    required this.activeLoans,
    required this.status,
    this.dob,
    this.gender,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.pincode,
    this.idType,
    this.idNumber,
  });
}