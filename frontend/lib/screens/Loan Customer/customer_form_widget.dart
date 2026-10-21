import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'loan_customer_model.dart';

class CustomerFormWidget extends StatefulWidget {
  final LoanCustomer? initialData;
  final Function(LoanCustomer) onSubmit;
  final VoidCallback onCancel;
  final String submitLabel;

  const CustomerFormWidget({
    super.key,
    this.initialData,
    required this.onSubmit,
    required this.onCancel,
    required this.submitLabel,
  });

  @override
  State<CustomerFormWidget> createState() => _CustomerFormWidgetState();
}

class _CustomerFormWidgetState extends State<CustomerFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _dobCtrl;
  late TextEditingController _genderCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _altPhoneCtrl;
  late TextEditingController _emailCtrl;
  
  late TextEditingController _addr1Ctrl;
  late TextEditingController _addr2Ctrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _stateCtrl;
  late TextEditingController _pinCtrl;
  
  late TextEditingController _branchCtrl;
  late TextEditingController _agentCtrl;
  
  late TextEditingController _idTypeCtrl;
  late TextEditingController _idNumCtrl;

  String _idProofFileName = 'no file selected';
  String _photoFileName = 'no file selected';

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _nameCtrl = TextEditingController(text: d?.name ?? '');
    _dobCtrl = TextEditingController(text: d?.dob ?? '');
    _genderCtrl = TextEditingController(text: d?.gender ?? '');
    _phoneCtrl = TextEditingController(text: d?.phone ?? '');
    _altPhoneCtrl = TextEditingController(text: '');
    _emailCtrl = TextEditingController(text: d?.email ?? '');
    
    _addr1Ctrl = TextEditingController(text: d?.addressLine1 ?? '');
    _addr2Ctrl = TextEditingController(text: d?.addressLine2 ?? '');
    _cityCtrl = TextEditingController(text: d?.city ?? '');
    _stateCtrl = TextEditingController(text: d?.state ?? '');
    _pinCtrl = TextEditingController(text: d?.pincode ?? '');
    
    _branchCtrl = TextEditingController(text: d?.branch ?? '');
    _agentCtrl = TextEditingController(text: '');
    
    _idTypeCtrl = TextEditingController(text: d?.idType ?? '');
    _idNumCtrl = TextEditingController(text: d?.idNumber ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _dobCtrl.dispose(); _genderCtrl.dispose();
    _phoneCtrl.dispose(); _altPhoneCtrl.dispose(); _emailCtrl.dispose();
    _addr1Ctrl.dispose(); _addr2Ctrl.dispose(); _cityCtrl.dispose();
    _stateCtrl.dispose(); _pinCtrl.dispose(); _branchCtrl.dispose();
    _agentCtrl.dispose(); _idTypeCtrl.dispose(); _idNumCtrl.dispose();
    super.dispose();
  }

  void _showUploadDialog(String title, Function(String) onUploaded) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upload $title'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onUploaded('uploaded_file_${DateTime.now().millisecondsSinceEpoch}.jpg');
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.kSuccess),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDec(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.kTextMuted, fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.kBorder),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.indigo.shade400),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600),
          children: isRequired
              ? [const TextSpan(text: ' *', style: TextStyle(color: AppColors.kDanger))]
              : [],
        ),
      ),
    );
  }

  Widget _buildFileUpload(String label, String fileName, Function(String) onUpdate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(label),
          Row(
            children: [
              OutlinedButton(
                onPressed: () => _showUploadDialog(label, onUpdate),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: const BorderSide(color: AppColors.kBorder),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('Choose File'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  fileName,
                  style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedData = LoanCustomer(
        id: widget.initialData?.id ?? 'NEW-${DateTime.now().millisecondsSinceEpoch}',
        name: _nameCtrl.text,
        phone: _phoneCtrl.text,
        email: _emailCtrl.text,
        memberSince: widget.initialData?.memberSince ?? 'Just now',
        branch: _branchCtrl.text,
        activeLoans: widget.initialData?.activeLoans ?? 0,
        status: widget.initialData?.status ?? 'ACTIVE',
        dob: _dobCtrl.text,
        gender: _genderCtrl.text,
        addressLine1: _addr1Ctrl.text,
        addressLine2: _addr2Ctrl.text,
        city: _cityCtrl.text,
        state: _stateCtrl.text,
        pincode: _pinCtrl.text,
        idType: _idTypeCtrl.text,
        idNumber: _idNumCtrl.text,
      );
      widget.onSubmit(updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PERSONAL INFORMATION
          _buildSectionHeader(Icons.person_outline, 'PERSONAL INFORMATION'),
          _buildLabel('Full Name', isRequired: true),
          TextFormField(controller: _nameCtrl, decoration: _inputDec('Full Name')),
          const SizedBox(height: 16),
          _buildLabel('Date of Birth'),
          TextFormField(controller: _dobCtrl, decoration: _inputDec('DD/MM/YYYY')),
          const SizedBox(height: 16),
          _buildLabel('Gender'),
          TextFormField(controller: _genderCtrl, decoration: _inputDec('---------')),
          const SizedBox(height: 16),
          _buildLabel('Phone Number', isRequired: true),
          TextFormField(controller: _phoneCtrl, decoration: _inputDec('10-digit mobile')),
          const SizedBox(height: 16),
          _buildLabel('Alternative Phone'),
          TextFormField(controller: _altPhoneCtrl, decoration: _inputDec('')),
          const SizedBox(height: 16),
          _buildLabel('Email Address'),
          TextFormField(controller: _emailCtrl, decoration: _inputDec('')),

          // ADDRESS DETAILS
          _buildSectionHeader(Icons.map_outlined, 'ADDRESS DETAILS'),
          _buildLabel('Address Line 1', isRequired: true),
          TextFormField(controller: _addr1Ctrl, decoration: _inputDec('Door No, Street')),
          const SizedBox(height: 16),
          _buildLabel('Address Line 2'),
          TextFormField(controller: _addr2Ctrl, decoration: _inputDec('Landmark (optional)')),
          const SizedBox(height: 16),
          _buildLabel('City/Town', isRequired: true),
          TextFormField(controller: _cityCtrl, decoration: _inputDec('')),
          const SizedBox(height: 16),
          _buildLabel('State'),
          TextFormField(controller: _stateCtrl, decoration: _inputDec('Tamil Nadu')),
          const SizedBox(height: 16),
          _buildLabel('Pincode'),
          TextFormField(controller: _pinCtrl, decoration: _inputDec('')),

          // BRANCH & ASSIGNMENT
          _buildSectionHeader(Icons.account_tree_outlined, 'BRANCH & ASSIGNMENT'),
          _buildLabel('Servicing Branch', isRequired: true),
          TextFormField(controller: _branchCtrl, decoration: _inputDec('---------')),
          const SizedBox(height: 16),
          _buildLabel('Assigned Agent'),
          TextFormField(controller: _agentCtrl, decoration: _inputDec('---------')),

          // KYC DOCUMENTATION
          _buildSectionHeader(Icons.verified_user_outlined, 'KYC DOCUMENTATION'),
          _buildLabel('ID Proof Type'),
          TextFormField(controller: _idTypeCtrl, decoration: _inputDec('e.g. Aadhaar')),
          const SizedBox(height: 16),
          _buildLabel('ID Proof Number'),
          TextFormField(controller: _idNumCtrl, decoration: _inputDec('')),
          const SizedBox(height: 16),
          
          _buildFileUpload('Upload ID Proof', _idProofFileName, (f) => setState(() => _idProofFileName = f)),
          _buildFileUpload('Customer Photo', _photoFileName, (f) => setState(() => _photoFileName = f)),

          const SizedBox(height: 32),
          Row(
            children: [
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSuccess,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Text(widget.submitLabel),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: widget.onCancel,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  side: BorderSide.none,
                ),
                child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}