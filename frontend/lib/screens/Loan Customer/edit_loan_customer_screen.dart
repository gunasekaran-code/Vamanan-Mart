import 'package:flutter/material.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'customer_form_widget.dart';
import 'loan_customer_model.dart';

class EditLoanCustomerScreen extends StatelessWidget {
  final LoanCustomer customer;

  const EditLoanCustomerScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Edit Customer',
      subtitle: '',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Back to List'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black87,
              side: const BorderSide(color: Colors.black12),
            ),
          ),
        ),
        const SizedBox(height: 24),
        CustomerFormWidget(
          initialData: customer,
          submitLabel: 'Update Profile',
          onCancel: () => Navigator.pop(context),
          onSubmit: (updatedCustomer) {
            ToastService.show(
              title: 'Customer Updated',
              message: 'Changes saved successfully.',
              type: ToastType.success,
            );
            Navigator.pop(context, updatedCustomer);
          },
        ),
      ],
    );
  }
}