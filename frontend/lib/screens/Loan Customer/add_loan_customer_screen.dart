// add_loan_customer_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/app_page.dart';
import '../../widgets/app_toast.dart';
import 'customer_form_widget.dart';
import 'loan_customer_model.dart';

class AddLoanCustomerScreen extends StatelessWidget {
  const AddLoanCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Add Loan Customer',
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
          submitLabel: 'Register Profile',
          onCancel: () => Navigator.pop(context),
          onSubmit: (newCustomer) {
            ToastService.show(
              title: 'Customer Created',
              message: 'Successfully registered new customer profile.',
              type: ToastType.success,
            );
            Navigator.pop(context, newCustomer);
          },
        ),
      ],
    );
  }
}
