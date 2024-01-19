import 'package:flutter/material.dart';

import '../404/404_page.dart';
import 'home_page.dart';

class HomeNavigatorRoutes {
  static const String root = "/";
  static const String notFound = "not_found";
}

class HomeNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const HomeNavigator({Key? key, required this.navigatorKey}) : super(key: key);

  Map<String, WidgetBuilder> _routeBuilder(
    BuildContext context,
    RouteSettings settings,
  ) {
    return {
      HomeNavigatorRoutes.root: (ctx) => const HomePage(),
      HomeNavigatorRoutes.notFound: (ctx) => const NotFoundPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: HomeNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilder(context, routeSettings);
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            if (routeBuilders[routeSettings.name] != null) {
              return routeBuilders[routeSettings.name]!(context);
            }
            return routeBuilders[HomeNavigatorRoutes.notFound]!(context);
          },
          transitionDuration: const Duration(seconds: 0),
          reverseTransitionDuration: const Duration(seconds: 0),
        );
      },
    );
  }
}
