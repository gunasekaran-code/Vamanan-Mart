// lib/screens/settings/settings_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'profile_settings_view.dart';
import 'company_settings_view.dart';
import 'alerts_settings_view.dart';
import 'payment_settings_view.dart';
import 'security_settings_view.dart';

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  State<SystemSettingsScreen> createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'label': 'Profile', 'icon': Icons.person_outline},
    {'label': 'Company', 'icon': Icons.business},
    {'label': 'Alerts', 'icon': Icons.notifications_none},
    {'label': 'Payments', 'icon': Icons.qr_code},
    {'label': 'Security', 'icon': Icons.security},
  ];

  final List<Widget> _views = [
    const ProfileSettingsView(),
    const CompanySettingsView(),
    const AlertsSettingsView(),
    const PaymentSettingsView(),
    const SecuritySettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        toolbarHeight: 0, // Hidden app bar for clean background
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800), // Desktop max width
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              // Header Title
              Text('System Settings', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: AppColors.kTextDark)),
              const SizedBox(height: 8),
              const Text('Manage organizational parameters and personal security.', style: TextStyle(color: AppColors.kTextMuted, fontSize: 14)),
              const SizedBox(height: 32),

              // Custom Horizontal Tab Bar
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.kSurface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.kBorder),
                  ),
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _currentIndex == index;
                      final tab = _tabs[index];
                      return GestureDetector(
                        onTap: () => setState(() => _currentIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.kSuccess : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                tab['icon'],
                                size: 18,
                                color: isSelected ? Colors.white : AppColors.kTextMuted,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tab['label'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : AppColors.kTextMuted,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Display Selected View
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _views[_currentIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SHARED HELPER WIDGET FOR SETTINGS PAGES ---
class SettingsHeader extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String subtitle;

  const SettingsHeader({super.key, required this.icon, required this.iconBgColor, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.kTextDark)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 13, color: AppColors.kTextMuted)),
            ],
          ),
        )
      ],
    );
  }
}