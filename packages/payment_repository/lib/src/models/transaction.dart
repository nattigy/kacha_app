class Transaction {
  Transaction({
    required this.amount,
    required this.type,
    required this.to,
    required this.description,
    required this.createdAt,
     this.isUpcoming = false,
     this.upComingId = "false",
  });

  final double amount;
  final TransactionType type;
  final String to;
  final String description;
  final DateTime createdAt;
  final bool? isUpcoming;
  final String? upComingId;

  factory Transaction.fromJson(Map<String, dynamic> data) {
    return Transaction(
      type: data["type"],
      amount: data["amount"],
      to: data["to"],
      description: data["description"],
      createdAt: data["createdAt"],
    );
  }
}

enum TransactionType { credit, debit }
