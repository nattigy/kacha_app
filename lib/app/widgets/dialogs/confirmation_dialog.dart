import 'package:flutter/material.dart';

import '../cards/margin_container.dart';
import '../cards/shadow_card.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.message,
    required this.confirm,
  }) : super(key: key);

  final String message;
  final void Function() confirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MarginContainer(
        child: ShadowCard(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Text(message),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "No",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(onPressed: confirm, child: const Text("Yes")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
