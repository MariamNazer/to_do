import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/tabs/settings/settings_tab.dart';
import 'package:to_do/tabs/tasks/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [TasksTab(), SettingsTab()];
  int currentTabsIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabsIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),//الشكل اللي هقص ع زيه  
        notchMargin: 10, //هنا بحدد المساحة اللي هقصها
        clipBehavior: Clip.antiAliasWithSaveLayer, //هنا بقص بقى

        color: AppTheme.white,
        padding: EdgeInsets.zero, //عشان ياخد مساحة ال nav bar كلها
        child: BottomNavigationBar(
            currentIndex: currentTabsIndex,
            onTap: (index) => setState(() => currentTabsIndex = index),
            elevation: 0, //عشان ميسبش مساحه بينه وبين الاسكرين 
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 20,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}