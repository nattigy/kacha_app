import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:velocity_x/velocity_x.dart';

import '../auth/bloc/auth_bloc.dart';
import '../user/entity/user.entity.dart';
import '../user/enum/user.enums.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/text/form-label-text.dart';
import 'bloc/edit_user.cubit.dart';
import 'widgets/widgets.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController middleNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController genderCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneNumberCont = TextEditingController();

  @override
  void initState() {
    UserEntity user = context.read<AuthenticationBloc>().state.user;
    context.read<EditUserCubit>().editUserPopulateAll(
          user.fullName.split(" ")[0],
          user.fullName.split(" ")[1],
          user.fullName.split(" ")[2],
          user.gender != null ? user.gender! : UserGenderEnum.FEMALE,
        );
    firstNameCont.text = user.fullName.split(" ")[0];
    middleNameCont.text = user.fullName.split(" ")[1];
    lastNameCont.text = user.fullName.split(" ")[2];
    emailCont.text = user.email ?? "";
    phoneNumberCont.text = user.phoneNumber?.substring(4) ?? "";
    genderCont.text = user.gender != null
        ? user.gender!.name.toLowerCase().upperCamelCase
        : "Female";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit username and gender")),
      body: BlocConsumer<EditUserCubit, EditUserState>(
        listener: (ctx, editUserState) {
          if (editUserState.status.isInProgress) {
            ScaffoldMessenger.of(context).clearSnackBars();
          }
          if (editUserState.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(editUserState.exceptionError),
                  duration: const Duration(seconds: 3),
                ),
              );
          }
          if (editUserState.status.isSuccess) {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationReFetchUserChanged());
          }
        },
        builder: (ctx, editUserState) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        FormLabel(ctx: context, text: "Given Name"),
                        EditUserFirstNameInput(firstNameCont: firstNameCont),
                        const SizedBox(height: 20),
                        FormLabel(ctx: context, text: "Father's Name"),
                        EditUserMiddleNameInput(middleNameCont: middleNameCont),
                        const SizedBox(height: 20),
                        FormLabel(ctx: context, text: "Grand Father's Name"),
                        EditLastNameInput(lastNameCont: lastNameCont),
                        const SizedBox(height: 20),
                        FormLabel(ctx: context, text: "Gender"),
                        EditUserGenderInput(
                          genderCont: genderCont,
                          genderValue: genderCont.text,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<EditUserCubit>().submitEditUser();
                              }
                            },
                            text: 'Save',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (editUserState.status.isInProgress)
                Container(
                  height: deviceSize.height,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: deviceSize.height * .4),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.8),
                  ),
                  child: const CircularProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
