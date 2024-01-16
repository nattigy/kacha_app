import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/circular_icon.dart';

class SignUpProgressIndicator extends StatelessWidget {
  const SignUpProgressIndicator({super.key, required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularIcon(
          icon: FontAwesomeIcons.solidUser,
          iconColor: AppColor.primaryColor,
          borderColor: AppColor.primaryColor,
        ),
        Container(
          width: 183,
          height: 4,
          decoration: BoxDecoration(
            color: step == 1 ? AppColor.primaryLight : AppColor.primaryColor,
          ),
        ),
        CircularIcon(
          icon: Icons.security,
          iconColor: step == 1 ? AppColor.primaryLight : AppColor.primaryColor,
          borderColor:
              step == 1 ? AppColor.primaryLight : AppColor.primaryColor,
        ),
      ],
    );
  }
}
