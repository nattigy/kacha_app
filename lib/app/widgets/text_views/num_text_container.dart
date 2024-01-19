import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class NumTextContainer extends StatelessWidget {
  const NumTextContainer({
    Key? key,
    this.text,
    this.number,
    this.textColor,
    this.backgroundColor,
  }) : super(key: key);

  final String? text;
  final int? number;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Vx.hexToColor('#FFEDD1'),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: textColor ?? const Color(0xFFED9B06),
          width: 0.7,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          '$number'
              .text
              .align(TextAlign.start)
              .color(textColor ?? const Color(0xFFED9B06))
              .lg
              .bold
              .make(),
          const SizedBox(height: 5),
          FittedBox(
            child: text!.text
                .color(textColor ?? const Color(0xFFED9B06))
                .xs
                .make(),
          )
        ],
      ),
    );
  }
}
