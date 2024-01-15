import 'package:flutter/widgets.dart';
import 'package:kacha_app/app/app.dart';
import 'package:kacha_app/home/home.dart';
import 'package:kacha_app/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
