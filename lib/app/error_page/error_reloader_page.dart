import 'package:flutter/material.dart';

class ErrorReLoader extends StatelessWidget {
  const ErrorReLoader({super.key, required this.reLoad});

  final Function reLoad;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Something went wrong! Please"),
          TextButton(
            onPressed: () => reLoad(),
            child: const Row(
              children: [
                Text(
                  "Reload",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                Icon(Icons.refresh)
              ],
            ),
          )
        ],
      ),
    );
  }
}
