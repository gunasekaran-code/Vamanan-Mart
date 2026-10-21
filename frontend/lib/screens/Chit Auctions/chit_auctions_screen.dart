import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import '../../widgets/stat_card.dart';
import 'auction_details_screen.dart';

class AuctionRecord {
  final String id;
  final String groupName;
  final double chitValue;
  final String winnerName;
  final String date;
  final int month;
  final double bidDiscount;
  final double netPayout;

  const AuctionRecord({
    required this.id,
    required this.groupName,
    required this.chitValue,
    required this.winnerName,
    required this.date,
    required this.month,
    required this.bidDiscount,
    required this.netPayout,
  });
}

class ChitAuctionsScreen extends StatefulWidget {
  const ChitAuctionsScreen({super.key});

  @override
  State<ChitAuctionsScreen> createState() => _ChitAuctionsScreenState();
}

class _ChitAuctionsScreenState extends State<ChitAuctionsScreen> {
  final List<AuctionRecord> _auctions = [
    const AuctionRecord(
      id: '1',
      groupName: 'Gold',
      chitValue: 25000.00,
      winnerName: 'Roki',
      date: 'Fri, 10 Apr 2026',
      month: 1,
      bidDiscount: 5000.00,
      netPayout: 18750.00,
    ),
  ];

