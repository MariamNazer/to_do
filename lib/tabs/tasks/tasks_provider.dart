import 'package:flutter/material.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  Future<void> getTask() async {
    tasks = await FirebaseFunctions.gitAllTasksFirestore();
    notifyListeners();
  }
}
