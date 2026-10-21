import 'package:flutter/material.dart';
import 'audit_model.dart';
import '../../widgets/app_toast.dart';
import '../../theme/confirm_dialog.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({Key? key}) : super(key: key);

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  List<AuditModel> allLogs = [];
  bool showAll = false;
  final int initialDisplayCount = 6;

  @override
  void initState() {
    super.initState();
    allLogs = getDummyAuditLogs();
  }

  @override
  Widget build(BuildContext context) {
    // Determine how many logs to show
    final displayedLogs = showAll 
        ? allLogs 
        : allLogs.take(initialDisplayCount).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildActionRow(context),
            const SizedBox(height: 24),
            _buildAuditTable(displayedLogs),
            const SizedBox(height: 16),
            if (allLogs.length > initialDisplayCount) _buildShowMoreButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Audit Trail',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.sync, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              'Live synchronization monitoring active',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Filter logs...',
              prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // INTEGRATION: Download CSV Toast
            ToastService.show(
              title: 'Download Initiated',
              message: 'Generating CSV file for the audit trail...',
              type: ToastType.info,
            );
          },
          icon: const Icon(Icons.download, size: 18, color: Colors.blue),
          label: const Text('Download CSV', style: TextStyle(color: Colors.blue)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            side: const BorderSide(color: Colors.blue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.blue.shade50,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () async {
            // INTEGRATION: Confirmation Dialog for Purging History
            final bool? confirm = await AppConfirmDialog.show(
              context: context,
              title: 'Purge History',
              message: 'Are you sure you want to permanently delete all audit logs? This action cannot be undone.',
              confirmLabel: 'Purge',
            );

            if (confirm == true) {
              setState(() {
                allLogs.clear();
              });
              
              // INTEGRATION: Success Toast after purging
              ToastService.show(
                title: 'History Purged',
                message: 'All audit logs have been successfully deleted.',
                type: ToastType.success,
              );
            }
          },
          icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
          label: const Text('Purge History', style: TextStyle(color: Colors.red)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.red.shade50,
          ),
        ),
      ],
    );
  }

  Widget _buildAuditTable(List<AuditModel> logs) {
    if (logs.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: const Center(
          child: Text('No audit logs available.', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontSize: 12,
            letterSpacing: 1.1,
          ),
          dataRowMaxHeight: 70,
          dataRowMinHeight: 60,
          horizontalMargin: 24,
          columns: const [
            DataColumn(label: Text('EVENT TIMELINE')),
            DataColumn(label: Text('ADMINISTRATOR')),
            DataColumn(label: Text('ACTION')),
            DataColumn(label: Text('SYSTEM MODULE')),
            DataColumn(label: Text('SECURITY CONTEXT')),
            DataColumn(label: Text('MANAGE')),
          ],
          rows: logs.map((log) => _buildDataRow(log)).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow(AuditModel log) {
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(log.date, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(log.time, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.green.shade100,
                child: Text(
                  log.adminName[0].toUpperCase(),
                  style: TextStyle(color: Colors.green.shade800, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Text(log.adminName, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        DataCell(_buildBadge(
          text: log.action,
          textColor: log.action == 'LOGIN' ? Colors.green.shade700 : Colors.grey.shade700,
          bgColor: log.action == 'LOGIN' ? Colors.green.shade50 : Colors.grey.shade200,
        )),
        DataCell(_buildBadge(
          text: log.systemModule,
          textColor: Colors.indigo.shade700,
          bgColor: Colors.indigo.shade50,
        )),
        DataCell(
          SizedBox(
            width: 250,
            child: Text(
              log.securityContext,
              style: TextStyle(color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildManageIcon(
                icon: Icons.info_outline, 
                color: Colors.blue,
                onTap: () => ToastService.show(title: 'Log Details', message: 'Viewing details for log ${log.id}', type: ToastType.info),
              ),
              const SizedBox(width: 8),
              _buildManageIcon(
                icon: Icons.shield_outlined, 
                color: Colors.green,
                onTap: () => ToastService.show(title: 'Security Verified', message: 'No security threats detected.', type: ToastType.success),
              ),
              const SizedBox(width: 8),
              _buildManageIcon(
                icon: Icons.show_chart, 
                color: Colors.orange,
                onTap: () => ToastService.show(title: 'Analytics Triggered', message: 'Generating report for this action.', type: ToastType.warning),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadge({required String text, required Color textColor, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  // Updated to include onTap and an InkWell for interaction
  Widget _buildManageIcon({required IconData icon, required Color color, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }

  Widget _buildShowMoreButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          setState(() {
            showAll = !showAll;
          });
        },
        icon: Icon(showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
        label: Text(showAll ? 'Show Less' : 'Show All (${allLogs.length})'),
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue.shade700,
        ),
      ),
    );
  }
}