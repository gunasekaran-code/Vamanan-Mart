// lib/screens/branches/branch_form_page.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'branch_model.dart';

class BranchFormPage extends StatefulWidget {
  final Branch? branch;

  const BranchFormPage({super.key, this.branch});

  @override
  State<BranchFormPage> createState() => _BranchFormPageState();
}

class _BranchFormPageState extends State<BranchFormPage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _gstinCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _emailCtrl;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    final b = widget.branch;
    _nameCtrl = TextEditingController(text: b?.name ?? '');
    _gstinCtrl = TextEditingController(text: b?.gstin ?? '');
    _addressCtrl = TextEditingController(text: b?.address ?? '');
    _phoneCtrl = TextEditingController(text: b?.phone ?? '');
    _emailCtrl = TextEditingController(text: b?.email ?? '');
    if (b != null) _isActive = b.isActive;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _gstinCtrl.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.branch != null;
    
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        backgroundColor: AppColors.kBackground,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Text(
          isEditing ? 'Edit Branch' : 'Add Branch',
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back to Branches', style: TextStyle(fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.kTextDark,
                side: const BorderSide(color: AppColors.kBorder),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600), // Max width for tablet/desktop
            decoration: BoxDecoration(
              color: AppColors.kSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.kBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Distinctive Blue Header from screenshot
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D4ED8), // Deep Blue color
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.business, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Branch Information', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('Fill in the details to manage this branch', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                
                // Form Fields Body
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabeledField('NAME', Icons.local_offer_outlined, 'e.g. Chennai Office', _nameCtrl),
                      const SizedBox(height: 24),
                      _buildLabeledField('GSTIN NUMBER', Icons.domain_verification_outlined, '15-digit GSTIN Number', _gstinCtrl),
                      const SizedBox(height: 24),
                      _buildLabeledField('ADDRESS', Icons.location_on_outlined, '', _addressCtrl, maxLines: 3),
                      const SizedBox(height: 24),
                      _buildLabeledField('PHONE', Icons.phone_outlined, '', _phoneCtrl, keyboardType: TextInputType.phone),
                      const SizedBox(height: 24),
                      _buildLabeledField('EMAIL', Icons.email_outlined, '', _emailCtrl, keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 32),
                      
                      // Active Toggle Switch
                      const Text('IS ACTIVE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.5)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Switch(
                            value: _isActive,
                            activeColor: const Color(0xFF1D4ED8),
                            onChanged: (val) => setState(() => _isActive = val),
                          ),
                          const SizedBox(width: 12),
                          const Text('Grant operational access to this branch', style: TextStyle(color: AppColors.kTextMuted, fontSize: 14)),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      const Divider(color: AppColors.kBorder),
                      const SizedBox(height: 24),
                      
                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.kBorder),
                              foregroundColor: AppColors.kTextDark,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            ),
                            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context, true), // Passing true signals success
                            icon: const Icon(Icons.check_circle_outline, size: 20),
                            label: Text(isEditing ? 'Edit Branch' : 'Add Branch', style: const TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.kSuccess,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            ),
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

  // Custom Field Builder to replicate your screenshot precisely
  Widget _buildLabeledField(
    String label, 
    IconData icon, 
    String hint, 
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.kTextMuted, letterSpacing: 0.8),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            // Replicating the distinctive "Prefix block with vertical border" UI
            prefixIcon: Container(
              width: 50,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: AppColors.kBorder, width: 1.5)),
              ),
              child: Icon(icon, color: AppColors.kTextDark, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}