import 'package:flutter/material.dart';

class MarginContainerForPhone extends StatelessWidget {
  const MarginContainerForPhone({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 15, 5),
      child: child,
    );
  }
}
