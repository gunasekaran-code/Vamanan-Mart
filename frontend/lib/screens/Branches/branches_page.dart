import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../theme/confirm_dialog.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import '../../widgets/stat_card.dart'; // From your provided widgets
import 'branch_model.dart';
import 'branch_form_page.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesScreen> {
  // Dummy data matching your screenshots
  final List<Branch> _branches = [
    const Branch(
      id: '1',
      name: 'Main Office',
      address: 'Near Matha Kovil, Thoothukudi',
      gstin: '33ABCDEF12Z53',
      phone: '9876543210',
      email: 'anantha130404@gmail.com',
      identifier: 'CODE-NONE',
      isActive: true,
    ),
    const Branch(
      id: '2',
      name: "Teacher's Colony Branch",
      address: '2G/1, Rajiv Nagar, Main Road, Thoothukudi',
      gstin: '33XYZDEF12Z59',
      phone: '9876543211',
      email: 'teachers@gmail.com',
      identifier: 'CODE-NONE',
      isActive: true,
    ),
  ];

  Future<void> _handleDelete(Branch branch) async {
    final confirmed = await AppConfirmDialog.show(
      context: context,
      title: 'Delete Branch',
      message: 'Are you sure you want to delete ${branch.name}? This action cannot be undone.',
      confirmLabel: 'Delete',
      confirmButtonColor: AppColors.kDanger,
    );

    if (confirmed == true) {
      setState(() {
        _branches.removeWhere((b) => b.id == branch.id);
      });
      
      ToastService.show(
        title: 'Branch Deleted',
        message: '${branch.name} has been successfully removed.',
        type: ToastType.success,
      );
    }
  }

  Future<void> _openBranchForm([Branch? branch]) async {
    // Navigating to the full-page form as seen in the screenshots
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BranchFormPage(branch: branch),
      ),
    );

    if (result == true) {
      final isNew = branch == null;
      ToastService.show(
        title: isNew ? 'Branch Created' : 'Branch Updated',
        message: isNew 
            ? 'New branch has been successfully registered.'
            : 'Branch details have been successfully updated.',
        type: ToastType.success,
      );
      // TODO: Refresh your list from API here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AppPage(
      title: 'Regional Footprint',
      subtitle: 'Centralized management of all physical branch locations and regional hubs.',
      children: [
        // Top Action Button
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () => _openBranchForm(),
                icon: const Icon(Icons.add_circle, size: 20),
                label: const Text(
                  'Register New Branch',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSuccess,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),

        // Responsive Stats Cards
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'TOTAL NETWORK',
                value: '2 Offices',
                icon: Icons.domain,
                color: AppColors.kSuccess,
              ),
            ),
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'REGIONAL REACH',
                value: 'Multi-City Presence',
                icon: Icons.location_on,
                color: AppColors.kInfo,
              ),
            ),
            SizedBox(
              width: isMobile ? double.infinity : 250,
              child: const StatCard(
                label: 'SYSTEM STATUS',
                value: '100% Operational',
                icon: Icons.verified_user_outlined,
                color: AppColors.kDanger,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Search and Data Container
        Container(
          decoration: BoxDecoration(
            color: AppColors.kSurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name, code or city...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.kTextMuted),
                    filled: true,
                    fillColor: AppColors.kBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.kBorder),
              
              // Conditional Rendering: Mobile List vs Desktop Table
              isMobile ? _buildMobileList() : _buildDesktopTable(),
            ],
          ),
        ),
      ],
    );
  }

// --- MOBILE RESPONSIVE LIST ---
  Widget _buildMobileList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _branches.length,
      separatorBuilder: (context, index) => const Divider(height: 1, color: AppColors.kBorder),
      itemBuilder: (context, index) {
        final branch = _branches[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP ROW: Avatar, Title, Address, and Status Chip
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.kInfo.withOpacity(0.12),
                    child: Text(
                      branch.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(color: AppColors.kInfo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(branch.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.kPrimary),
                            const SizedBox(width: 4),
                            Expanded(child: Text(branch.address, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Moved Status Chip here
                  _buildStatusChip(branch.isActive),
                ],
              ),
              const SizedBox(height: 16),
              
              // BOTTOM ROW: Identifier Chip and Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIdentifierChip(branch.identifier),
                  
                  // Moved Action Buttons here
                  Row(
                    children: [
                      _ActionButton(
                        icon: Icons.edit_note,
                        color: Colors.blue,
                        backgroundColor: Colors.blue.shade50,
                        onPressed: () => _openBranchForm(branch),
                      ),
                      const SizedBox(width: 8),
                      _ActionButton(
                        icon: Icons.delete_outline,
                        color: AppColors.kDanger,
                        backgroundColor: AppColors.kDanger.withOpacity(0.08),
                        onPressed: () => _handleDelete(branch),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  
  // --- DESKTOP/TABLET DATA TABLE ---
  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 32,
        headingRowHeight: 56,
        dataRowMinHeight: 72,
        dataRowMaxHeight: 72,
        headingTextStyle: const TextStyle(color: AppColors.kTextMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.1),
        columns: const [
          DataColumn(label: Text('BRANCH IDENTITY')),
          DataColumn(label: Text('IDENTIFIER')),
          DataColumn(label: Text('OPERATIONAL STATUS')),
          DataColumn(label: Text('ACTION NEXUS')),
        ],
        rows: _branches.map((branch) {
          return DataRow(
            cells: [
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.kInfo.withOpacity(0.12),
                      child: Text(
                        branch.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(color: AppColors.kInfo, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(branch.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.kPrimary),
                            const SizedBox(width: 4),
                            Text(branch.address, style: const TextStyle(color: AppColors.kTextMuted, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              DataCell(_buildIdentifierChip(branch.identifier)),
              DataCell(_buildStatusChip(branch.isActive)),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ActionButton(
                      icon: Icons.edit_outlined,
                      color: Colors.blue,
                      backgroundColor: Colors.transparent,
                      onPressed: () => _openBranchForm(branch),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: Icons.delete_outline,
                      color: AppColors.kDanger,
                      backgroundColor: Colors.transparent,
                      onPressed: () => _handleDelete(branch),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIdentifierChip(String id) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.kBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.kBorder),
      ),
      child: Text(id, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.kTextDark)),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.kSuccess.withOpacity(0.12) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.kSuccess.withOpacity(0.3) : Colors.grey.shade400),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isActive ? Icons.check_circle : Icons.cancel, size: 14, color: isActive ? AppColors.kSuccess : Colors.grey),
          const SizedBox(width: 6),
          Text(
            isActive ? 'ACTIVE' : 'INACTIVE',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isActive ? AppColors.kPrimaryDark : Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

// Button Widget mapping from your MembersScreen
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}