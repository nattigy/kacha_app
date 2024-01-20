class UpcomingPayment {
  UpcomingPayment({
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.isPaid,
    required this.id,
  });

  final String id;
  final String title;
  final bool isPaid;
  final double amount;
  final DateTime dueDate;

  factory UpcomingPayment.fromJson(Map<String, dynamic> data) {
    return UpcomingPayment(
      id: data['id'],
      title: data['title'],
      isPaid: data['isPaid'],
      amount: data['amount'],
      dueDate: DateTime.parse(data['dueDate']),
    );
  }
}
