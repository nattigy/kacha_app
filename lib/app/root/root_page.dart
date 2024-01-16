import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      HomeNavigator(navigatorKey: tabNavigatorKeys[TabItem.home.index]),
      HomeNavigator(navigatorKey: tabNavigatorKeys[TabItem.home.index]),
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
            // appBar: const PreferredSize(
            //   preferredSize: Size.fromHeight(55),
            //   child: CustomAppBar(leading: false, isRoot: true),
            // ),
            appBar: AppBar(
              title: Text("Home"),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text('Drawer Header'),
                  ),
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Item 3'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  Text("drawer"),
                ],
              ),
            ),
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
