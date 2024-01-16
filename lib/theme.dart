import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.openSansTextTheme(),
  // appBarTheme: const AppBarTheme(
  //   backgroundColor: Color.fromARGB(255, 113, 243, 230),
  //   elevation: 4,
  // ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
  // colorScheme: const ColorScheme.light(
  //   primary: Colors.orange,
  //   // secondary: Colors.yellow,
  //   // background: Color(0xF8B975FF),
  // ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
