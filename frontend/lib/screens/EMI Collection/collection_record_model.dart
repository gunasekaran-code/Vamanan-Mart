class CollectionRecord {
  final String receiptNo;
  final String loanNo;
  final String customerName;
  final String emiInstalment;
  final String date;
  final double amount;
  final String mode;
  final String staff;

  const CollectionRecord({
    required this.receiptNo,
    required this.loanNo,
    required this.customerName,
    required this.emiInstalment,
    required this.date,
    required this.amount,
    required this.mode,
    required this.staff,
  });
}