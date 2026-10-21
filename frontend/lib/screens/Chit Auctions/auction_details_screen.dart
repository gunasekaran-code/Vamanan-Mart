import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'chit_auctions_screen.dart';

class AuctionDetailsScreen extends StatelessWidget {
  final AuctionRecord auction;

  const AuctionDetailsScreen({super.key, required this.auction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Auction Details',
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Back'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Main Gradient Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  // Purple Gradient Top Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6342E8), Color(0xFF8252F7)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Auction Month ${auction.month}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              auction.groupName,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month,
                                  size: 14, color: Color(0xFF6342E8)),
                              const SizedBox(width: 4),
                              Text(
                                '10 Apr 2026',
                                style: const TextStyle(
                                    color: Color(0xFF6342E8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Financial Metric Boxes
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildMetricBox(
                          label: 'CHIT VALUE',
                          value: '₹${auction.chitValue.toStringAsFixed(2)}',
                          valueColor: AppColors.kTextDark,
                        ),
                        const SizedBox(height: 12),
                        _buildMetricBox(
                          label: 'BID DISCOUNT',
                          value: '₹${auction.bidDiscount.toStringAsFixed(2)}',
                          valueColor: const Color(0xFFE53935),
                          borderColor: Colors.red.shade100,
                        ),
                        const SizedBox(height: 12),
                        _buildMetricBox(
                          label: 'FOREMAN FEE (5.00%)',
                          value: '₹1250.00',
                          valueColor: const Color(0xFF00ACC1),
                          borderColor: Colors.cyan.shade100,
                        ),
                        const SizedBox(height: 12),
                        _buildMetricBox(
                          label: 'NET PAYOUT',
                          value: '₹${auction.netPayout.toStringAsFixed(2)}',
                          valueColor: const Color(0xFF00897B),
                          borderColor: Colors.teal.shade100,
                        ),
                        const SizedBox(height: 16),

                        // Winner Tile
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.blue.shade50,
                                child: Icon(Icons.emoji_events_outlined,
                                    color: Colors.blue.shade600, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Auction Winner',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.kTextDark)),
                                  const SizedBox(height: 2),
                                  Text(auction.winnerName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade700)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Individual Dividend Tile
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.teal.shade50,
                                    child: Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color: Colors.teal.shade600,
                                        size: 18),
                                  ),
                                  const SizedBox(width: 12),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Individual Dividend',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold)),
                                      Text('Distributed to each of the 4 members',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: AppColors.kTextMuted)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '+ ₹2500.00',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00897B)),
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

            const SizedBox(height: 16),

            // Guarantors Dark Card Section
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.kBorder),
              ),
              child: Column(
                children: [
                  // Dark Top Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E222B),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.shield_outlined,
                                color: Colors.amber, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Guarantors',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            ToastService.show(
                              title: 'Add Guarantor',
                              message: 'Guarantor addition feature coming soon.',
                              type: ToastType.info,
                            );
                          },
                          icon: const Icon(Icons.person_add_alt_1, size: 14),
                          label: const Text('Add',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Empty State
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_off_outlined,
                            size: 40,
                            color: AppColors.kTextMuted.withOpacity(0.5)),
                        const SizedBox(height: 10),
                        const Text(
                          'No High-Security Guarantors',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: AppColors.kTextDark),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Required for fund release.',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.kTextMuted),
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

  Widget _buildMetricBox({
    required String label,
    required String value,
    required Color valueColor,
    Color? borderColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.kTextMuted,
                letterSpacing: 0.5),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }
}