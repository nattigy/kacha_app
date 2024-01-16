import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({
    Key? key,
    required this.ctx,
    required this.text,
  }) : super(key: key);

  final BuildContext ctx;
  final String text;

  @override
  Widget build(BuildContext context) {
    return text.text.make().pOnly(bottom: 5);
  }
}
