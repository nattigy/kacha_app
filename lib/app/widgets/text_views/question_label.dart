import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionLabel extends StatelessWidget {
  const QuestionLabel({Key? key, this.text, this.icon}) : super(key: key);

  final String? text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
        ).py2(),
        const SizedBox(width: 5),
        text!.text.lg.medium.make().expand(),
      ],
    );
  }
}
