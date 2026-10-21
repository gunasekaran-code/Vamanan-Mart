import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import '../../widgets/stat_card.dart';

// --- Dummy Data Model ---
class BroadcastHistory {
  final String meta;
  final String title;
  final String content;
  final int impact;
  final String status;

  const BroadcastHistory({
    required this.meta,
    required this.title,
    required this.content,
    required this.impact,
    required this.status,
  });
}

class BroadcastScreen extends StatefulWidget {
  const BroadcastScreen({super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastPageState();
}

class _BroadcastPageState extends State<BroadcastScreen> {
  // Controllers for real-time preview
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _msgCtrl = TextEditingController();
  
  String _urgency = 'Standard'; // Standard, Reminder, Critical

  // Dummy Data matching exactly to the desktop table screenshot
  final List<BroadcastHistory> _history = [
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Pending Cash Handover', content: "Staff 'Mani Mani' requested handover for ₹1000....", impact: 1, status: 'WARNING'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'New Payment Evidence', content: "Proof submitted for Roki (₹1000.00). Review requ...", impact: 2, status: 'INFO'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Test 50%Off', content: "Welcome to Smart Chit Fund", impact: 1, status: 'INFO'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'New Payment Evidence', content: "Proof submitted for Jessica (₹1000.00). Review r...", impact: 1, status: 'INFO'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Offer for EducationLoan', content: "75%Off for EducationLoan", impact: 1, status: 'INFO'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Loan Payment Recorded', content: "A payment of ₹508.33 has been recorded for Je...", impact: 1, status: 'SUCCESS'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'New Loan Payment Proof', content: "Customer VEERASAMY.K has submitted a payme...", impact: 1, status: 'WARNING'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Loan Payment Recorded', content: "A payment of ₹2063.22 has been recorded for R...", impact: 2, status: 'SUCCESS'),
    const BroadcastHistory(meta: 'Bulk Grouped', title: 'Pending Cash', content: "Hello", impact: 5, status: 'INFO'),
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to update the mobile preview in real-time
    _titleCtrl.addListener(() => setState(() {}));
    _msgCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _dispatchBroadcast() {
    if (_titleCtrl.text.isEmpty || _msgCtrl.text.isEmpty) {
      ToastService.show(title: 'Error', message: 'Please fill in all fields.', type: ToastType.error);
      return;
    }
    ToastService.show(title: 'Broadcast Dispatched', message: 'Campaign sent successfully to all active channels.', type: ToastType.success);
    setState(() {
      _titleCtrl.clear();
      _msgCtrl.clear();
      _urgency = 'Standard';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900; // Adjusted breakpoint for 2-column layout

    return AppPage(
      title: 'Broadcast Hub',
      subtitle: 'Compose and dispatch multi-channel alerts to all active members.',
      children: [
        // Top Stat Card
        Row(
          children: [
            SizedBox(
              width: 200,
              child: StatCard(
                label: 'Total Reach',
                value: '6',
                icon: Icons.people_alt,
                color: Colors.indigo.shade400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Composer & Preview Section
        if (isMobile)
          Column(
            children: [
              _buildComposerCard(),
              const SizedBox(height: 24),
              _buildMobilePreviewCard(),
              const SizedBox(height: 24),
              _buildActiveChannelsCard(),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildComposerCard(),
                    const SizedBox(height: 24),
                    _buildActiveChannelsCard(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: _buildMobilePreviewCard(),
              ),
            ],
          ),

        const SizedBox(height: 32),

        // Sent History Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.history_toggle_off, color: AppColors.kTextDark),
                const SizedBox(width: 8),
                Text('Sent History', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text('Export Logs'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.kTextDark,
                side: const BorderSide(color: AppColors.kBorder),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: isMobile ? _buildHistoryMobileList() : _buildHistoryDesktopTable(),
        ),
      ],
    );
  }

  // --- COMPOSER WIDGET ---
  Widget _buildComposerCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.campaign_outlined, color: Colors.indigo.shade400, size: 20),
              ),
              const SizedBox(width: 12),
              const Text('Campaign Composer', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          
          const Text('INTERNAL REFERENCE / TITLE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _titleCtrl,
            decoration: InputDecoration(
              hintText: 'Title',
              prefixIcon: const Icon(Icons.sell_outlined, size: 18),
              filled: true,
              fillColor: AppColors.kBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          
          const SizedBox(height: 20),
          const Text('MESSAGE CONTENT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _msgCtrl,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Your broadcast message goes here...',
              filled: true,
              fillColor: AppColors.kBackground,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Supports plain text & emojis', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12)),
              Text('${_msgCtrl.text.length} characters', style: const TextStyle(color: AppColors.kInfo, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          
          const SizedBox(height: 24),
          const Text('URGENCY LEVEL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: [
              _buildUrgencyToggle('Standard', Colors.cyan),
              _buildUrgencyToggle('Reminder', Colors.amber.shade700),
              _buildUrgencyToggle('Critical', Colors.red.shade400),
            ],
          ),
          
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.kBackground, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: const [
                Icon(Icons.shield_outlined, color: AppColors.kSuccess, size: 20),
                SizedBox(width: 12),
                Expanded(child: Text('Broadcasts are audited. Ensure content complies with transparency policies.', style: TextStyle(fontSize: 13, color: AppColors.kTextDark))),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _dispatchBroadcast,
              icon: const Icon(Icons.sensors),
              label: const Text('Dispatch Broadcast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kSuccess,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencyToggle(String label, Color color) {
    final isSelected = _urgency == label;
    return GestureDetector(
      onTap: () => setState(() => _urgency = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // --- MOBILE PREVIEW WIDGET ---
  Widget _buildMobilePreviewCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark Navy Background from screenshot
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text('MOBILE PREVIEW', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          const SizedBox(height: 24),
          // Fake Phone Frame
          Container(
            width: 240,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.grey.shade300, width: 4),
            ),
            child: Column(
              children: [
                // Top Notch Area
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(height: 24),
                // Message Bubble
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(radius: 12, backgroundColor: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kBackground,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _titleCtrl.text.isEmpty ? 'Title' : _titleCtrl.text,
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _msgCtrl.text.isEmpty ? 'The message you compose here will appear...' : _msgCtrl.text,
                                style: const TextStyle(color: AppColors.kTextDark, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.fingerprint, color: Colors.black12, size: 32),
                const SizedBox(height: 32),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- ACTIVE CHANNELS WIDGET ---
  Widget _buildActiveChannelsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Channels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        _buildChannelItem(Icons.language, 'System Portal', 'Member & Web Inbox Alerts', Colors.indigo.shade100, Colors.indigo.shade600),
        const SizedBox(height: 12),
        _buildChannelItem(Icons.chat_outlined, 'WhatsApp Business', 'Encrypted Instant Notify', Colors.green.shade100, Colors.green.shade600),
        const SizedBox(height: 12),
        _buildChannelItem(Icons.email_outlined, 'Email Gateway', 'SMTP Transactional Mail', Colors.lightBlue.shade100, Colors.lightBlue.shade600),
      ],
    );
  }

  Widget _buildChannelItem(IconData icon, String title, String sub, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(sub, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: AppColors.kSuccess, size: 20),
        ],
      ),
    );
  }

  // --- HISTORY LIST & TABLE ---
  Widget _buildHistoryDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 40,
        headingRowHeight: 56,
        dataRowMinHeight: 72,
        dataRowMaxHeight: 72,
        headingTextStyle: const TextStyle(color: AppColors.kTextMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.0),
        columns: const [
          DataColumn(label: Text('DISPATCH META')),
          DataColumn(label: Text('MESSAGE CONTENT')),
          DataColumn(label: Text('IMPACT')),
          DataColumn(label: Text('STATUS')),
        ],
        rows: _history.map((item) {
          return DataRow(
            cells: [
              DataCell(Text(item.meta, style: const TextStyle(color: AppColors.kTextMuted))),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(item.content, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
                  ],
                ),
              ),
              DataCell(_buildImpactBadge(item.impact)),
              DataCell(_buildStatusBadge(item.status)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHistoryMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _history.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.kBorder),
      itemBuilder: (context, index) {
        final item = _history[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.meta, style: const TextStyle(fontSize: 11, color: AppColors.kTextMuted)),
                  _buildStatusBadge(item.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(item.content, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [_buildImpactBadge(item.impact)],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImpactBadge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.kBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 14, color: AppColors.kTextDark),
          const SizedBox(width: 4),
          Text('$count', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'WARNING':
        bgColor = Colors.orange.shade50;
        textColor = Colors.orange.shade800;
        break;
      case 'SUCCESS':
        bgColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
      case 'INFO':
      default:
        bgColor = Colors.indigo.shade50;
        textColor = Colors.indigo.shade700;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        status,
        style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}