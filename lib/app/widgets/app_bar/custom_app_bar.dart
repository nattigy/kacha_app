import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/constants.dart';
import '../../../utils/navigator.dart';
import '../../user/profile_settings.page.dart';

class CustomAppBar extends StatelessWidget {
  final bool? leading;
  final bool? isRoot;
  final bool? setting;

  const CustomAppBar({
    Key? key,
    this.leading = true,
    this.isRoot = false,
    this.setting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leading! ? 60 : 0,
      centerTitle: false,
      automaticallyImplyLeading: true,
      leading: leading!
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )
          : const SizedBox.shrink(),
      title: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Image.asset(AppImages.appLogo).w48(context).box.make(),
      ),
      actions: [
        if (setting != null && setting == true)
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: IconButton(
              onPressed: () {
                navigatorPush(context, const ProfileSettings());
              },
              icon: const Icon(Icons.settings),
              color: Colors.black,
            ),
          ).pOnly(right: 15).box.width(45).make(),
        if (setting == null || setting == false)
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.white),
          ).pOnly(right: 15).box.width(45).make(),
      ],
    );
  }
}
