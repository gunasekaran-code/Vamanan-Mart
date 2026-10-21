import 'package:flutter/material.dart';

class MonthlyCollectionTrendScreen extends StatelessWidget {
  const MonthlyCollectionTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          children: [
            Icon(Icons.show_chart, color: Color(0xFF3B82F6)),
            SizedBox(width: 8),
            Text('Monthly Collection Trend', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.print, size: 16, color: Colors.black87),
              label: const Text('Print Analysis', style: TextStyle(color: Colors.black87)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 16.0),
              child: Text(
                'Comparative analysis of EMI recovery performance over the last 12 months.',
                style: TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ),
            
            // Visualization Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Collection Visualization', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
                        child: const Text('L12M TREND', style: TextStyle(color: Color(0xFF3B82F6), fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  _buildChartRow('AUG 2026', '2 txns', '₹82063', '2 SETTLEMENTS', 0.8, const Color(0xFF8B5CF6)),
                  const SizedBox(height: 24),
                  _buildChartRow('JUL 2026', '4 txns', '₹9013', '4 SETTLEMENTS', 0.2, const Color(0xFF8B5CF6).withOpacity(0.5)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tabular Summary Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tabular Data Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingTextStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1),
                      columnSpacing: 32,
                      columns: const [
                        DataColumn(label: Text('REPORTING MONTH')),
                        DataColumn(label: Text('TRANSACTIONS')),
                        DataColumn(label: Text('TOTAL RECOVERED')),
                        DataColumn(label: Text('AVERAGE / PAYMENT')),
                        DataColumn(label: Text('TREND')),
                      ],
                      rows: [
                        _buildTableRow('August 2026', '2 txns', '₹82063', '₹41032'),
                        _buildTableRow('July 2026', '4 txns', '₹9013', '₹2253'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChartRow(String month, String txns, String amount, String settlements, double fraction, Color barColor) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(month, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 32,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
              ),
              FractionallySizedBox(
                widthFactor: fraction,
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(color: barColor, borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(txns, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(settlements, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
          ],
        )
      ],
    );
  }

  DataRow _buildTableRow(String month, String txns, String total, String average) {
    return DataRow(
      cells: [
        DataCell(Text(month, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
          child: Text(txns, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        )),
        DataCell(Text(total, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF10B981)))),
        DataCell(Text(average, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFDEF7EC), borderRadius: BorderRadius.circular(6)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_outward, size: 12, color: Color(0xFF046C4E)),
                SizedBox(width: 4),
                Text('Stable', style: TextStyle(color: Color(0xFF046C4E), fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ),
      ],
    );
  }
}