// lib/screens/users/user_directory_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/confirm_dialog.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'user_model.dart';
import 'user_form_page.dart';
import 'user_details_page.dart';

class UserDirectoryPage extends StatefulWidget {
  const UserDirectoryPage({super.key});

  @override
  State<UserDirectoryPage> createState() => _UserDirectoryPageState();
}

class _UserDirectoryPageState extends State<UserDirectoryPage> {
  // Dummy data exactly matching your screenshot
  final List<UserModel> _users = [
    UserModel(id: '1', firstName: 'GUNA', lastName: 'SEKARAN', username: 'Guna_Sekaran', email: 'gunasekaran.code@gmail.com', role: 'CUSTOMER', status: 'Active', dateJoined: 'Aug 10, 2026'),
    UserModel(id: '2', firstName: 'admin2', lastName: '', username: 'admin_2', email: '-', role: 'STAFF', status: 'Active', dateJoined: 'Aug 05, 2026'),
    UserModel(id: '3', firstName: 'GURU', lastName: 'MANOJ', username: 'guru_m', email: 'cloudetail18@gmail.com', role: 'ADMIN', status: 'Active', dateJoined: 'Aug 05, 2026'),
    UserModel(id: '4', firstName: 'jessica', lastName: '', username: 'jessica_user', email: '-', role: 'CUSTOMER', status: 'Active', dateJoined: 'Jul 29, 2026'),
    UserModel(id: '5', firstName: 'veerasamy', lastName: '', username: 'veera_s', email: '-', role: 'CUSTOMER', status: 'Active', dateJoined: 'Jul 28, 2026'),
    UserModel(id: '6', firstName: 'CF', lastName: 'Admin', username: 'cf_admin', email: 'admin@gmail.com', role: 'SUPERADMIN', status: 'Active', dateJoined: 'Apr 08, 2026'),
  ];

  Future<void> _deleteUser(UserModel user) async {
    final confirmed = await AppConfirmDialog.show(
      context: context,
      title: 'Delete User',
      message: 'Are you sure you want to delete ${user.fullName}? This action cannot be undone.',
      confirmLabel: 'Delete User',
    );

    if (confirmed == true) {
      setState(() => _users.removeWhere((u) => u.id == user.id));
      ToastService.show(title: 'User Deleted', message: '${user.fullName} removed from directory.', type: ToastType.success);
    }
  }

  void _toggleLock(UserModel user) {
    ToastService.show(title: 'Status Updated', message: 'User access has been restricted.', type: ToastType.warning);
    // Add logic to change status to Locked
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return AppPage(
      title: 'User Directory',
      subtitle: 'Manage and monitor all administrative and customer accounts in one place',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserFormPage())),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create User', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kTextDark,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: isMobile ? _buildMobileList() : _buildDesktopTable(),
        ),
      ],
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 48,
        headingRowHeight: 56,
        dataRowMinHeight: 76,
        dataRowMaxHeight: 76,
        headingTextStyle: const TextStyle(color: AppColors.kTextMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.0),
        columns: const [
          DataColumn(label: Text('USER INFO')),
          DataColumn(label: Text('CONTACT')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('ACTIONS')),
        ],
        rows: _users.map((user) {
          return DataRow(
            cells: [
              DataCell(_buildUserInfo(user)),
              DataCell(_buildContactInfo(user)),
              DataCell(_buildStatusBadge(user.status)),
              DataCell(_buildActionButtons(user)),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _users.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.kBorder),
      itemBuilder: (context, index) {
        final user = _users[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildUserInfo(user)),
                  _buildStatusBadge(user.status),
                ],
              ),
              const SizedBox(height: 12),
              _buildContactInfo(user),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [_buildActionButtons(user)]),
            ],
          ),
        );
      },
    );
  }

  // --- Row Sub-Widgets ---
  Widget _buildUserInfo(UserModel user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.kPrimaryLight,
          child: Text(user.firstName[0].toUpperCase(), style: const TextStyle(color: AppColors.kPrimaryDark, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(border: Border.all(color: AppColors.kBorder), borderRadius: BorderRadius.circular(4)),
              child: Text(user.role, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.kTextDark)),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(user.email, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.kTextDark)),
        const SizedBox(height: 4),
        Text('Joined ${user.dateJoined}', style: const TextStyle(color: AppColors.kTextMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.kPrimaryLight, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.circle, size: 8, color: AppColors.kPrimaryDark),
          const SizedBox(width: 6),
          Text(status, style: const TextStyle(color: AppColors.kPrimaryDark, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(UserModel user) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionButton(icon: Icons.remove_red_eye_outlined, color: Colors.blue, bgColor: Colors.blue.shade50, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserDetailsPage(user: user)))),
        const SizedBox(width: 8),
        _ActionButton(icon: Icons.edit_outlined, color: Colors.orange.shade700, bgColor: Colors.orange.shade50, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserFormPage(user: user)))),
        if (user.role != 'SUPERADMIN') ...[
          const SizedBox(width: 8),
          _ActionButton(icon: Icons.lock_outline, color: AppColors.kDanger, bgColor: AppColors.kDanger.withOpacity(0.1), onTap: () => _toggleLock(user)),
          const SizedBox(width: 8),
          _ActionButton(icon: Icons.delete_outline, color: AppColors.kDanger, bgColor: AppColors.kDanger.withOpacity(0.1), onTap: () => _deleteUser(user)),
        ]
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.color, required this.bgColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}