import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/cards/margin_container.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MarginContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          'Welcome'.text.lg.color(AppColor.greyTextColor).make(),
          // Builder(
          //   builder: (context) {
          //     UserEntity? user = context.select(
          //       (AuthenticationBloc bloc) => bloc.state.user,
          //     );
          //     if (user != null && user.tutorId != null) {
          //       analyticsUserIdSetter(id: user.tutorId!);
          //     }
          //     if (user == null) {
          //       return const SizedBox();
          //     }
          //     return (user.fullName)
          //         .text
          //         .xl
          //         .extraBold
          //         .color(AppColor.accentColor)
          //         .make();
          //   },
          // ),
        ],
      ),
    );
  }
}
