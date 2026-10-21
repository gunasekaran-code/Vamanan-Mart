import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import 'collection_record_model.dart';

class DailyCollectionReportScreen extends StatefulWidget {
  const DailyCollectionReportScreen({super.key});

  @override
  State<DailyCollectionReportScreen> createState() => _DailyCollectionReportScreenState();
}

class _DailyCollectionReportScreenState extends State<DailyCollectionReportScreen> {
  final List<CollectionRecord> _dailyRecords = [
    const CollectionRecord(
      receiptNo: 'RCPT-20260810043957-0005',
      loanNo: 'LN-2026-0001',
      customerName: 'Roki',
      emiInstalment: 'EMI 1',
      date: '10 Aug 2026',
      amount: 2063,
      mode: 'CASH',
      staff: 'CF Admin',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double totalAmount = _dailyRecords.fold(0, (sum, item) => sum + item.amount);

    return AppPage(
      title: 'Daily Collection Report',
      subtitle: 'Live tracking of all EMI recoveries and financial settlements.',
      children: [
        // Header Controls
        Row(
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
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kBorder),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('10/08/2026', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: AppColors.kSuccess, borderRadius: BorderRadius.circular(4)),
                      child: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print, size: 18, color: Colors.black87),
              label: const Text('Print\nReport', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black87)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.kBorder),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )
          ],
        ),
        const SizedBox(height: 24),

        // Dark Summary Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2433),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.calendar_month, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('REPORT FOR DATE', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1)),
                      Text('2026-08-10', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSummaryBox('Total Transactions', '${_dailyRecords.length} Entries', Colors.white.withOpacity(0.05)),
              const SizedBox(height: 12),
              _buildSummaryBox('Net Cash Flow', '₹${totalAmount.toInt()}', const Color(0xFF1B3B36), textColor: AppColors.kSuccess),
              const SizedBox(height: 12),
              _buildSummaryBox('Recovery Status', 'Active 📈', Colors.white.withOpacity(0.05)),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Daily Records Table
        Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                  dataRowMaxHeight: 70,
                  dataRowMinHeight: 60,
                  columns: const [
                    DataColumn(label: Text('NO.')),
                    DataColumn(label: Text('RECEIPT REFERENCE')),
                    DataColumn(label: Text('CUSTOMER / LOAN DETAIL')),
                    DataColumn(label: Text('INST #')),
                    DataColumn(label: Text('RECOVERY AMOUNT')),
                    DataColumn(label: Text('MODE')),
                    DataColumn(label: Text('STAFF IN-CHARGE')),
                    DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: _dailyRecords.asMap().entries.map((entry) {
                    int idx = entry.key + 1;
                    CollectionRecord r = entry.value;
                    return DataRow(cells: [
                      DataCell(Text(idx.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(16)),
                          child: Text(r.receiptNo, style: TextStyle(color: Colors.indigo.shade600, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text(r.loanNo, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                        ],
                      )),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border.all(color: Colors.blue.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(r.emiInstalment, style: TextStyle(color: Colors.blue.shade700, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      DataCell(Text('₹${r.amount.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.money, size: 14, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Text(r.mode, style: TextStyle(color: Colors.green.shade800, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      DataCell(Row(
                        children: [
                          CircleAvatar(radius: 12, backgroundColor: Colors.grey.shade200, child: const Text('C', style: TextStyle(fontSize: 10, color: Colors.black))),
                          const SizedBox(width: 8),
                          Text(r.staff, style: const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      )),
                      DataCell(
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.print, size: 14, color: Colors.black87),
                          label: const Text('Receipt', style: TextStyle(color: Colors.black87)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.kBorder),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
              const Divider(height: 1, color: AppColors.kBorder),
              Container(
                padding: const EdgeInsets.all(24),
                color: Colors.grey.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('CLOSING BALANCE FOR THE DAY', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
                    const SizedBox(width: 24),
                    Text('₹${totalAmount.toInt()}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.kSuccess)),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryBox(String title, String value, Color bgColor, {Color textColor = Colors.white}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}