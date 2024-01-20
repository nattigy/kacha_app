import 'package:flutter/material.dart';
import 'package:kacha_app/app/send/view/send_page.dart';

import '../404/404_page.dart';

class SendNavigatorRoutes {
  static const String root = "/";
  static const String notFound = "not_found";
}

class SendNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const SendNavigator({Key? key, required this.navigatorKey}) : super(key: key);

  Map<String, WidgetBuilder> _routeBuilder(
    BuildContext context,
    RouteSettings settings,
  ) {
    return {
      SendNavigatorRoutes.root: (ctx) => SendPage(),
      SendNavigatorRoutes.notFound: (ctx) => const NotFoundPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: SendNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilder(context, routeSettings);
        return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            if (routeBuilders[routeSettings.name] != null) {
              return routeBuilders[routeSettings.name]!(context);
            }
            return routeBuilders[SendNavigatorRoutes.notFound]!(context);
          },
          transitionDuration: const Duration(seconds: 0),
          reverseTransitionDuration: const Duration(seconds: 0),
        );
      },
    );
  }
}
