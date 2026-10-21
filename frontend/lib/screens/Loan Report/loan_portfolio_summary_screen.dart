import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import 'branch_performance_screen.dart';
import 'monthly_collection_trend_screen.dart';

class LoanPortfolioScreen extends StatefulWidget {
  const LoanPortfolioScreen({super.key});

  @override
  State<LoanPortfolioScreen> createState() => _LoanPortfolioSummaryScreenState();
}

class _LoanPortfolioSummaryScreenState extends State<LoanPortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.bar_chart, color: Color(0xFF5A52FF)),
            SizedBox(width: 8),
            Text(
              'Loan Portfolio Summary',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Comprehensive overview of loan distributions and collections',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 16),
            
            // Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BranchPerformanceScreen())),
                    icon: const Icon(Icons.business, size: 16),
                    label: const Text('Branch Report'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MonthlyCollectionTrendScreen())),
                    icon: const Icon(Icons.show_chart, size: 16),
                    label: const Text('Monthly Trend'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Filters
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Branch', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  _buildDropdown('All Branches'),
                  const SizedBox(height: 16),
                  const Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 8),
                  _buildDropdown('All Statuses'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_list, size: 16, color: Colors.white),
                          label: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981), // Green
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          child: const Text('Clear', style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stat Cards Grid
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.1,
              children: const [
                StatCard(label: 'TOTAL LOANS', value: '6', icon: Icons.description_outlined, color: Color(0xFF8B5CF6)),
                StatCard(label: 'TOTAL DISBURSED', value: '₹10155000', icon: Icons.payments_outlined, color: Color(0xFF10B981)),
                StatCard(label: 'OUTSTANDING BALANCE', value: '₹3558', icon: Icons.arrow_downward, color: Color(0xFFEF4444)),
                StatCard(label: 'TOTAL COLLECTED', value: '₹91076', icon: Icons.check_circle_outline, color: Color(0xFF14B8A6)),
              ],
            ),
            const SizedBox(height: 24),

            // Status Breakdown
            _buildSectionContainer(
              title: 'Status Breakdown',
              icon: Icons.pie_chart_outline,
              iconColor: const Color(0xFF8B5CF6),
              child: _buildStatusTable(),
            ),
            const SizedBox(height: 24),

            // Branch-wise Distribution
            _buildSectionContainer(
              title: 'Branch-wise Distribution',
              icon: Icons.business_outlined,
              iconColor: const Color(0xFF8B5CF6),
              child: _buildBranchTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          items: [DropdownMenuItem(value: value, child: Text(value))],
          onChanged: (v) {},
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required String title, required IconData icon, required Color iconColor, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: iconColor.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildStatusTable() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: 2, child: Text('STATUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54))),
            Expanded(flex: 1, child: Text('COUNT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54))),
            Expanded(flex: 2, child: Text('TOTAL PRINCIPAL', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54))),
          ],
        ),
        const Divider(height: 24),
        _buildStatusRow('Active', '1', '₹5000'),
        const Divider(height: 24),
        _buildStatusRow('Approved', '5', '₹10150000'),
      ],
    );
  }

  Widget _buildStatusRow(String status, String count, String total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
              child: Text(status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
            ),
          ),
        ),
        Expanded(flex: 1, child: Text(count, style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text(total, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildBranchTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
        columnSpacing: 24,
        columns: const [
          DataColumn(label: Text('BRANCH')),
          DataColumn(label: Text('LOANS')),
          DataColumn(label: Text('DISBURSED')),
          DataColumn(label: Text('OUTSTANDING')),
          DataColumn(label: Text('STATUS (A/C/D)')),
        ],
        rows: [
          _buildBranchRow('Main Office', '5', '₹10105000', '₹14228625', 1, 0, 0),
          _buildBranchRow("Teacher's Colony Branch", '1', '₹50000', '₹49167', 0, 0, 0),
        ],
      ),
    );
  }

  DataRow _buildBranchRow(String branch, String loans, String disbursed, String outstanding, int active, int closed, int defaultCount) {
    return DataRow(
      cells: [
        DataCell(Text(branch, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(loans)),
        DataCell(Text(disbursed, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(outstanding, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFEF4444)))),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMiniStatusBadge(active.toString(), const Color(0xFF10B981)), // Green
            const SizedBox(width: 4),
            _buildMiniStatusBadge(closed.toString(), Colors.grey.shade500),
            const SizedBox(width: 4),
            _buildMiniStatusBadge(defaultCount.toString(), const Color(0xFFEF4444)), // Red
          ],
        )),
      ],
    );
  }

  Widget _buildMiniStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}