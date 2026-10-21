import 'package:flutter/material.dart';
import 'overdue_record_model.dart';
import 'record_emi_payment_screen.dart';

class OverdueCustomersReportScreen extends StatelessWidget {
  const OverdueCustomersReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Red Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red.shade500, Colors.red.shade700], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    bottom: -20,
                    child: Icon(Icons.warning_rounded, size: 120, color: Colors.white.withOpacity(0.15)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overdue Customers Report', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Attention required for defaulted installments\nacross all branches.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 24),
                      const Text('TOTAL OVERDUE & PENALTY', style: TextStyle(color: Colors.white70, fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.bold)),
                      const Text('₹5005', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Filter Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filter by Branch', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: 'All Branches',
                    items: ['All Branches'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (_) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt_outlined, size: 18, color: Colors.white),
                          label: const Text('Filter', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFDC3545),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Clear', style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // List of Overdue Items (Card based for mobile view match)
            ...sampleOverdueRecords.map((r) => _buildMobileReportCard(r, context)),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileReportCard(OverdueRecord r, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: Colors.indigo.shade50, child: Text(r.initial, style: TextStyle(color: Colors.indigo.shade700, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.customerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(r.phone, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Icon(Icons.schedule, size: 12, color: Colors.red.shade700),
                    const SizedBox(width: 4),
                    Text(r.dueDate, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red.shade800)),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.loanNo, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade600)),
                  Text(r.branch, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${r.principal.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('+ ₹${r.penalty.toInt()} penalty', style: TextStyle(fontSize: 12, color: Colors.red.shade600, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (_) => RecordEmiPaymentScreen(record: r)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE63946),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Record Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}