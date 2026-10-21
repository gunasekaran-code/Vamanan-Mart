import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import 'create_settlement_screen.dart';
import 'edit_settlement_screen.dart';
import 'settlement_model.dart';
import 'settlement_statement_screen.dart';

class FinancialSettlementsScreen extends StatefulWidget {
  const FinancialSettlementsScreen({super.key});

  @override
  State<FinancialSettlementsScreen> createState() =>
      _FinancialSettlementsScreenState();
}

class _FinancialSettlementsScreenState
    extends State<FinancialSettlementsScreen> {
  final List<Settlement> _settlements = [
    const Settlement(
      id: 'SET-00001',
      memberName: 'Jessica',
      memberPhone: '9512364870',
      chitGroup: 'Gold',
      totalPaid: 3000.00,
      totalReceived: 0.00,
      dividend: 2500.00,
      penalty: 1600.00,
      status: 'Open',
      commencedDate: 'April 2026',
    ),
  ];

  void _navigateToCreate() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSettlementScreen(),
      ),
    );
    if (result is Settlement) {
      setState(() => _settlements.add(result));
    }
  }

  void _navigateToEdit(Settlement settlement) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSettlementScreen(settlement: settlement),
      ),
    );
    if (result is Settlement) {
      setState(() {
        final index = _settlements.indexWhere((s) => s.id == result.id);
        if (index != -1) _settlements[index] = result;
      });
    }
  }

  void _navigateToStatement(Settlement settlement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SettlementStatementScreen(settlement: settlement),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Financial Settlements',
      subtitle: 'Manage and reconcile member settlement statements',
      children: [
        // Action Header
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: _navigateToCreate,
                icon: const Icon(Icons.add_circle_outline, size: 20),
                label: const Text(
                  'New Settlement',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSuccess,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),

        // List / Cards
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _settlements.length,
          itemBuilder: (context, index) {
            final item = _settlements[index];
            final netAmt = item.netAmount;
            final isNegative = netAmt < 0;

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 16),
              color: AppColors.kSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Member & Status Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.indigo.shade50,
                              child: Text(
                                item.memberName[0].toUpperCase(),
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
                                  item.memberName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Chit: ${item.chitGroup}',
                                  style: const TextStyle(
                                    color: AppColors.kTextMuted,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: item.status == 'Open'
                                ? Colors.amber.shade50
                                : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: item.status == 'Open'
                                  ? Colors.amber.shade300
                                  : Colors.green.shade300,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.status == 'Open'
                                    ? Icons.lock_open
                                    : Icons.lock,
                                size: 14,
                                color: item.status == 'Open'
                                    ? Colors.amber.shade800
                                    : Colors.green.shade800,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item.status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: item.status == 'Open'
                                      ? Colors.amber.shade900
                                      : Colors.green.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, color: AppColors.kBorder),

                    // Financial Highlights
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildMetric('PAID', '₹${item.totalPaid.toStringAsFixed(2)}', AppColors.kDanger),
                        _buildMetric('RECEIVED', '₹${item.totalReceived.toStringAsFixed(2)}', AppColors.kSuccess),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'NET AMOUNT',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.kTextMuted,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isNegative
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '₹${netAmt.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isNegative
                                      ? AppColors.kDanger
                                      : AppColors.kSuccess,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Actions Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _navigateToStatement(item),
                          icon: const Icon(Icons.description_outlined, size: 16),
                          label: const Text('Statement'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade700,
                            side: BorderSide(color: Colors.blue.shade200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _navigateToEdit(item),
                          icon: const Icon(Icons.edit_outlined),
                          color: Colors.blue,
                          tooltip: 'Edit Settlement',
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

  Widget _buildMetric(String label, String val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          val,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}