import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';
import 'package:kacha_app/app/history/cubit/history.cubit.dart';
import 'package:kacha_app/app/home/cubit/home.cubit.dart';
import 'package:kacha_app/app/top_up/cubit/top_up.cubit.dart';
import 'package:kacha_app/app/widgets/cards/margin_container.dart';
import 'package:kacha_app/app/widgets/scaffold/drawer_scaffold.dart';

class TopUpPage extends StatefulWidget {
  TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopUpCubit, TopUpState>(
      listener: (ctx, topState) {
        if (topState is TopUpOperationFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(topState.message),
              ),
            );
        }
        if (topState is TopUpLoadSuccess) {
          context.read<HomeCubit>().loadHomeCard();
          context.read<HistoryCubit>().loadHistoryCard();
          context.read<AppBloc>().add(AppRefresh());
        }
      },
      builder: (ctx, topState) {
        return CustomScaffold(
          pageTittle: "Top up",
          child: MarginContainer(
            child: topState is TopUpLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Only for demonstration purpose!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      TextField(
                        key: const Key('numberInput_textField'),
                        keyboardType: TextInputType.number,
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          helperText: '',
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<TopUpCubit>().topUp(controller.text);
                          },
                          child: Text("Top up now"),
                        )
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
