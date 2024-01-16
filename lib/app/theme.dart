import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryColor),
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColor.primaryColor,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: AppColor.textFormFieldColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: const EdgeInsets.all(10),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.grey)),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.grey,
      subtitleTextStyle: TextStyle(fontSize: 12, color: Colors.grey),
    ),
  );
}
