import 'package:flutter/material.dart';
import 'overdue_record_model.dart';
import 'overdue_customers_report_screen.dart';
import 'record_emi_payment_screen.dart';

class OverdueRecoveryQueueScreen extends StatefulWidget {
  const OverdueRecoveryQueueScreen({super.key});

  @override
  State<OverdueRecoveryQueueScreen> createState() => _OverdueRecoveryQueueScreenState();
}

class _OverdueRecoveryQueueScreenState extends State<OverdueRecoveryQueueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
        title: const Text('SmartFinance', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overdue Recovery Queue', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Row(
                        children: [
                          const Text('Recovery target: ', style: TextStyle(color: Colors.black54)),
                          Text('₹244870', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const OverdueCustomersReportScreen()));
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.white,
              ),
              child: const Text('View Report', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),

            // Filters
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Branch Recovery Focus', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
                      const SizedBox(height: 8),
                      isMobile 
                        ? Column(
                            children: [
                              _buildBranchDropdown(),
                              const SizedBox(height: 12),
                              _buildActionButtons(isMobile: true),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(flex: 2, child: _buildBranchDropdown()),
                              const SizedBox(width: 16),
                              Expanded(flex: 1, child: _buildActionButtons(isMobile: false)),
                            ],
                          )
                    ],
                  );
                }
              ),
            ),
            const SizedBox(height: 24),

            // Table
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                  dataRowMaxHeight: 75,
                  dataRowMinHeight: 65,
                  columns: const [
                    DataColumn(label: Text('CUSTOMER DETAILS')),
                    DataColumn(label: Text('LOAN / BRANCH')),
                    DataColumn(label: Text('INSTALMENT')),
                    DataColumn(label: Text('DUE DATE')),
                    DataColumn(label: Text('EMI + PENALTY')),
                    DataColumn(label: Text('DAYS LATE')),
                    DataColumn(label: Text('ACTION')),
                  ],
                  rows: sampleOverdueRecords.map((r) => _buildDataRow(r, context)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchDropdown() {
    return SizedBox(
      height: 45,
      child: DropdownButtonFormField<String>(
        value: 'All Branches',
        items: ['All Branches', 'Main Office', 'Teacher\'s Colony'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (_) {},
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        ),
      ),
    );
  }

  Widget _buildActionButtons({required bool isMobile}) {
    Widget applyBtn = ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFDC3545), // Red
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Text('Apply Filter', style: TextStyle(color: Colors.white)),
    );
    
    Widget resetBtn = TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: const Text('Reset', style: TextStyle(color: Colors.black87)),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [applyBtn, const SizedBox(height: 8), resetBtn],
      );
    }
    return Row(
      children: [Expanded(child: applyBtn), const SizedBox(width: 8), Expanded(child: resetBtn)],
    );
  }

  DataRow _buildDataRow(OverdueRecord r, BuildContext context) {
    return DataRow(cells: [
      DataCell(Row(
        children: [
          CircleAvatar(backgroundColor: Colors.indigo.shade50, child: Text(r.initial, style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(children: [const Icon(Icons.phone, size: 12, color: Colors.black54), const SizedBox(width: 4), Text(r.phone, style: const TextStyle(fontSize: 12, color: Colors.black54))]),
            ],
          )
        ],
      )),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(r.loanNo, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade600)),
          Text(r.branch, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade300)),
        child: Text(r.instalment, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule, size: 12, color: Colors.red.shade700),
            const SizedBox(width: 4),
            Text(r.dueDate, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red.shade800)),
          ],
        ),
      )),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('₹${r.principal.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text('+ ₹${r.penalty.toInt()} penalty', style: TextStyle(fontSize: 12, color: Colors.red.shade600, fontWeight: FontWeight.bold)),
        ],
      )),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(16)),
        child: Text(r.aging, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red.shade700)),
      )),
      DataCell(ElevatedButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => RecordEmiPaymentScreen(record: r)));
        },
        icon: const Icon(Icons.money, size: 16, color: Colors.white),
        label: const Text('Collect', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE63946), // Action Red
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      )),
    ]);
  }
}