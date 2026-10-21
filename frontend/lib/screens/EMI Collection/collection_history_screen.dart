import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import 'daily_collection_report_screen.dart';
import 'payment_receipt_screen.dart';
import 'collection_record_model.dart';

class CollectionHistoryScreen extends StatefulWidget {
  const CollectionHistoryScreen({super.key});

  @override
  State<CollectionHistoryScreen> createState() => _CollectionHistoryScreenState();
}

class _CollectionHistoryScreenState extends State<CollectionHistoryScreen> {
  final List<CollectionRecord> _records = [
    const CollectionRecord(
      receiptNo: 'RCPT-20260810043957-0005',
      loanNo: 'LN-2026-0001',
      customerName: 'Roki',
      emiInstalment: '#1',
      date: '10 Aug 2026',
      amount: 2063,
      mode: 'Cash',
      staff: 'CF Admin',
    ),
    const CollectionRecord(
      receiptNo: 'RCPT-20260710052704-0001',
      loanNo: 'LN-2026-0003',
      customerName: 'Jessica',
      emiInstalment: '#1',
      date: '10 Jul 2026',
      amount: 508,
      mode: 'UPI',
      staff: 'CF Admin',
    ),
    const CollectionRecord(
      receiptNo: 'RCPT-20260710052904-0002',
      loanNo: 'LN-2026-0003',
      customerName: 'Jessica',
      emiInstalment: '#2',
      date: '10 Jul 2026',
      amount: 508,
      mode: 'Cash',
      staff: 'CF Admin',
    ),
    const CollectionRecord(
      receiptNo: 'RCPT-20260710052950-0003',
      loanNo: 'LN-2026-0003',
      customerName: 'Jessica',
      emiInstalment: '#3',
      date: '10 Jul 2026',
      amount: 5000,
      mode: 'Cash',
      staff: 'CF Admin',
    ),
    const CollectionRecord(
      receiptNo: 'RCPT-20260710063915-0004',
      loanNo: 'LN-2026-0002',
      customerName: 'Varshini',
      emiInstalment: '#1',
      date: '10 Jul 2026',
      amount: 2996,
      mode: 'Cash',
      staff: 'CF Admin',
    ),
  ];

  void _navToDailyReport() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DailyCollectionReportScreen()),
    );
  }

  void _navToReceipt() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaymentReceiptScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Collection History',
      subtitle: 'Lifetime collections: ₹11076',
      titleIcon: Icons.payments_outlined,
      children: [
        // Top Action Buttons
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _navToDailyReport,
              icon: const Icon(Icons.calendar_today, size: 16, color: Colors.black87),
              label: const Text('Today\'s Collections', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                side: const BorderSide(color: AppColors.kBorder),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text('All History', style: TextStyle(color: Colors.black54)),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Responsive Filter Form
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 700;

              if (isMobile) {
                // Mobile stacked layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterInput('Search', 'Loan #, customer...', flex: false),
                    const SizedBox(height: 16),
                    _buildFilterDropdown('Payment Mode', 'All Modes', flex: false),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildFilterInput('From', '22/08/2026', flex: false)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildFilterInput('To', '22/08/2026', flex: false)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildActionButton(true)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildActionButton(false)),
                      ],
                    )
                  ],
                );
              }

              // Desktop/Tablet inline row layout
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildFilterInput('Search', 'Loan #, customer...', flex: true, flexFactor: 3),
                  const SizedBox(width: 16),
                  _buildFilterDropdown('Payment Mode', 'All Modes', flex: true, flexFactor: 2),
                  const SizedBox(width: 16),
                  _buildFilterInput('From', '22/08/2026', flex: true, flexFactor: 2),
                  const SizedBox(width: 16),
                  _buildFilterInput('To', '22/08/2026', flex: true, flexFactor: 2),
                  const SizedBox(width: 16),
                  _buildActionButton(true),
                  const SizedBox(width: 12),
                  _buildActionButton(false),
                ],
              );
            }
          ),
        ),
        const SizedBox(height: 24),

        // Data Table
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
              headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
              dataRowMaxHeight: 70,
              dataRowMinHeight: 60,
              columns: const [
                DataColumn(label: Text('RECEIPT')),
                DataColumn(label: Text('LOAN DETAILS')),
                DataColumn(label: Text('CUSTOMER')),
                DataColumn(label: Text('EMI')),
                DataColumn(label: Text('DATE')),
                DataColumn(label: Text('PAID AMOUNT')),
                DataColumn(label: Text('MODE')),
                DataColumn(label: Text('ACTIONS')),
              ],
              rows: _records.map((r) => DataRow(cells: [
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(4)),
                    child: Text(r.receiptNo, style: TextStyle(color: Colors.indigo.shade400, fontWeight: FontWeight.w600)),
                  ),
                ),
                DataCell(Text(r.loanNo, style: TextStyle(color: Colors.indigo.shade400, fontWeight: FontWeight.w600))),
                DataCell(Text(r.customerName, style: const TextStyle(fontWeight: FontWeight.bold))),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                    child: Text(r.emiInstalment, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                ),
                DataCell(Text(r.date, style: const TextStyle(color: Colors.black54))),
                DataCell(Text('₹${r.amount.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.kSuccess))),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                    child: Text(r.mode, style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.receipt_long, size: 18, color: Colors.blue.shade400),
                      onPressed: _navToReceipt, // Wires up the receipt page
                      tooltip: 'View Receipt',
                    ),
                    IconButton(
                      icon: const Icon(Icons.visibility_outlined, size: 18, color: Colors.grey),
                      onPressed: () {},
                      tooltip: 'View Details',
                    ),
                  ],
                )),
              ])).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // --- Filter Helper Widgets ---

  Widget _buildFilterInput(String label, String hint, {required bool flex, int flexFactor = 1}) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
        ),
      ],
    );
    return flex ? Expanded(flex: flexFactor, child: child) : child;
  }

  Widget _buildFilterDropdown(String label, String value, {required bool flex, int flexFactor = 1}) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: DropdownButtonFormField<String>(
            value: value,
            items: [value].map((String val) {
              return DropdownMenuItem<String>(value: val, child: Text(val));
            }).toList(),
            onChanged: (_) {},
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
        ),
      ],
    );
    return flex ? Expanded(flex: flexFactor, child: child) : child;
  }

  Widget _buildActionButton(bool isSearch) {
    if (isSearch) {
      return SizedBox(
        height: 48,
        width: 60,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kSuccess,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.zero,
          ),
          child: const Icon(Icons.search, color: Colors.white, size: 20),
        ),
      );
    }
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.grey.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: const Text('Reset', style: TextStyle(color: Colors.black87)),
      ),
    );
  }
}