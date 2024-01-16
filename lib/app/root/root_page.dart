import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/firebase_events_logger.dart';
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
            analyticsBottomNavigationEvent(selectedTab: "home");
            setCurrentIndex(TabItem.home);
            Navigator.pushNamed(
              tabNavigatorKeys[TabItem.home.index].currentContext!,
              state.pathName,
            );
          }
          if (state is NavigatedToJobs) {
            analyticsBottomNavigationEvent(selectedTab: "jobs");
            setCurrentIndex(TabItem.jobs);
            Navigator.pushNamed(
              tabNavigatorKeys[TabItem.jobs.index].currentContext!,
              state.pathName,
            );
          }
          if (state is NavigatedToProfile) {
            analyticsBottomNavigationEvent(selectedTab: "profile");
            setCurrentIndex(TabItem.profile);
            if (state.pathName != "") {
              Navigator.pushNamed(
                  tabNavigatorKeys[TabItem.profile.index].currentContext!,
                  state.pathName);
            } else {
              while (Navigator.canPop(globalNavigator)) {
                Navigator.pop(globalNavigator);
              }
              Navigator.pushNamedAndRemoveUntil(
                  tabNavigatorKeys[TabItem.profile.index].currentContext!,
                  "/",
                  (route) => false);
            }
          }
        },
        builder: (ctx, state) {
          return Scaffold(
            body: IndexedStack(
              index: _currentTab.index,
              children: [
                _buildOffstageNavigator(TabItem.home, true),
                _buildOffstageNavigator(TabItem.jobs, true),
                _buildOffstageNavigator(TabItem.profile, true),
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

enum TabItem { home, jobs, profile }
