import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'settlement_model.dart';

class SettlementStatementScreen extends StatelessWidget {
  final Settlement settlement;

  const SettlementStatementScreen({super.key, required this.settlement});

  @override
  Widget build(BuildContext context) {
    final netAmt = settlement.netAmount;
    final isNegative = netAmt < 0;

    return AppPage(
      title: 'Settlement Statement',
      subtitle: 'Transaction ID: ${settlement.id} • Official Document',
      children: [
        // Action Bar
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ToastService.show(
                  title: 'Printing Statement',
                  message: 'Sending document to local printer...',
                  type: ToastType.success,
                );
              },
              icon: const Icon(Icons.print_outlined, size: 18),
              label: const Text('< Print   '),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Main Document Card
        Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dark Hero Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                color: const Color(0xFF1E293B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Final Settlement Report',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'FULL CYCLE FINANCIAL RECONCILE',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.lock_open,
                              size: 14, color: Colors.black87),
                          const SizedBox(width: 4),
                          Text(
                            'DRAFT / ${settlement.status.toUpperCase()}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Member Info
                    const Text(
                      'MEMBER INFORMATION',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kTextMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.indigo.shade50,
                          child: Text(
                            settlement.memberName[0].toUpperCase(),
                            style: TextStyle(
                              color: Colors.indigo.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              settlement.memberName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              settlement.memberPhone,
                              style: const TextStyle(
                                color: AppColors.kTextMuted,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Chit Group Context
                    const Text(
                      'CHIT GROUP CONTEXT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kTextMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      settlement.chitGroup,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'Commenced: ${settlement.commencedDate}',
                      style: const TextStyle(
                        color: AppColors.kTextMuted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: AppColors.kBorder),

                    // Itemized Financial Rows
                    _buildRow(
                      'Total Accumulated Payments',
                      'Sum of all monthly contributions paid to the fund',
                      '- ₹${settlement.totalPaid.toStringAsFixed(2)}',
                      AppColors.kDanger,
                    ),
                    const Divider(color: AppColors.kBorder),

                    _buildRow(
                      'Total Payout Received',
                      'Total dividend-adjusted distributions received from auctions',
                      '+ ₹${settlement.totalReceived.toStringAsFixed(2)}',
                      AppColors.kSuccess,
                    ),
                    const Divider(color: AppColors.kBorder),

                    _buildRow(
                      'Collective Dividends',
                      'Share of discounts distributed to the member',
                      '+ ₹${settlement.dividend.toStringAsFixed(2)}',
                      AppColors.kSuccess,
                    ),
                    const Divider(color: AppColors.kBorder),

                    _buildRow(
                      'Penalty & Administrative Deductions',
                      'Late fee penalties and system adjustments',
                      '- ₹${settlement.penalty.toStringAsFixed(2)}',
                      AppColors.kDanger,
                    ),
                    const SizedBox(height: 24),

                    // Net Calculation Display Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isNegative
                            ? Colors.red.shade50.withOpacity(0.5)
                            : Colors.green.shade50.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isNegative
                              ? Colors.red.shade200
                              : Colors.green.shade200,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '₹${netAmt.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: isNegative
                                ? AppColors.kDanger
                                : AppColors.kSuccess,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Timeline & Signature
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.access_time,
                                  size: 14, color: AppColors.kTextMuted),
                              SizedBox(width: 6),
                              Text(
                                'Settlement Timeline',
                                style: TextStyle(
                                  color: AppColors.kTextMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Currently Open for Reconciliation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 32),

                          Container(width: 180, height: 1, color: Colors.black38),
                          const SizedBox(height: 8),
                          const Text(
                            'AUTHORIZED SIGNATURE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: AppColors.kTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Footer Audit Formula Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.info_outline, size: 16, color: AppColors.kTextMuted),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Audit Formula: (Total Received + Dividend) - (Total Paid + Penalty) = Net Settlement',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.kTextMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
      String title, String subtitle, String amount, Color amountColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.kTextMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}