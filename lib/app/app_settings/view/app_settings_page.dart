import 'package:flutter/material.dart';
import 'package:kacha_app/app/widgets/scaffold/drawer_scaffold.dart';
import 'package:velocity_x/velocity_x.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageTittle: "Settings",
      child: Text("settings"),
    );
  }
}
