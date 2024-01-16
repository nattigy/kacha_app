import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    Key? key,
    this.onTap,
    required this.icon,
    this.color,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color? color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: color ?? AppColor.primaryColor),
        ),
        child: Icon(
          icon,
          color: color ?? AppColor.primaryColor,
          size: 14,
        ),
      ),
    );
  }
}
