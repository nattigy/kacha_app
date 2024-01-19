import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/navigator.dart';
import '../edit_user/edit_user_page.dart';
import '../widgets/cards/margin_container.dart';
import '../widgets/cards/max_width.dart';
import 'bloc/users.bloc.dart';

class ProfileSettings extends StatefulWidget {
  final bool? editName;

  const ProfileSettings({super.key, this.editName = false});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UsersBloc, UsersState>(
          listener: (ctx, userOperationState) {
            if (userOperationState is DeleteUserSuccess) {
              // context
              //     .read<AuthenticationBloc>()
              //     .add(AuthenticationLogoutRequested());
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Profile settings")),
        body: BlocBuilder<UsersBloc, UsersState>(builder: (ctx, userBlocState) {
          if (userBlocState is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: MarginContainer(
              child: MaxWidth(
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    if (widget.editName == true)
                      OutlinedButton(
                        onPressed: () => navigatorPush(
                          context,
                          const EditUser(),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.edit),
                            Text('Edit Username and Gender'),
                            SizedBox(width: 32.0),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16.0),
                    OutlinedButton(
                      onPressed: () {
                        // context
                        //     .read<AuthenticationBloc>()
                        //     .add(AuthenticationLogoutRequested());
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0)),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.redAccent),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Colors.grey.shade300,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.logout, color: Colors.redAccent),
                          Text(
                            'Logout',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          SizedBox(width: 32.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    OutlinedButton(
                      onPressed: () {
                        buildShowFirstConfirmationDialog(context);
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0)),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.grey),
                        ),
                        overlayColor: MaterialStateProperty.all(
                          Colors.grey.shade300,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.delete, color: Colors.grey),
                          Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 32.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<dynamic> buildShowFirstConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure you want to delete your account?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        buildShowLastConfirmationDialog(context);
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> buildShowLastConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Are you sure? All your data will be removed from our database, you won't be able to recover. Click 'Confirm' to continue. Or click 'Exit' to return.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.read<UsersBloc>().deleteUser();
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Exit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
