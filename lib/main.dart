import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/home_screen.dart';

void main() {
  runApp( TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do App',
      routes: {
        HomeScreen.routeName:(_)=>HomeScreen(),
      },
      initialRoute:  HomeScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darktTheme,
      themeMode: ThemeMode.light,
    );
  }
}
