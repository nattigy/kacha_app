import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/constants.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    this.label,
    this.onPressed,
    this.outlined = false,
    this.height = 50,
    this.backgroundColor,
  }) : super(key: key);

  final String? label;
  final VoidCallback? onPressed;
  final bool? outlined;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: outlined!
              ? BorderSide(width: 1, color: AppColor.primaryColor)
              : BorderSide.none,
        ),
        backgroundColor: outlined!
            ? Colors.transparent
            : backgroundColor ?? AppColor.primaryColor,
        minimumSize: Size.fromHeight(height!),
      ),
      onPressed: onPressed,
      child: outlined!
          ? label!.text.lg.color(AppColor.primaryColor).make()
          : label!.text.lg.white.make(),
    );
  }
}
