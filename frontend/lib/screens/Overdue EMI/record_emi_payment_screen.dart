import 'package:flutter/material.dart';
import 'overdue_record_model.dart';

class RecordEmiPaymentScreen extends StatefulWidget {
  final OverdueRecord record;
  const RecordEmiPaymentScreen({super.key, required this.record});

  @override
  State<RecordEmiPaymentScreen> createState() => _RecordEmiPaymentScreenState();
}

class _RecordEmiPaymentScreenState extends State<RecordEmiPaymentScreen> {
  bool _waivePenalty = false;

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Payment'),
        content: Text('Are you sure you want to record the payment of ₹${widget.record.principal + (_waivePenalty ? 0 : widget.record.penalty)} for ${widget.record.customerName}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF198754)),
            onPressed: () {
              Navigator.pop(ctx);
              _showToastAndPop();
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showToastAndPop() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Payment recorded successfully!'),
          ],
        ),
        backgroundColor: const Color(0xFF198754),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    Navigator.pop(context); // Go back to queue/report
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black87), onPressed: () => Navigator.pop(context)),
        title: Row(
          children: [
            Icon(Icons.payments_outlined, color: Colors.indigo.shade600),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Record EMI Payment', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('${widget.record.loanNo} — ${widget.record.customerName}', style: const TextStyle(color: Colors.black54, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('MONTHLY EMI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1)),
                  Text('₹${widget.record.principal.toInt()}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo.shade600)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildPill('₹49167', 'Outstanding', Colors.green.shade50, Colors.green.shade700),
                      const SizedBox(width: 12),
                      _buildPill('17', 'Pending EMIs', Colors.grey.shade100, Colors.black87),
                      const SizedBox(width: 12),
                      _buildPill('5%', 'Complete', Colors.grey.shade100, Colors.black87),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('REPAYMENT PROGRESS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: 0.05, backgroundColor: Colors.grey.shade200, color: Colors.indigo.shade500, minHeight: 6, borderRadius: BorderRadius.circular(4)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Payment Entry', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 24),
                  
                  _buildInputLabel('Select EMI Instalment *'),
                  DropdownButtonFormField<String>(
                    value: '${widget.record.loanNo} — ${widget.record.instalment}',
                    items: ['${widget.record.loanNo} — ${widget.record.instalment}'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (_) {},
                    decoration: _inputDecoration(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 16),
                    child: Text('Only pending/overdue EMIs are shown.', style: TextStyle(fontSize: 11, color: Colors.black54)),
                  ),

                  _buildInputLabel('Amount Paid (₹) *'),
                  TextFormField(
                    initialValue: (widget.record.principal + (_waivePenalty ? 0 : widget.record.penalty)).toStringAsFixed(2),
                    decoration: _inputDecoration(),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),

                  _buildInputLabel('Payment Date *'),
                  TextFormField(
                    initialValue: '21/08/2026',
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 16),

                  _buildInputLabel('Payment Mode *'),
                  DropdownButtonFormField<String>(
                    value: 'Cash',
                    items: ['Cash', 'UPI', 'Bank Transfer'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (_) {},
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 16),

                  _buildInputLabel('Transaction Reference'),
                  TextFormField(
                    decoration: _inputDecoration().copyWith(hintText: 'UPI / UTR / Cheque No.'),
                  ),
                  const SizedBox(height: 16),

                  _buildInputLabel('Penalty Paid (₹)'),
                  TextFormField(
                    initialValue: _waivePenalty ? '0.00' : widget.record.penalty.toStringAsFixed(2),
                    decoration: _inputDecoration(),
                  ),
                  
                  CheckboxListTile(
                    title: const Text('Waive Penalty', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    value: _waivePenalty,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.indigo.shade600,
                    onChanged: (val) {
                      setState(() {
                        _waivePenalty = val ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 8),

                  _buildInputLabel('Notes'),
                  TextFormField(
                    maxLines: 3,
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 24),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _showConfirmation, // Triggers Confirmation & Toast
                          icon: const Icon(Icons.check, size: 18, color: Colors.white),
                          label: const Text('Record Payment & Get Receipt', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF198754), // Success Green
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.black87)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.indigo.shade400)),
    );
  }

  Widget _buildPill(String title, String subtitle, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: textColor)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.black54), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}