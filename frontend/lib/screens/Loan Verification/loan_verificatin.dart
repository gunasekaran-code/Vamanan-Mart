import 'package:flutter/material.dart';
import '../../widgets/app_toast.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';

class VerificationItem {
  final String id;
  final String customerName;
  final String phone;
  final String planName;
  final String installment;
  final String amount;
  final String transactionId;
  final String dateTime;
  final String status; // 'APPROVED', 'REJECTED', 'PENDING'
  final String? proofImageUrl;
  final String dueDate; // Added to match the UI requirements

  const VerificationItem({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.planName,
    required this.installment,
    required this.amount,
    required this.transactionId,
    required this.dateTime,
    required this.status,
    required this.dueDate,
    this.proofImageUrl,
  });
}

class LoanVerifyScreen extends StatefulWidget {
  const LoanVerifyScreen({super.key});

  @override
  State<LoanVerifyScreen> createState() => _LoanVerifyScreenState();
}

class _LoanVerifyScreenState extends State<LoanVerifyScreen> {
  String _selectedStatus = 'APPROVED'; // Default filter matching the image

  final List<VerificationItem> _verifications = const [
    VerificationItem(
      id: '3',
      customerName: 'VEERASAMY.K',
      phone: '9677490097',
      planName: 'LN-2026-0005',
      installment: 'Inst #1',
      amount: '₹80000',
      transactionId: '986532014789',
      dateTime: '28 Jul, 12:47 PM',
      dueDate: '10 Aug 2026',
      status: 'APPROVED',
      proofImageUrl: 'https://via.placeholder.com/400x300.png?text=Proof+Image',
    ),
    VerificationItem(
      id: '1',
      customerName: 'Jessica',
      phone: '9512364870',
      planName: 'LN-2026-0003',
      installment: 'Inst #1',
      amount: '₹508',
      transactionId: '9632587410235',
      dateTime: '10 Jul, 10:56 AM',
      dueDate: '29 Jun 2026',
      status: 'APPROVED',
    ),
    VerificationItem(
      id: '2',
      customerName: 'Roki',
      phone: '9786204074',
      planName: 'LN-2026-0001',
      installment: 'Inst #3',
      amount: '₹1000',
      transactionId: '409823126781',
      dateTime: '09 Apr, 05:41 PM',
      dueDate: '15 Apr 2026',
      status: 'PENDING',
    ),
  ];

  // Matches image_75fa6c.jpg
  void _showProofModal(BuildContext context, VerificationItem item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Verify Payment Submission',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Screenshot Preview Container
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: item.proofImageUrl != null
                      ? Image.network(item.proofImageUrl!, fit: BoxFit.cover)
                      : const Center(
                          child: Icon(Icons.image_outlined, size: 48, color: Colors.black26),
                        ),
                ),
                const SizedBox(height: 24),
                
                // Verification Details Section
                const Text(
                  'Verification Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Customer Provided Info
                const Text(
                  'CUSTOMER PROVIDED INFO',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.customerName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF6B7280)),
                          const SizedBox(width: 4),
                          Text(
                            item.phone,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Transaction & Date Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'TRANSACTION ID',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.transactionId,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SUBMISSION DATE',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.dateTime,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Status Box
                _buildModalStatusBox(item.status),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModalStatusBox(String status) {
    Color bgColor;
    Color fgColor;
    IconData icon;
    
    switch (status.toUpperCase()) {
      case 'APPROVED':
        bgColor = const Color(0xFFE5F7ED);
        fgColor = const Color(0xFF00A95D);
        icon = Icons.check_circle;
        break;
      case 'REJECTED':
        bgColor = const Color(0xFFFEE2E2);
        fgColor = const Color(0xFFDC2626);
        icon = Icons.cancel;
        break;
      default:
        bgColor = const Color(0xFFFEF3C7);
        fgColor = const Color(0xFFD97706);
        icon = Icons.schedule;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: fgColor, size: 32),
          const SizedBox(height: 8),
          Text(
            status.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: fgColor, letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(
            'Processed by CF Admin\n22 Aug 2026, 01:04 AM',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: fgColor.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String title, IconData icon) {
    final isSelected = _selectedStatus == title.toUpperCase();
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = title.toUpperCase();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5A52FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _verifications.where((v) => v.status.toUpperCase() == _selectedStatus).toList();

    return AppPage(
      title: 'Loan Verifications',
      subtitle: 'Review customer submissions to finalize loan EMI collections.',
      children: [
        // Top Filter Row matching image_75a84e.png
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFilterChip('Pending', Icons.schedule),
                _buildFilterChip('Approved', Icons.check),
                _buildFilterChip('Rejected', Icons.close),
              ],
            ),
          ),
        ),

        // Mobile Responsive Cards
        for (final item in filteredItems)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Icon & Customer / Loan Account
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.receipt_long, color: Color(0xFF111827)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CUSTOMER DETAILS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5)),
                          const SizedBox(height: 4),
                          Text(item.customerName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.phone_outlined, size: 14, color: Color(0xFF6B7280)),
                              const SizedBox(width: 4),
                              Text(item.phone, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('LOAN ACCOUNT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5)),
                          const SizedBox(height: 4),
                          Text(item.planName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
                          const SizedBox(height: 2),
                          Text(item.installment, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                ),

                // Middle Row: Amount & Transaction Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('EMI AMOUNT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5)),
                          const SizedBox(height: 4),
                          Text(item.amount, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00A95D))),
                          const SizedBox(height: 2),
                          Text('Due: ${item.dueDate}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('TRANSACTION REFERENCE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF9CA3AF), letterSpacing: 0.5)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(item.transactionId, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFF6B7280)),
                              const SizedBox(width: 4),
                              Text(item.dateTime, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4B5563))),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Bottom Action Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _showProofModal(context, item),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF111827),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('View Submission', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}