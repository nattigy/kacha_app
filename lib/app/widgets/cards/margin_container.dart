import 'package:flutter/material.dart';

class MarginContainer extends StatelessWidget {
  const MarginContainer({
    Key? key,
    required this.child,
    this.horizontalMargin = 20,
    this.verticalMargin = 5,
  }) : super(key: key);

  final Widget child;
  final double horizontalMargin;
  final double verticalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      child: child,
    );
  }
}
