import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/app_colors.dart';

class IconText extends StatelessWidget {
  const IconText({Key? key, this.text, this.icon, this.color})
      : super(key: key);

  final String? text;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? AppColor.greyTextColor,
        ).py2(),
        const SizedBox(width: 5),
        text!.text.color(color ?? AppColor.greyTextColor).make(),
      ],
    );
  }
}
