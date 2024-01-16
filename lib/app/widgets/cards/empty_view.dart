import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/constants.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppImages.emptypageImage).centered(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text.text.xl2.medium.color(AppColor.primaryColor).make(),
              IconButton(
                onPressed: () => {},
                color: AppColor.primaryColor,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ).pOnly(top: 12),
        ],
      ).pOnly(top: context.screenHeight * 0.04),
    );
  }
}
