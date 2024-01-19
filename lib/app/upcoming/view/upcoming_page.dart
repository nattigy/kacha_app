import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/error_page/error_reloader_page.dart';
import 'package:kacha_app/app/upcoming/cubit/upcoming.cubit.dart';

import 'upcoming_card.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<UpcomingCubit, UpcomingState>(
      builder: (ctx, upcomingState) {
        if (upcomingState is UpcomingLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (upcomingState is UpcomingLoadSuccess) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 40),
            children: upcomingState.upcomingPayments
                .map((e) => UpcomingCard(upcomingPayment: e))
                .toList(),
          );
        }
        if (upcomingState is UpcomingOperationFailure) {
          return ErrorReLoader(reLoad: () {
            context.read<UpcomingCubit>().loadUpcomingCard();
          });
        }
        return ErrorReLoader(reLoad: () {
          context.read<UpcomingCubit>().loadUpcomingCard();
        });
      },
    );
  }
}
