import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0XFF5D9CEC);
  static const Color lightBackground = Color(0xFFDFECDB);
  static const Color darkBackground = Color(0xFF060E1E);
  static const Color black = Color(0xFF363636);
  static const Color red = Color(0xFFEC4B4B);
  static const Color green = Color(0xFF61E757);
  static const Color grey = Color(0xFF707070);
  static const Color darkGrey = Color(0xFFCDCACA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF141922);
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: lightBackground,
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      unselectedItemColor: grey,
      selectedItemColor: primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 4, color: white))),
    textTheme: const TextTheme(
        titleLarge:
            TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: white),
        titleMedium:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
        titleSmall:
            TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: black)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: primary,
    )),
  );
  static ThemeData darktTheme = ThemeData(
    scaffoldBackgroundColor: darkBackground,
    primaryColor: primary,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, centerTitle: true),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: dark,
      unselectedItemColor: grey,
      selectedItemColor: primary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: dark,
        shape: CircleBorder(side: BorderSide(width: 4, color: dark))),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w900, color: darkBackground),
        titleMedium:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: white),
        titleSmall:
            TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: white)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: primary,
    )),
  );
}
