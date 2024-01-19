class UpcomingPayment {
  UpcomingPayment({
    required this.title,
    required this.amount,
    required this.dueDate,
  });

  final String title;
  final double amount;
  final DateTime dueDate;

  factory UpcomingPayment.fromJson(Map<String, dynamic> data) {
    return UpcomingPayment(
      title: data['title'],
      amount: data['amount'],
      dueDate: DateTime.parse(data['dueDate']),
    );
  }
}
