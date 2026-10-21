import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'daily_collection_report_screen.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matches your app background theme
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Minimized top padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Responsive Header
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(12),
                      side: const BorderSide(color: AppColors.kBorder),
                    ),
                    child: const Icon(Icons.arrow_back, size: 20, color: Colors.black87),
                  ),
                  const Icon(Icons.receipt_long, size: 32, color: Color(0xFF6B7BFF)),
                  const Text(
                    'Payment Receipt',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.print, size: 16),
                    label: const Text('Print Receipt', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kSuccess,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DailyCollectionReportScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColors.kBorder),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Daily Report', style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Receipt Card - Center Aligned
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Purple Section (Fully Mobile Responsive)
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF6B7BFF),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                // Forces a stack column layout on compact mobile screens to prevent overflow
                                if (constraints.maxWidth < 360) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildHeaderOfficeInfo(),
                                      const SizedBox(height: 12),
                                      _buildHeaderReceiptInfo(crossAxisAlignment: CrossAxisAlignment.start),
                                    ],
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildHeaderOfficeInfo(),
                                    _buildHeaderReceiptInfo(crossAxisAlignment: CrossAxisAlignment.end),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 28),
                            const Center(
                              child: Column(
                                children: [
                                  Text(
                                    'AMOUNT COLLECTED',
                                    style: TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '₹2063',
                                    style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Middle Details Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            _buildDetailRow('Customer Name', 'Roki'),
                            _buildDetailRow('Phone', '9786204074'),
                            _buildDetailRow('Loan Number', 'LN-2026-0001'),
                            _buildDetailRow('EMI Instalment', '#1 of 25'),
                            _buildDetailRow('Payment Date', '10 Aug 2026'),
                            _buildDetailRow('Payment Mode', 'Cash'),
                            _buildDetailRow('Outstanding After', '₹49067', valueColor: Colors.red.shade700),
                            _buildDetailRow('Collected By', 'CF Admin', isLast: true),
                          ],
                        ),
                      ),

                      // Bottom Footer Section
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: const Column(
                          children: [
                            Text(
                              'This is a computer-generated receipt. No signature required.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black54, fontSize: 12),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Generated on 22 Aug 2026, 00:36',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black38, fontSize: 11),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderOfficeInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('LOANSYSTEM RECEIPT', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
        SizedBox(height: 4),
        Text('Main Office', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildHeaderReceiptInfo({required CrossAxisAlignment crossAxisAlignment}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: const [
        Text('Receipt No.', style: TextStyle(color: Colors.white70, fontSize: 10)),
        SizedBox(height: 4),
        Text('RCPT-20260810043957-0005', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor, bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: valueColor ?? Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}