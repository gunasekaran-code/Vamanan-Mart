class Settlement {
  final String id;
  final String memberName;
  final String memberPhone;
  final String chitGroup;
  final double totalPaid;
  final double totalReceived;
  final double dividend;
  final double penalty;
  final String status; // 'Open', 'Finalized'
  final String commencedDate;

  const Settlement({
    required this.id,
    required this.memberName,
    required this.memberPhone,
    required this.chitGroup,
    required this.totalPaid,
    required this.totalReceived,
    required this.dividend,
    required this.penalty,
    required this.status,
    required this.commencedDate,
  });

  /// Audit Formula: (Total Received + Dividend) - (Total Paid + Penalty)
  double get netAmount => (totalReceived + dividend) - (totalPaid + penalty);
}