// lib/screens/users/user_form_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'user_model.dart';
import '../../widgets/app_toast.dart';

class UserFormPage extends StatefulWidget {
  final UserModel? user; // Null implies Create Mode

  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  late TextEditingController _fNameCtrl, _lNameCtrl, _usernameCtrl, _emailCtrl, _passCtrl, _confirmCtrl;
  String _role = 'Customer';
  bool _obsPassword = true;
  bool _obsConfirm = true;

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    _fNameCtrl = TextEditingController(text: u?.firstName ?? '');
    _lNameCtrl = TextEditingController(text: u?.lastName ?? '');
    _usernameCtrl = TextEditingController(text: u?.username ?? '');
    _emailCtrl = TextEditingController(text: u?.email ?? '');
    _passCtrl = TextEditingController();
    _confirmCtrl = TextEditingController();
    if (u != null) _role = u.role == 'SUPERADMIN' ? 'Super Admin' : (u.role == 'ADMIN' ? 'Admin' : (u.role == 'STAFF' ? 'Staff' : 'Customer'));
  }

  @override
  void dispose() {
    _fNameCtrl.dispose(); _lNameCtrl.dispose(); _usernameCtrl.dispose();
    _emailCtrl.dispose(); _passCtrl.dispose(); _confirmCtrl.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_passCtrl.text != _confirmCtrl.text) {
      ToastService.show(title: 'Error', message: 'Passwords do not match.', type: ToastType.error);
      return;
    }
    ToastService.show(title: 'Success', message: widget.user == null ? 'Account created successfully.' : 'Account updated successfully.', type: ToastType.success);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kBackground,
        toolbarHeight: 80,
        title: Text(isEditing ? 'Edit User' : 'Create User', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 26)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back to Users', style: TextStyle(fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(foregroundColor: AppColors.kTextDark, side: const BorderSide(color: AppColors.kBorder)),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: AppColors.kSurface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.kBorder)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 24, backgroundColor: Colors.blue.shade600, child: const Icon(Icons.person_add, color: Colors.white)),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Create Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            Text('Configure access credentials and administrative roles', style: TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Step 1
                      _buildStepHeader('STEP 1: ACCESS CREDENTIALS'),
                      const SizedBox(height: 16),
                      _buildField('USERNAME', Icons.alternate_email, 'Choose unique username', _usernameCtrl),
                      const SizedBox(height: 20),
                      _buildField('EMAIL ADDRESS', Icons.email_outlined, 'Work email address', _emailCtrl),
                      const SizedBox(height: 32),

                      // Step 2
                      _buildStepHeader('STEP 2: PROFILE DETAILS'),
                      const SizedBox(height: 16),
                      _buildField('FIRST NAME', Icons.person_outline, 'Enter first name', _fNameCtrl),
                      const SizedBox(height: 20),
                      _buildField('LAST NAME', Icons.person_outline, 'Enter last name', _lNameCtrl),
                      const SizedBox(height: 20),
                      
                      // Role Dropdown
                      const Text('SYSTEM ROLE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _role,
                        decoration: _inputDecoration(Icons.shield_outlined),
                        items: ['Customer', 'Staff', 'Admin', 'Super Admin'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                        onChanged: (v) => setState(() => _role = v!),
                      ),
                      
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: AppColors.kPrimaryLight.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: const [
                            Icon(Icons.shield_outlined, color: AppColors.kPrimaryDark, size: 20),
                            SizedBox(width: 12),
                            Expanded(child: Text('Password validation is currently relaxed. You can set any simple password for this account.', style: TextStyle(color: AppColors.kPrimaryDark, fontSize: 13))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      _buildField('PASSWORD', Icons.key, '••••••••', _passCtrl, isPassword: true, obsState: _obsPassword, onToggleObs: () => setState(() => _obsPassword = !_obsPassword)),
                      const SizedBox(height: 20),
                      _buildField('PASSWORD CONFIRMATION', Icons.key, '••••••••', _confirmCtrl, isPassword: true, obsState: _obsConfirm, onToggleObs: () => setState(() => _obsConfirm = !_obsConfirm)),
                      
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 24),

                      // Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(onPressed: () => Navigator.pop(context), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)), child: const Text('Cancel', style: TextStyle(color: AppColors.kTextDark))),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: _saveUser,
                            icon: const Icon(Icons.check_circle_outline, size: 20),
                            label: Text(isEditing ? 'Update Account' : 'Create User Account'),
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kSuccess, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: TextStyle(color: Colors.blue.shade700, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 8),
        const Divider(),
      ],
    );
  }

  Widget _buildField(String label, IconData icon, String hint, TextEditingController ctrl, {bool isPassword = false, bool? obsState, VoidCallback? onToggleObs}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8)),
        const SizedBox(height: 8),
        TextFormField(
          controller: ctrl,
          obscureText: isPassword ? obsState! : false,
          decoration: _inputDecoration(icon).copyWith(
            hintText: hint,
            suffixIcon: isPassword ? IconButton(icon: Icon(obsState! ? Icons.visibility_off : Icons.visibility, color: Colors.black38), onPressed: onToggleObs) : null,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(IconData prefix) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.kBackground,
      hintStyle: const TextStyle(color: Colors.black38),
      prefixIcon: Container(
        width: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 12),
        decoration: const BoxDecoration(border: Border(right: BorderSide(color: AppColors.kBorder))),
        child: Icon(prefix, color: Colors.blue.shade700, size: 18),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.kBorder)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.kBorder)),
    );
  }
}