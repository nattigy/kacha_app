import 'package:flutter/material.dart';

class MainOutlineButton extends StatelessWidget {
  const MainOutlineButton(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Text(text));
  }
}
