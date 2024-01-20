import 'package:flutter/material.dart';
import 'package:payment_repository/payment_repository.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.to,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${transaction.type == TransactionType.credit ? "+" : "-"} ${transaction.amount} Birr",
                style: TextStyle(
                  fontSize: 18,
                  color: transaction.type == TransactionType.credit ? Colors.green : Colors.red,
                ),
              ),
              Text(
                transaction.description,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text("Date: "),
                  Text(transaction.createdAt.toIso8601String().split("T")[0]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
