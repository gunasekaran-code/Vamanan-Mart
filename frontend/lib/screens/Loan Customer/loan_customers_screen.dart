import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import 'add_loan_customer_screen.dart';
import 'edit_loan_customer_screen.dart';
import 'loan_customer_profile_screen.dart';
import 'loan_customer_model.dart';

class LoanCustomersScreen extends StatefulWidget {
  const LoanCustomersScreen({super.key});

  @override
  State<LoanCustomersScreen> createState() => _LoanCustomersScreenState();
}

class _LoanCustomersScreenState extends State<LoanCustomersScreen> {
  final List<LoanCustomer> _customers = [
    const LoanCustomer(
      id: '0005',
      name: 'VEERASAMY.K',
      phone: '9677490097',
      email: 'veerasamyk2017@gmail.com',
      memberSince: 'Jul 2026',
      branch: 'Unassigned',
      activeLoans: 1,
      status: 'ACTIVE',
      addressLine1: '4/642, MURUKANAPALLI POST OFFICE, CHENAPPALLI',
      addressLine2: 'MARUTHANAPALLI, SHOOLAGIRI, KRISHNAKIRI',
      city: 'Krishnakiri',
      state: 'Tamil Nadu',
      pincode: '635117',
      idType: 'PAN / Aadhaar',
      idNumber: '490094235029',
    ),
    const LoanCustomer(
      id: '0006',
      name: 'Varshini',
      phone: '7685940321',
      email: 'varshini@gmail.com',
      memberSince: 'Apr 2026',
      branch: 'Teacher\'s Colony Branch',
      activeLoans: 1,
      status: 'ACTIVE',
    ),
    const LoanCustomer(
      id: '0007',
      name: 'Jessica',
      phone: '9512364870',
      email: 'cloudhawk001@gmail.com',
      memberSince: 'Apr 2026',
      branch: 'Main Office',
      activeLoans: 3,
      status: 'ACTIVE',
    ),
    const LoanCustomer(
      id: '0008',
      name: 'Roki',
      phone: '9786204074',
      email: '—',
      memberSince: 'Apr 2026',
      branch: 'Teacher\'s Colony Branch',
      activeLoans: 1,
      status: 'ACTIVE',
    ),
  ];

  void _navToAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddLoanCustomerScreen()),
    );
    if (result is LoanCustomer) setState(() => _customers.add(result));
  }

  void _navToEdit(LoanCustomer c, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditLoanCustomerScreen(customer: c)),
    );
    if (result is LoanCustomer) setState(() => _customers[index] = result);
  }

  void _navToProfile(LoanCustomer c) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LoanCustomerProfileScreen(customer: c)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Loan Customers',
      subtitle: 'Registered borrowers and their active profiles',
      children: [
        // Action Header
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: _navToAdd,
                icon: const Icon(Icons.person_add_alt_1, size: 20),
                label: const Text('Register Customer',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSuccess,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),

        // Filter / Search Container
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search by name, phone, ID number...',
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: 'All Branches',
                items: [
                  'All Branches',
                  'Main Office',
                  'Teacher\'s Colony Branch'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kSuccess,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Find Customer',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Reset',
                      style: TextStyle(color: Colors.black87)),
                ),
              ),
            ],
          ),
        ),

        // Customer Cards List (Mobile Layout Adaptation)
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _customers.length,
          itemBuilder: (context, index) {
            final c = _customers[index];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.indigo.shade50,
                          child: Text(
                            c.name[0].toUpperCase(),
                            style: TextStyle(
                                color: Colors.indigo.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text('Member since ${c.memberSince}',
                                  style: const TextStyle(
                                      color: AppColors.kTextMuted,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            c.status,
                            style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.kBorder),

                    // Contact Info & Loans Summary
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.phone,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Text(c.phone,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.email_outlined,
                                      size: 14, color: Colors.grey),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(c.email,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 13)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text('ACTIVE LOANS',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.kTextMuted,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.blue.shade100),
                              ),
                              child: Text(
                                c.activeLoans.toString(),
                                style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => _navToProfile(c),
                          icon: const Icon(Icons.badge_outlined),
                          color: Colors.blue.shade700,
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.blue.shade50),
                          tooltip: 'View Profile',
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _navToEdit(c, index),
                          icon: const Icon(Icons.edit_outlined),
                          color: Colors.grey.shade700,
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.grey.shade100),
                          tooltip: 'Edit Profile',
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_circle_outline),
                          color: Colors.green.shade700,
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green.shade50),
                          tooltip: 'Add Loan',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
