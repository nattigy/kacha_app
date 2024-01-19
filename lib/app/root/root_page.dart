import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kacha_app/app/profile/profile.dart';
import 'package:kacha_app/app/send/send_navigator.dart';
import 'package:kacha_app/app/transactions/transactions_navigator.dart';
import 'package:kacha_app/app/widgets/scaffold/drawer.dart';
import 'package:kacha_app/utils/navigator.dart';

import '../home/home_navigator.dart';
import 'bloc/navigation_bloc.dart';
import 'widgets/bottom_navigation.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  TabItem _currentTab = TabItem.home;

  static const List<String> pageTitles = ["Home", "Send", "Transactions"];

  final tabNavigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late List<Widget> tabNavigators;
  late BuildContext globalNavigator;

  @override
  void initState() {
    globalNavigator = context;
    tabNavigators = [
      HomeNavigator(navigatorKey: tabNavigatorKeys[TabItem.home.index]),
      SendNavigator(navigatorKey: tabNavigatorKeys[TabItem.send.index]),
      TransactionsNavigator(
          navigatorKey: tabNavigatorKeys[TabItem.transactions.index]),
    ];
    super.initState();
  }

  setCurrentIndex(TabItem item) {
    setState(() {
      _currentTab = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final mayPop = Navigator.canPop(
            tabNavigatorKeys[_currentTab.index].currentContext!);
        if (mayPop) {
          Navigator.pop(tabNavigatorKeys[_currentTab.index].currentContext!);
          return false;
        } else if (!mayPop && _currentTab != TabItem.home) {
          setCurrentIndex(TabItem.home);
          return false;
        }
        return true;
      },
      child: BlocConsumer<NavigationBloc, NavigationState>(
        listener: (ctx, state) {
          if (state is NavigatedToHome) {
            setCurrentIndex(TabItem.home);
            Navigator.pushNamed(
              tabNavigatorKeys[TabItem.home.index].currentContext!,
              state.pathName,
            );
          }
          if (state is NavigatedToJobs) {
            setCurrentIndex(TabItem.send);
            Navigator.pushNamed(
              tabNavigatorKeys[TabItem.send.index].currentContext!,
              state.pathName,
            );
          }
          if (state is NavigatedToProfile) {
            setCurrentIndex(TabItem.transactions);
            if (state.pathName != "") {
              Navigator.pushNamed(
                  tabNavigatorKeys[TabItem.transactions.index].currentContext!,
                  state.pathName);
            } else {
              while (Navigator.canPop(globalNavigator)) {
                Navigator.pop(globalNavigator);
              }
              Navigator.pushNamedAndRemoveUntil(
                  tabNavigatorKeys[TabItem.transactions.index].currentContext!,
                  "/",
                  (route) => false);
            }
          }
        },
        builder: (ctx, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(pageTitles[_currentTab.index]),
              actions: [
                IconButton(
                  onPressed: () {
                    navigatorPush(context, ProfilePage());
                  },
                  icon: Icon(Icons.person),
                )
              ],
            ),
            drawer: CustomDrawer(),
            body: IndexedStack(
              index: _currentTab.index,
              children: [
                _buildOffstageNavigator(TabItem.home, true),
                _buildOffstageNavigator(TabItem.send, true),
                _buildOffstageNavigator(TabItem.transactions, true),
              ],
            ),
            bottomNavigationBar: BottomNavigation(
              currentTab: _currentTab.index,
              onTap: (item) => setCurrentIndex(TabItem.values[item]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem item, bool maintainState) {
    return Visibility(
      visible: _currentTab == item,
      maintainState: maintainState,
      child: tabNavigators[item.index],
    );
  }
}

enum TabItem { home, send, transactions }
