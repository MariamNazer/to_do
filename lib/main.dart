import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //لازم اسخدمها عشان تتأكد ان الحاجة اللي عليها await خلصت كل ال initialization كلها
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (_) => TasksProvider(), child: const TodoApp()));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To do App',
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darktTheme,
      themeMode: ThemeMode.light,
    );
  }
}
