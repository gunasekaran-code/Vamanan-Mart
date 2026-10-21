// lib/screens/settings/company_settings_view.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_toast.dart';
import 'settings_page.dart';

class CompanySettingsView extends StatefulWidget {
  const CompanySettingsView({super.key});

  @override
  State<CompanySettingsView> createState() => _CompanySettingsViewState();
}

class _CompanySettingsViewState extends State<CompanySettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.kBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(
            icon: Icons.settings_applications,
            iconBgColor: Colors.blue.shade600,
            title: 'Enterprise Parameters',
            subtitle: 'Configure global financial and operational rules',
          ),
          const SizedBox(height: 32),
          
          _buildParamField('CHIT INTEREST RATE', '0', 'Default monthly interest rate percentage for late payments.'),
          const SizedBox(height: 24),
          _buildParamField('BID INCREMENT STEP', '0', 'Minimum amount a bid must increase in an auction (₹).'),
          const SizedBox(height: 24),
          _buildParamField('PENALTY GRACE PERIOD', '0', 'Number of days allowed after due date before late fee applies.'),
          const SizedBox(height: 24),
          _buildParamField('SYSTEM CURRENCY', 'INR', 'Base currency for all financial calculations.'),
          const SizedBox(height: 24),
          _buildParamField('ADMIN CONTACT EMAIL', 'admin@chitfund.com', 'System-wide contact email for user notifications.'),
          const SizedBox(height: 24),
          _buildParamField('MAX MEMBERS PER CHIT', '50', 'Standard restriction for the number of participants in new groups.'),
          const SizedBox(height: 24),
          _buildParamField('COMPANY NAME', 'SmartChit Management', 'The official name of the company'),
          const SizedBox(height: 24),
          _buildParamField('REGISTER NUMBER', 'REG-10293847', 'Legal registration number of the entity'),
          const SizedBox(height: 24),
          _buildParamField('COMPANY CITY', 'Chennai', 'City where the head office is located'),
          const SizedBox(height: 24),
          _buildParamField('COMPANY STATE', 'Tamil Nadu', 'State where the head office is located'),
          const SizedBox(height: 24),
          _buildParamField('GST NUMBER', '33AAACM1234F1Z1', 'GSTIN for tax purposes'),
          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () => ToastService.show(title: 'Cloud Sync Complete', message: 'Enterprise parameters updated.', type: ToastType.success),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kSuccess,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Commit Settings to Cloud', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildParamField(String label, String value, String helper) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.kTextDark),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kBackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 14, color: Colors.blue.shade700),
            const SizedBox(width: 6),
            Expanded(child: Text(helper, style: TextStyle(fontSize: 11, color: Colors.blue.shade800))),
          ],
        )
      ],
    );
  }
}