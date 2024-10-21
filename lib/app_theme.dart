import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0XFF5D9CEC);
  static const Color lightBackground = Color(0xFFDFECDB);
  static const Color darkBackground = Color(0xFF060E1E);
  static const Color black = Color(0xFF363636);
  static const Color red = Color(0xFFEC4B4B);
  static const Color green = Color(0xFF61E757);
  static const Color grey = Color(0xFF707070);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darhgrey = Color(0xFF141922);
  // static ThemeData lightTheme = ThemeData();
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightBackground,
      primaryColor: primary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          unselectedItemColor: grey,
          selectedItemColor: primary,
          showSelectedLabels: false,
          showUnselectedLabels: false),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: primary,
          foregroundColor: white,
          shape: CircleBorder(
            side: BorderSide(width:4,color: white )
          ))
          );
  static ThemeData darktTheme = ThemeData();
}
