class OverdueRecord {
  final String initial;
  final String customerName;
  final String phone;
  final String loanNo;
  final String branch;
  final String instalment;
  final String dueDate;
  final double principal;
  final double penalty;
  final String aging;

  const OverdueRecord({
    required this.initial,
    required this.customerName,
    required this.phone,
    required this.loanNo,
    required this.branch,
    required this.instalment,
    required this.dueDate,
    required this.principal,
    required this.penalty,
    required this.aging,
  });
}

// Sample Data shared across screens
final List<OverdueRecord> sampleOverdueRecords = [
  const OverdueRecord(
    initial: 'V',
    customerName: 'Varshini',
    phone: '7685940321',
    loanNo: 'LN-2026-0002',
    branch: 'Teacher\'s Colony Branch',
    instalment: 'EMI #2',
    dueDate: '10 Jun 2026',
    principal: 2889,
    penalty: 54,
    aging: '2 months, 1 week late',
  ),
  const OverdueRecord(
    initial: 'R',
    customerName: 'Roki',
    phone: '9786204074',
    loanNo: 'LN-2026-0001',
    branch: 'Main Office',
    instalment: 'EMI #2',
    dueDate: '15 Jun 2026',
    principal: 2044,
    penalty: 20,
    aging: '2 months, 1 week late',
  ),
];