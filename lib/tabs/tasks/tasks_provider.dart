import 'package:flutter/material.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  List<TaskModel> tasks = [];
  Future<void> getTask() async {
    tasks = await FirebaseFunctions.gitAllTasksFirestore();
    tasks = tasks
        .where((task) =>
            task.date.year == selectedDate.year &&
            task.date.month == selectedDate.month &&
            task.date.day == selectedDate.day)
        .toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
