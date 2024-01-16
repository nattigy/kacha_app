import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ShadowCard extends StatelessWidget {
  const ShadowCard({Key? key, required this.child, this.color})
      : super(key: key);

  final Color? color;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1),
            spreadRadius: 1,
            blurRadius: 4,
            color: AppColor.lightShadowColor,
          ),
        ],
      ),
      child: child,
    );
  }
}
