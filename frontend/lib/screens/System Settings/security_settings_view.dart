// lib/screens/settings/security_settings_view.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_toast.dart';
import 'settings_page.dart';

class SecuritySettingsView extends StatefulWidget {
  const SecuritySettingsView({super.key});

  @override
  State<SecuritySettingsView> createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends State<SecuritySettingsView> {
  bool _obsCurrent = true;
  bool _obsNew = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.kBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader(
            icon: Icons.fingerprint,
            iconBgColor: Colors.red.shade500,
            title: 'Admin Fortification',
            subtitle: 'Secure your high-level access with encrypted protocols.',
          ),
          const SizedBox(height: 32),
          
          _buildPassField('CURRENT PASSCODE', _obsCurrent, () => setState(() => _obsCurrent = !_obsCurrent)),
          const SizedBox(height: 24),
          _buildPassField('NEW PASSCODE', _obsNew, () => setState(() => _obsNew = !_obsNew)),
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => ToastService.show(title: 'Security Updated', message: 'Passcode successfully changed.', type: ToastType.success),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E293B), // Dark Navy
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Renew Security Credentials', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 32),

          // Security Audit Box
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.kBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.shield, color: Colors.blue, size: 20),
                    SizedBox(width: 8),
                    Text('Security Audit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 24),
                _buildAuditRow(Icons.circle, Colors.red, 'Multi-factor (2FA)', 'Enable Now', Colors.orange.shade50, Colors.orange.shade800),
                const SizedBox(height: 24),
                _buildAuditRow(Icons.circle, AppColors.kSuccess, 'Activity Tracking', 'Active', AppColors.kPrimaryLight, AppColors.kPrimaryDark),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue.shade700, size: 18),
                      const SizedBox(width: 8),
                      Text('Password rotate recommended every 90 days.', style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPassField(String label, bool isObscured, VoidCallback onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isObscured,
          initialValue: 'password123',
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.kTextDark, letterSpacing: 2),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kBackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: Icon(isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black45),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuditRow(IconData icon, Color iconColor, String title, String badgeText, Color badgeBg, Color badgeTextCol) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 12),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(20)),
          child: Text(badgeText, style: TextStyle(color: badgeTextCol, fontWeight: FontWeight.bold, fontSize: 11)),
        )
      ],
    );
  }
}