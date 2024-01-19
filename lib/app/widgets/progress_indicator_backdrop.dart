import 'package:flutter/material.dart';

class ProgressIndicatorBackdrop extends StatelessWidget {
  final double? progress;
  final Color? backgroundColor;

  const ProgressIndicatorBackdrop({
    super.key,
    this.progress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height,
      width: double.infinity,
      padding: EdgeInsets.only(top: deviceSize.height * .4),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(color: Colors.white.withOpacity(.8)),
      child: CircularProgressIndicator(value: progress, color: backgroundColor),
    );
  }
}
