import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'settlement_model.dart';

class CreateSettlementScreen extends StatefulWidget {
  const CreateSettlementScreen({super.key});

  @override
  State<CreateSettlementScreen> createState() => _CreateSettlementScreenState();
}

class _CreateSettlementScreenState extends State<CreateSettlementScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedMember = 'Jessica';
  String? _selectedGroup = 'Gold';
  String _selectedStatus = 'Open';

  final _paidController = TextEditingController(text: '3000.00');
  final _receivedController = TextEditingController(text: '0.00');
  final _dividendController = TextEditingController(text: '2500.00');
  final _penaltyController = TextEditingController(text: '1600.00');

  @override
  void dispose() {
    _paidController.dispose();
    _receivedController.dispose();
    _dividendController.dispose();
    _penaltyController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.kTextMuted, fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.kSuccess, width: 2),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newSettlement = Settlement(
        id: 'SET-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        memberName: _selectedMember ?? 'Jessica',
        memberPhone: '9512364870',
        chitGroup: _selectedGroup ?? 'Gold',
        totalPaid: double.tryParse(_paidController.text) ?? 0.0,
        totalReceived: double.tryParse(_receivedController.text) ?? 0.0,
        dividend: double.tryParse(_dividendController.text) ?? 0.0,
        penalty: double.tryParse(_penaltyController.text) ?? 0.0,
        status: _selectedStatus,
        commencedDate: 'April 2026',
      );

      ToastService.show(
        title: 'Settlement Created',
        message: 'The settlement record has been created successfully.',
        type: ToastType.success,
      );

      Navigator.pop(context, newSettlement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Create Settlement',
      subtitle: 'Reconcile total payments against distributions and dividends',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Back'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Hero Card Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.calculate_outlined, color: Colors.blue.shade700),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cycle Settlement Reconciler',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Reconcile total payments against distributions and dividends',
                      style: TextStyle(color: AppColors.kTextMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Form Card
        Card(
          elevation: 0,
          color: AppColors.kSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.kBorder),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedMember,
                    decoration: _inputDecoration('Member'),
                    items: ['Jessica', 'Roki', 'Varshini']
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedMember = v),
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _selectedGroup,
                    decoration: _inputDecoration('Chit group'),
                    items: ['Gold', 'Silver', 'Diamond']
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedGroup = v),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _paidController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Total paid'),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _receivedController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Total received'),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _dividendController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Dividend'),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _penaltyController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Penalty'),
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: _inputDecoration('Status'),
                    items: ['Open', 'Finalized']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedStatus = v!),
                  ),
                  const SizedBox(height: 24),

                  // Info Calculation Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Note: Closing a settlement will permanently lock these financial records. Net Amount calculation:',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '(Total Received + Dividend) - (Total Paid + Penalty)',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Action Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submit,
                      icon: const Icon(Icons.verified_user_outlined, size: 18),
                      label: const Text(
                        'Finalize Settlement',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kSuccess,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Discard Changes',
                          style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}