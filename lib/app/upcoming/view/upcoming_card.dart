import 'package:flutter/material.dart';
import 'package:payment_repository/payment_repository.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key, required this.upcomingPayment});

  final UpcomingPayment upcomingPayment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    upcomingPayment.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${upcomingPayment.amount} Birr",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text("due date: "),
                      Text(upcomingPayment.dueDate.toIso8601String().split("T")[0]),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.yellowAccent.shade100),
                ),
                onPressed: () {},
                child: Text("Pay now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
