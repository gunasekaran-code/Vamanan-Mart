import 'dart:async';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/stat_card.dart';
import '../../screens/Branches/branches_page.dart';

// --- Dummy Model for Performance Data ---
class BranchPerformance {
  final String name;
  final String gst;
  final int members;
  final int chits;
  final int loans;
  final String status;
  final double pulseValue;
  final String pulseLabel;
  final int totalCollection;
  final int chitCollection;
  final int loanCollection;

  const BranchPerformance({
    required this.name,
    required this.gst,
    required this.members,
    required this.chits,
    required this.loans,
    required this.status,
    required this.pulseValue,
    required this.pulseLabel,
    required this.totalCollection,
    required this.chitCollection,
    required this.loanCollection,
  });
}

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsScreen> {
  // --- Working Live Clock Logic ---
  late Timer _timer;
  late DateTime _currentTime;

  // --- Dummy Data matching your screenshots ---
  final List<BranchPerformance> _performanceData = [
    const BranchPerformance(
      name: 'Main Office',
      gst: '33ABCDEF12Z53',
      members: 1,
      chits: 0,
      loans: 3,
      status: 'Stable',
      pulseValue: 0.0,
      pulseLabel: 'Active Engagement',
      totalCollection: 0,
      chitCollection: 0,
      loanCollection: 0,
    ),
    const BranchPerformance(
      name: "Teacher's Colony Branch",
      gst: '33XYZDEF12Z59', // Slightly adjusted for distinction
      members: 2,
      chits: 0,
      loans: 2,
      status: 'Stable',
      pulseValue: 0.0,
      pulseLabel: 'Active Engagement',
      totalCollection: 2063,
      chitCollection: 0,
      loanCollection: 2063,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    // Update the clock every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Simple time formatter so you don't need the intl package
  String _formatTime(DateTime time) {
    int h = time.hour;
    int m = time.minute;
    int s = time.second;
    String ampm = h >= 12 ? 'PM' : 'AM';
    if (h > 12) h -= 12;
    if (h == 0) h = 12;
    
    String hh = h.toString().padLeft(2, '0');
    String mm = m.toString().padLeft(2, '0');
    String ss = s.toString().padLeft(2, '0');
    return "$hh:$mm:$ss $ampm";
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AppPage(
      title: 'Executive Regional Performance',
      subtitle: 'Comparative performance report across all physical locations.',
      // Adding top actions using the header trailing slot if AppPage supports it, 
      // otherwise placing them directly in the body layout.
      children: [
        // --- Top Action Buttons ---
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.print_outlined, size: 18),
                label: const Text('Print Report', style: TextStyle(fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.kInfo,
                  side: const BorderSide(color: AppColors.kBorder),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  // Redirect to Branches Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BranchesScreen()),
                  );
                },
                icon: const Icon(Icons.settings, size: 18),
                label: const Text('Manage Branches', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSuccess,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),

        // --- Responsive Stats Cards ---
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'Active Branches',
                value: '2',
                icon: Icons.home_work_outlined,
                color: AppColors.kSuccess,
              ),
            ),
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'Global Members',
                value: '3',
                icon: Icons.people_alt_outlined,
                color: AppColors.kInfo,
              ),
            ),
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'Total Global Collection',
                value: '₹20076',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColors.kWarning,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 32),

        // --- High-Density Real-time Pulse Section ---
        Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Pulse Header with Live Timer
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.show_chart, color: AppColors.kDanger.withOpacity(0.8), size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'High-Density Real-time Pulse',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                    if (!isMobile) _buildLiveTrackingBadge(),
                  ],
                ),
              ),
              if (isMobile) 
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLiveTrackingBadge(),
                    ],
                  ),
                ),
              const Divider(height: 1, color: AppColors.kBorder),
              
              // Data View (Responsive)
              isMobile ? _buildMobileList() : _buildDesktopTable(),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // --- Chart Section: Branch Performance Matrix ---
        _buildPerformanceChart(isMobile),
      ],
    );
  }

  // --- WIDGETS ---

  Widget _buildLiveTrackingBadge() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, color: Colors.red, size: 8),
              const SizedBox(width: 6),
              const Text(
                'LIVE TRACKING',
                style: TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _formatTime(_currentTime),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.kTextDark),
        ),
      ],
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _performanceData.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.kBorder),
      itemBuilder: (context, index) {
        final data = _performanceData[index];
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              _buildGstBadge(data.gst),
              const SizedBox(height: 16),
              const Text('Metrics', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildMetricsRow(data),
              const SizedBox(height: 16),
              const Text('Activity Pulse', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildPulseBar(data),
              const SizedBox(height: 16),
              const Text('This Month (August 2026)', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildCollectionsInfo(data, isMobile: true),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 32,
        headingRowHeight: 56,
        dataRowMinHeight: 85,
        dataRowMaxHeight: 85,
        headingTextStyle: const TextStyle(color: AppColors.kTextDark, fontWeight: FontWeight.bold, fontSize: 14),
        columns: const [
          DataColumn(label: Text('Branch & Identity')),
          DataColumn(label: Text('Metrics')),
          DataColumn(label: Text('Growth (30d)')),
          DataColumn(label: Text('Activity Pulse')),
          DataColumn(label: Text('This Month (August 2026)')),
        ],
        rows: _performanceData.map((data) {
          return DataRow(
            cells: [
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 6),
                    _buildGstBadge(data.gst),
                  ],
                ),
              ),
              DataCell(_buildMetricsRow(data)),
              DataCell(Text(data.status, style: const TextStyle(color: AppColors.kTextMuted))),
              DataCell(
                SizedBox(
                  width: 150,
                  child: _buildPulseBar(data),
                ),
              ),
              DataCell(_buildCollectionsInfo(data)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGstBadge(String gst) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'GST: $gst',
        style: TextStyle(color: Colors.blue.shade700, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMetricsRow(BranchPerformance data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.people_outline, size: 14, color: AppColors.kTextMuted),
            const SizedBox(width: 4),
            Text('${data.members}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text(' Members', style: TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildSmallBadge(Icons.layers_outlined, '${data.chits} Chits', Colors.blue),
            const SizedBox(width: 8),
            _buildSmallBadge(Icons.account_balance_outlined, '${data.loans} Loans', Colors.cyan),
          ],
        )
      ],
    );
  }

  Widget _buildSmallBadge(IconData icon, String text, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color.shade700),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color.shade700, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildPulseBar(BranchPerformance data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: data.pulseValue,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.blue,
                  minHeight: 6,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('${data.pulseValue.toStringAsFixed(1)}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        Text(data.pulseLabel, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 11)),
      ],
    );
  }

  Widget _buildCollectionsInfo(BranchPerformance data, {bool isMobile = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          '₹${data.totalCollection}',
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          'Chit: ₹${data.chitCollection}',
          style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          'Loan: ₹${data.loanCollection}',
          style: TextStyle(color: Colors.cyan.shade600, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // --- Custom Built Chart Layout ---
  Widget _buildPerformanceChart(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Branch Performance Matrix', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Current Month Snapshot: Actual Collections vs Regional Targets (August 2026)', style: TextStyle(color: AppColors.kTextMuted)),
          const SizedBox(height: 24),
          
          // Chart Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(Colors.indigo.shade400, 'Chit Collections'),
              const SizedBox(width: 24),
              _buildLegendItem(Colors.lightBlue, 'Loan Collections'),
            ],
          ),
          const SizedBox(height: 32),

          // Custom Chart Area
          SizedBox(
            height: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-Axis Labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('₹2500', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('₹2000', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('₹1500', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('₹1000', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('₹500', style: TextStyle(fontSize: 10, color: Colors.black54)),
                    Text('₹0', style: TextStyle(fontSize: 10, color: Colors.black54)),
                  ],
                ),
                const SizedBox(width: 16),
                
                // Bars Layout
                Expanded(
                  child: Stack(
                    children: [
                      // Grid Lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) => const Divider(color: Colors.black12, height: 1)),
                      ),
                      
                      // Actual Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBarStack(chit: 0, loan: 0, label: 'Main Office', isMobile: isMobile),
                          _buildBarStack(chit: 0, loan: 2063, label: "Teacher's Colony Branch", isMobile: isMobile),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
      ],
    );
  }

  Widget _buildBarStack({required int chit, required int loan, required String label, required bool isMobile}) {
    // 2500 is max chart value. Container height is approx 220px.
    const double maxVal = 2500.0;
    const double maxHeight = 220.0;
    
    final double chitHeight = (chit / maxVal) * maxHeight;
    final double loanHeight = (loan / maxVal) * maxHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Bar stack
        Container(
          width: isMobile ? 40 : 60, // Thinner bars on mobile
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            color: Colors.transparent,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (loanHeight > 0) Container(height: loanHeight, color: Colors.lightBlue),
              if (chitHeight > 0) Container(height: chitHeight, color: Colors.indigo.shade400),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // X-Axis Label
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}