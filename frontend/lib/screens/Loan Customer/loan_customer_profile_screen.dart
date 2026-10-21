import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import 'loan_customer_model.dart';

class LoanCustomerProfileScreen extends StatelessWidget {
  final LoanCustomer customer;

  const LoanCustomerProfileScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Customer Profile',
      subtitle: 'View detailed information and loan history',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Back to List'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Colors.black12),
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Top Profile Card
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.indigo.shade50,
                  child: Text(
                    customer.name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.indigo.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  customer.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.badge_outlined, size: 16, color: AppColors.kTextMuted),
                    const SizedBox(width: 6),
                    Text(
                      'Member ID: #${customer.id}',
                      style: const TextStyle(color: AppColors.kTextMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${customer.status} PROFILE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Contact Details Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CONTACT DETAILS',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined, size: 16, color: Colors.black54),
                          const SizedBox(width: 8),
                          Text(customer.phone, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 16, color: Colors.black54),
                          const SizedBox(width: 8),
                          Text(customer.email.isNotEmpty ? customer.email : '—'),
                        ],
                      ),
                      const Divider(height: 24, color: AppColors.kBorder),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('GENDER', style: TextStyle(fontSize: 10, color: AppColors.kTextMuted)),
                                const SizedBox(height: 4),
                                Text(customer.gender ?? '—', style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('BIRTH DATE', style: TextStyle(fontSize: 10, color: AppColors.kTextMuted)),
                                const SizedBox(height: 4),
                                Text(customer.dob ?? '—', style: const TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Address & Verification Card
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.blue.shade600),
                    const SizedBox(width: 8),
                    const Text(
                      'Address & Verification',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                const Text('PERMANENT ADDRESS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted)),
                const SizedBox(height: 6),
                Text(
                  [customer.addressLine1, customer.addressLine2, customer.city, customer.state, customer.pincode]
                      .where((s) => s != null && s.isNotEmpty)
                      .join(',\n'),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5),
                ),
                const SizedBox(height: 24),
                
                const Text('IDENTITY VERIFICATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted)),
                const SizedBox(height: 6),
                Text(customer.idType ?? '—', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(customer.idNumber ?? '', style: const TextStyle(fontSize: 14, color: AppColors.kTextMuted)),
                const SizedBox(height: 24),
                
                const Text('SERVICING BRANCH', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted)),
                const SizedBox(height: 6),
                Text(customer.branch, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Loan History Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long_outlined, color: Colors.indigo.shade800),
                const SizedBox(width: 8),
                Text(
                  'Loan History (${customer.activeLoans})',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Apply New Loan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSuccess,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        
        // Mocking the table from the UI
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing: 1.0,
              ),
              columns: const [
                DataColumn(label: Text('LOAN # / DATE')),
                DataColumn(label: Text('PRINCIPAL')),
                DataColumn(label: Text('MONTHLY EMI')),
                DataColumn(label: Text('OUTSTANDING')),
                DataColumn(label: Text('STATUS')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('LN-2026-0005', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('28 Jul 2026', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12)),
                    ],
                  )),
                  DataCell(const Text('₹4000000', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(const Text('₹80000', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.kSuccess))),
                  DataCell(const Text('₹6400000', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.kDanger))),
                  DataCell(const Text('Approved', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Manage'),
                  )),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}