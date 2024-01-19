import 'package:flutter/material.dart';
import 'package:kacha_app/app/upcoming/upcoming.dart';

import 'widgets/home_balance_card.dart';

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

  String selectedTab = "upcoming";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DefaultTabController(
        length: 2,
        child: ListView(
          children: [
            Text(
              "Welcome, Nathnael",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            HomeBalanceCard(),

            TabBar(
              tabs: [
                Tab(
                  child: Text("Upcoming"),
                ),
                Tab(
                  child: Text("History"),
                ),
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: TabBarView(
                children: [
                  UpcomingPage(),
                  ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HomeBalanceCard(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
