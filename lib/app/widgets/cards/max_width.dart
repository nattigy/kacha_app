import 'package:flutter/material.dart';

class MaxWidth extends StatelessWidget {
  const MaxWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: child,
      ),
    );
  }
}
