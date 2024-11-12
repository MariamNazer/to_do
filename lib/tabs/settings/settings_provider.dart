import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode defultThemeMode = ThemeMode.light;
  String languageCode = 'en';
  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('isDark');
    defultThemeMode = (theme == 'dark') ? ThemeMode.dark : ThemeMode.light;
    languageCode = prefs.getString('language')!;
    notifyListeners();
  }

  SettingsProvider() {
    getTheme();
  }
  Future<void> changeTheme(ThemeMode theme) async {
    defultThemeMode = theme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'isDark', theme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  Future<void> changeLanguage(String selectedLanguage) async {
    if (selectedLanguage == languageCode) return;
    languageCode = selectedLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', selectedLanguage == 'en' ? 'en' : 'ar');
    notifyListeners();
  }
}
