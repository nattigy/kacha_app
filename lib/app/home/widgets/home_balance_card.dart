import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/error_page/error_reloader_page.dart';
import 'package:kacha_app/app/home/cubit/home.cubit.dart';

class HomeBalanceCard extends StatelessWidget {
  const HomeBalanceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return BlocBuilder<HomeCubit, HomeState>(builder: (ctx, homeState) {
      if (homeState is HomeLoading) {
        return Padding(
          padding: EdgeInsets.only(top: deviceSize.height / 3),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (homeState is HomeLoadSuccess) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          color: Colors.orangeAccent,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(Icons.flag),
                ),
                SizedBox(height: 10),
                Text("Total balance"),
                Text(
                  homeState.totalBalance.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                Text("ETB"),
              ],
            ),
          ),
        );
      }
      if (homeState is HomeOperationFailure) {
        return Padding(
          padding: EdgeInsets.only(top: deviceSize.height / 3),
          child: ErrorReLoader(reLoad: () {}),
        );
      }
      return Padding(
        padding: EdgeInsets.only(top: deviceSize.height / 3),
        child: ErrorReLoader(reLoad: () {}),
      );
    });
  }
}
