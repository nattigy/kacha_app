import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/error_page/error_reloader_page.dart';
import 'package:kacha_app/app/history/cubit/history.cubit.dart';

import 'history_card.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (ctx, historyState) {
        if (historyState is HistoryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (historyState is HistoryLoadSuccess) {
          if (historyState.transactionHistory.length == 0){
            return Center(child: Text("No transactions yet."));
          }
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 40),
            children: historyState.transactionHistory
                .map((e) => HistoryCard(transaction: e))
                .toList(),
          );
        }
        if (historyState is HistoryOperationFailure) {
          return ErrorReLoader(reLoad: () {
            context.read<HistoryCubit>().loadHistoryCard();
          });
        }
        return ErrorReLoader(reLoad: () {
          context.read<HistoryCubit>().loadHistoryCard();
        });
      },
    );
  }
}
