// lib/screens/settings/alerts_settings_view.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'settings_page.dart';

class AlertsSettingsView extends StatefulWidget {
  const AlertsSettingsView({super.key});

  @override
  State<AlertsSettingsView> createState() => _AlertsSettingsViewState();
}

class _AlertsSettingsViewState extends State<AlertsSettingsView> {
  bool _emailNotif = true;
  bool _paymentRemind = false;
  bool _auctionAlerts = true;
  bool _marketing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.kBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(
            icon: Icons.chat_bubble_outline,
            iconBgColor: Colors.orange.shade500,
            title: 'Automated Notifications',
            subtitle: 'Control system triggers and alert frequency.',
          ),
          const SizedBox(height: 32),
          
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kBorder),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildToggleRow(Icons.email_outlined, 'Email Notifications', 'Receive weekly digest and account activity.', _emailNotif, (v) => setState(() => _emailNotif = v)),
                const Divider(height: 1),
                _buildToggleRow(Icons.calendar_month_outlined, 'Payment Reminders', 'Get notified about upcoming payment due dates.', _paymentRemind, (v) => setState(() => _paymentRemind = v)),
                const Divider(height: 1),
                _buildToggleRow(Icons.gavel_outlined, 'Auction Alerts', 'Real-time alerts for upcoming auction rounds.', _auctionAlerts, (v) => setState(() => _auctionAlerts = v)),
                const Divider(height: 1),
                _buildToggleRow(Icons.person_outline, 'Marketing Notifications', 'Updates about new chit groups and offers.', _marketing, (v) => setState(() => _marketing = v), isLast: true),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildToggleRow(IconData icon, String title, String subtitle, bool value, ValueChanged<bool> onChanged, {bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue.shade600, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.kTextDark)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: AppColors.kSuccess,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}