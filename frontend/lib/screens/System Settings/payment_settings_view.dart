// lib/screens/settings/payment_settings_view.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_toast.dart';
import 'settings_page.dart';

class PaymentSettingsView extends StatelessWidget {
  const PaymentSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.kBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(
            icon: Icons.credit_card_outlined,
            iconBgColor: Colors.blue.shade500,
            title: 'Payment Configuration',
            subtitle: 'Configure digital collection channels and QR assets.',
          ),
          const SizedBox(height: 40),
          
          // QR Asset Card (Dashed Styling Effect)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.kSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300, width: 2, strokeAlign: BorderSide.strokeAlignOutside),
            ),
            child: Column(
              children: [
                Icon(Icons.qr_code_scanner, size: 48, color: Colors.blue.shade400),
                const SizedBox(height: 16),
                const Text('UPI QR Codes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Upload and manage QR codes displayed to customers during checkout.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.kTextMuted)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => ToastService.show(title: 'Asset Manager', message: 'Opening QR Asset gallery...'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.kSuccess, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
                  child: const Text('Manage QR Assets', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Bank Integration Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.kBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_balance, size: 36, color: Colors.grey.shade500),
                const SizedBox(height: 16),
                const Text('Bank Integration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                const Text('Direct bank reconciliation and automated payout logic (Coming Soon).', style: TextStyle(color: AppColors.kTextMuted)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400, elevation: 0, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                  child: const Text('Setup API', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}