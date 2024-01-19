import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    Key? key,
    this.borderColor = const Color(0x00FFFFFF),
    this.icon,
    this.iconColor,
    this.backgroundColor,
  }) : super(key: key);

  final Color? iconColor;
  final IconData? icon;
  final Color borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 1.5, color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: Icon(icon, size: 16, color: iconColor),
    );
  }
}
