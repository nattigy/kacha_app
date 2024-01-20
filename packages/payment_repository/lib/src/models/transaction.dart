class Transaction {
  Transaction({
    required this.amount,
    required this.type,
    required this.to,
    required this.description,
    required this.createdAt,
  });

  final double amount;
  final TransactionType type;
  final String to;
  final String description;
  final DateTime createdAt;

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
