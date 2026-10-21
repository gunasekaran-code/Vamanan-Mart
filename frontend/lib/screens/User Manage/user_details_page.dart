// lib/screens/users/user_details_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/confirm_dialog.dart';
import '../../widgets/app_toast.dart';
import 'user_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  void _disableAccount(BuildContext context) async {
    final confirmed = await AppConfirmDialog.show(
      context: context,
      title: 'Disable Account',
      message: 'Are you sure you want to disable ${user.fullName}? They will lose access to the system immediately.',
      confirmLabel: 'Disable Account',
    );

    if (confirmed == true) {
      ToastService.show(title: 'Account Disabled', message: '${user.username} has been disabled.', type: ToastType.warning);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kBackground,
        toolbarHeight: 90,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer Details', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26)),
            Text('Viewing profile for @${user.username}', style: const TextStyle(fontSize: 14, color: AppColors.kTextMuted, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back to Directory', style: TextStyle(fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.kTextDark, side: const BorderSide(color: AppColors.kBorder)),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Profile Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.kBorder)),
                child: Column(
                  children: [
                    CircleAvatar(radius: 40, backgroundColor: AppColors.kPrimary, child: Text(user.firstName[0].toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 16),
                    Text(user.fullName.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.kBorder), borderRadius: BorderRadius.circular(20), color: AppColors.kBackground),
                      child: Text(user.role == 'CUSTOMER' ? 'Customer' : user.role, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 32),
                    
                    _buildDetailRow('EMAIL ADDRESS', user.email != '-' ? user.email : 'Not Provided'),
                    const SizedBox(height: 20),
                    _buildDetailRow('ACCOUNT STATUS', user.status, isBadge: true),
                    const SizedBox(height: 20),
                    _buildDetailRow('DATE JOINED', user.dateJoined),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Security Card
              const Text('Security & Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.kBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.kBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.kBorder)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('2FA STATUS', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(user.is2FAEnabled ? Icons.shield : Icons.gpp_bad_outlined, size: 20, color: AppColors.kTextDark),
                              const SizedBox(width: 8),
                              Text(user.is2FAEnabled ? 'Active' : 'Inactive', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppColors.kBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.kBorder)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('NOTIFICATION LOGIC', style: TextStyle(color: AppColors.kTextMuted, fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Email Notifications', style: TextStyle(fontSize: 14)),
                              Icon(user.emailNotifications ? Icons.check_circle : Icons.cancel, color: AppColors.kSuccess, size: 18),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Payment Reminders', style: TextStyle(fontSize: 14)),
                              Icon(user.paymentReminders ? Icons.check_circle : Icons.cancel, color: AppColors.kSuccess, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 24),
                    
                    const Text('To modify this user\'s administrative settings, please contact the system administrator.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.kTextMuted, fontSize: 13, height: 1.5)),
                    const SizedBox(height: 20),
                    Center(
                      child: OutlinedButton(
                        onPressed: () => _disableAccount(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.kDanger,
                          side: const BorderSide(color: AppColors.kDanger),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Disable Account', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBadge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
        const SizedBox(height: 6),
        isBadge
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: AppColors.kPrimaryLight, borderRadius: BorderRadius.circular(20)),
                child: Text(value, style: const TextStyle(color: AppColors.kPrimaryDark, fontSize: 12, fontWeight: FontWeight.bold)),
              )
            : Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }
}