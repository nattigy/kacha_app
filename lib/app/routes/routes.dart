import 'package:flutter/widgets.dart';
import 'package:kacha_app/app/app.dart';
import 'package:kacha_app/app/view/welcome.dart';
import 'package:kacha_app/home/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [WelComePage.page()];
  }
}
