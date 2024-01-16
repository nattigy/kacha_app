import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/app_colors.dart';

class SingleStat extends StatelessWidget {
  const SingleStat({
    Key? key,
    required this.value,
    required this.label,
    required this.textColor,
    required this.backGroundColor,
  }) : super(key: key);

  final String value;
  final String label;
  final Color textColor;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          value.text
              .color(textColor)
              .fontFamily('Arima Madurai')
              .xl3
              .extraBold
              .make(),
          FittedBox(
            child: label.text.color(AppColor.greyTextColor).xs.bold.make(),
          )
        ],
      ),
    );
  }
}
