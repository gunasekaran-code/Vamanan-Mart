// lib/screens/settings/profile_settings_view.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_toast.dart';
import 'settings_page.dart'; // For SettingsHeader

class ProfileSettingsView extends StatefulWidget {
  const ProfileSettingsView({super.key});

  @override
  State<ProfileSettingsView> createState() => _ProfileSettingsViewState();
}

class _ProfileSettingsViewState extends State<ProfileSettingsView> {
  final _fNameCtrl = TextEditingController(text: 'CF');
  final _lNameCtrl = TextEditingController(text: 'Admin');
  final _emailCtrl = TextEditingController(text: 'admin@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.kBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SettingsHeader(
            icon: Icons.badge_outlined,
            iconBgColor: AppColors.kSuccess,
            title: 'Profile Information',
            subtitle: 'Personalize your admin identity and contact channels.',
          ),
          const SizedBox(height: 32),
          
          _buildTextField('FIRST NAME', _fNameCtrl),
          const SizedBox(height: 24),
          _buildTextField('LAST NAME', _lNameCtrl),
          const SizedBox(height: 24),
          _buildTextField('PRIMARY EMAIL ADDRESS', _emailCtrl),
          const SizedBox(height: 32),
          
          ElevatedButton(
            onPressed: () => ToastService.show(title: 'Profile Saved', message: 'Your profile has been updated.', type: ToastType.success),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kSuccess,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save Profile Changes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.kTextDark),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.kBackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}