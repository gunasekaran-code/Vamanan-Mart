import 'package:flutter/material.dart';

class BranchPerformanceScreen extends StatelessWidget {
  const BranchPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox.shrink(), // Hiding default back button to use custom
        leadingWidth: 0,
        title: const Row(
          children: [
            Icon(Icons.apartment, color: Color(0xFF2563EB)),
            SizedBox(width: 8),
            Text(
              'Branch Performance',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
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
              'Comprehensive analysis of loan distribution and recovery across all branches.',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16, color: Colors.black87),
              label: const Text('Back to Dashboard', style: TextStyle(color: Colors.black87)),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            
            _buildBranchCard(
              title: 'Main Office',
              customers: '5 Active Customers',
              disbursed: '₹10105000',
              outstanding: '₹14228625',
              active: '1',
              closed: '0',
              defaultCount: '0',
              recoveryProgress: 0.0,
            ),
            const SizedBox(height: 16),
            
            _buildBranchCard(
              title: "Teacher's Colony Branch",
              customers: '2 Active Customers',
              disbursed: '₹100000',
              outstanding: '₹98335',
              active: '0',
              closed: '0',
              defaultCount: '0',
              recoveryProgress: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchCard({
    required String title,
    required String customers,
    required String disbursed,
    required String outstanding,
    required String active,
    required String closed,
    required String defaultCount,
    required double recoveryProgress,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(Icons.stop_rounded, color: Color(0xFF6366F1), size: 24),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(customers, style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600)),
                ],
              )
            ],
          ),
          const SizedBox(height: 24),

          // Finance Boxes
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(disbursed, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                      const SizedBox(height: 4),
                      const Text('DISBURSED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(outstanding, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFEF4444))),
                      const SizedBox(height: 4),
                      const Text('OUTSTANDING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Counts Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCountColumn(active, 'ACTIVE'),
              _buildCountColumn(closed, 'CLOSED'),
              _buildCountColumn(defaultCount, 'DEFAULT', isRed: true),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 16),

          // Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PORTFOLIO HEALTH', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
              Text('${(recoveryProgress * 100).toInt()}% Recovery', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: recoveryProgress,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF6366F1),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          )
        ],
      ),
    );
  }

  Widget _buildCountColumn(String count, String label, {bool isRed = false}) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isRed ? const Color(0xFFEF4444) : Colors.black87)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
      ],
    );
  }
}