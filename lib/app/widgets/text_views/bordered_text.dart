import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  const BorderedText({
    Key? key,
    required this.text,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: borderColor ?? Colors.transparent),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
      ),
      // child: text.text.xs.color(textColor).make().pSymmetric(v: 2, h: 12),
    );
  }
}
