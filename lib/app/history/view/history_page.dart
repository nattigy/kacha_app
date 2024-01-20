import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/error_page/error_reloader_page.dart';
import 'package:kacha_app/app/history/cubit/history.cubit.dart';

import 'history_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (ctx, historyState) {
        if (historyState is HistoryLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (historyState is HistoryLoadSuccess) {
          return Scaffold(
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 40),
              children: historyState.transactionHistory
                  .map((e) => HistoryCard(transaction: e))
                  .toList(),
            ),
          );
        }
        if (historyState is HistoryOperationFailure) {
          return Scaffold(
            body: ErrorReLoader(reLoad: () {
              context.read<HistoryCubit>().loadHistoryCard();
            }),
          );
        }
        return Scaffold(
          body: ErrorReLoader(reLoad: () {
            context.read<HistoryCubit>().loadHistoryCard();
          }),
        );
      },
    );
  }
}
