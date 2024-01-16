import 'package:flutter/material.dart';

import '../widgets/app_bar/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> reLoadApp() async {}

  @override
  void initState() {
    reLoadApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async => reLoadApp(),
        child: Text("home"),
      );
  }
}
