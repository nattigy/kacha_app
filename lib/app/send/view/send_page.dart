import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/auth/bloc/app_bloc.dart';
import 'package:kacha_app/app/history/cubit/history.cubit.dart';
import 'package:kacha_app/app/send/cubit/send.cubit.dart';
import 'package:kacha_app/app/upcoming/cubit/upcoming.cubit.dart';
import 'package:kacha_app/app/widgets/cards/margin_container.dart';
import 'package:payment_repository/payment_repository.dart';

import '../../home/cubit/home.cubit.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key, this.amount, this.to, this.id});

  final String? amount;
  final String? to;
  final String? id;

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    toController.text = widget.to ?? "";
    amountController.text = widget.amount ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendCubit, SendState>(
      listener: (ctx, sendState) {
        if (sendState is SendOperationFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(sendState.message),
              ),
            );
        }
        if (sendState is SendLoadSuccess) {
          context.read<HomeCubit>().loadHomeCard();
          context.read<HistoryCubit>().loadHistoryCard();
          context.read<UpcomingCubit>().loadUpcomingCard();
          context.read<AppBloc>().add(AppRefresh());
        }
        if (sendState is SendAllValid) {
          _dialogBuilder(context, sendState.transaction);
        }
      },
      builder: (ctx, sendState) {
        return Scaffold(
          body: sendState is SendLoading
              ? Center(child: CircularProgressIndicator())
              : MarginContainer(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Send in no time!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      TextField(
                        key: const Key('toInput_textField'),
                        controller: toController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          helperText: '',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        key: const Key('numberInput_textField'),
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          helperText: '',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        key: const Key('descriptionInput_textField'),
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          helperText: '',
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<SendCubit>().checkValid(
                                  amountController.text,
                                  toController.text,
                                  descriptionController.text,
                                  widget.id,
                                );
                          },
                          child: Text("Send now"),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> _dialogBuilder(BuildContext context, Transaction transaction) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: Text(
            'Are you sure you want to send ${transaction.amount} to ${transaction.to}',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Send'),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
                context.read<SendCubit>().send(transaction);
              },
            ),
          ],
        );
      },
    );
  }
}