  void _openRecordAuctionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const RecordAuctionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Chit Auctions',
      subtitle: 'Record and review monthly bidding results for all active chit groups.',
      children: [
        // Top Action Bar
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            onPressed: _openRecordAuctionModal,
            icon: const Icon(Icons.add, size: 20),
            label: const Text(
              'New Auction',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kSuccess,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Total Rounds Stat Card
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.kBorder),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.gavel_rounded,
                          color: Colors.indigo.shade600,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_auctions.length}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kTextDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Total Rounds',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.kTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Auctions Data Table Card
        Card(
          elevation: 0,
          color: AppColors.kSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 28,
              headingRowHeight: 52,
              dataRowMinHeight: 76,
              dataRowMaxHeight: 76,
              columns: const [
                DataColumn(
                  label: Text('CHIT GROUP INFO',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.kTextMuted)),
                ),
                DataColumn(
                  label: Text('WINNER DETAILS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.kTextMuted)),
                ),
                DataColumn(
                  label: Text('MONTH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.kTextMuted)),
                ),
                DataColumn(
                  label: Text('BIDDING INFO',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.kTextMuted)),
                ),
                DataColumn(
                  label: Text('ACTIONS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppColors.kTextMuted)),
                ),
              ],
              rows: _auctions.map((auction) {
                return DataRow(
                  cells: [
                    // Group Info
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue.shade50,
                            child: Icon(Icons.groups_rounded,
                                color: Colors.blue.shade700, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(auction.groupName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 15)),
                              const SizedBox(height: 2),
                              Text(
                                'Value: ₹${auction.chitValue.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: AppColors.kTextMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Winner Details
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.indigo.shade50,
                            child: Text(
                              auction.winnerName.substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                  color: Colors.indigo.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(auction.winnerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 2),
                              Text(auction.date,
                                  style: const TextStyle(
                                      color: AppColors.kTextMuted, fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Month Tag
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          'Month ${auction.month}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ),
                    // Bidding Info
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${auction.bidDiscount.toStringAsFixed(2)} Bid',
                            style: const TextStyle(
                                color: AppColors.kDanger,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.kSuccess.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Payout: ₹${auction.netPayout.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  color: AppColors.kSuccess,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    DataCell(
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AuctionDetailsScreen(auction: auction),
                            ),
                          );
                        },
                        icon: const Icon(Icons.description_outlined, size: 16),
                        label: const Text('Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// Bottom Sheet / Screen for "Record Auction"
class RecordAuctionSheet extends StatefulWidget {
  const RecordAuctionSheet({super.key});

  @override
  State<RecordAuctionSheet> createState() => _RecordAuctionSheetState();
}

class _RecordAuctionSheetState extends State<RecordAuctionSheet> {
  String _selectedGroup = 'Gold';
  String _selectedMonth = '12';
  String _selectedWinner = 'VEERASAMY.K';
  final TextEditingController _dateController =
      TextEditingController(text: '20/04/2026');
  final TextEditingController _bidController =
      TextEditingController(text: '10000');

  @override
  void dispose() {
    _dateController.dispose();
    _bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.kBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Bar
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('Back'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Record Auction',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text(
                'Enter the monthly bidding details to automatically distribute dividends.',
                style: TextStyle(fontSize: 12, color: AppColors.kTextMuted),
              ),
            ),
            const SizedBox(height: 16),

            // Main Form Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.gavel,
                              color: Colors.blue.shade600, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Auction Event Recording',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text('Record and verify monthly auction data results',
                                style: TextStyle(
                                    fontSize: 11, color: AppColors.kTextMuted)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('CHIT GROUP'),
                        DropdownButtonFormField<String>(
                          value: _selectedGroup,
                          decoration: _inputDecoration(),
                          items: ['Gold', 'Silver', 'Diamond']
                              .map((g) => DropdownMenuItem(
                                  value: g, child: Text(g)))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedGroup = v!),
                        ),
                        const SizedBox(height: 12),
                        _buildLabel('MONTH NUMBER'),
                        DropdownButtonFormField<String>(
                          value: _selectedMonth,
                          decoration: _inputDecoration(),
                          items: List.generate(24, (i) => '${i + 1}')
                              .map((m) => DropdownMenuItem(
                                  value: m, child: Text(m)))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedMonth = v!),
                        ),
                        const SizedBox(height: 12),
                        _buildLabel('AUCTION DATE'),
                        TextField(
                          controller: _dateController,
                          decoration: _inputDecoration(),
                        ),
                        const SizedBox(height: 12),
                        _buildLabel('WINNER NAME'),
                        DropdownButtonFormField<String>(
                          value: _selectedWinner,
                          decoration: _inputDecoration(),
                          items: ['VEERASAMY.K', 'Roki', 'Jessica', 'Varshini']
                              .map((w) => DropdownMenuItem(
                                  value: w, child: Text(w)))
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedWinner = v!),
                        ),
                        const SizedBox(height: 12),
                        _buildLabel('BID (DISCOUNT) AMOUNT (₹)'),
                        TextField(
                          controller: _bidController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration().copyWith(
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(8)),
                              ),
                              child: Icon(Icons.account_balance_wallet_outlined,
                                  color: Colors.blue.shade700, size: 18),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ToastService.show(
                                    title: 'Auction Recorded',
                                    message: 'Auction for $_selectedGroup group finalized.',
                                    type: ToastType.success,
                                  );
                                },
                                icon: const Icon(Icons.verified, size: 18),
                                label: const Text('Finalize Results'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.kSuccess,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Discard Change',
                                  style: TextStyle(color: Colors.black87)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Live Payout Projection Dark Card
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E222B),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.calculate, color: Colors.amber, size: 18),
                        SizedBox(width: 8),
                        Text('Live Payout Projection',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildRow('Gross Chit Amount', '₹25,000',
                            isBold: true),
                        const Divider(height: 16),
                        _buildRow("Winner's Bid (Discount)", '₹10,000',
                            color: AppColors.kDanger, isBold: true),
                        const Divider(height: 16),
                        _buildRow('Foreman Commission', '₹1,250', isBold: true),
                        const SizedBox(height: 12),

                        // Net Winner Payout Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.kSuccess.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Net Winner Payout',
                                      style: TextStyle(
                                          color: AppColors.kSuccess,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 2),
                                  Text('₹13,750',
                                      style: TextStyle(
                                          color: AppColors.kSuccess,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.kSuccess,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text('SAFE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Dividend Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Dividend (to 3 Members)',
                                      style: TextStyle(
                                          color: Colors.blue.shade900,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.groups,
                                      size: 16, color: Colors.blue.shade700),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text('₹3,333',
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              const Text(
                                'Note: Winner is excluded from dividend.',
                                style: TextStyle(
                                    fontSize: 11, color: AppColors.kTextMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.kTextMuted)),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      fillColor: Colors.grey.shade50,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _buildRow(String label, String value,
      {Color? color, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: AppColors.kTextMuted)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: color ?? AppColors.kTextDark)),
      ],
    );
  }
}