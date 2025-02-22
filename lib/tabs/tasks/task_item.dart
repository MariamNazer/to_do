import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.04),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(task.taskId)
                    .timeout(const Duration(microseconds: 5000),
                        onTimeout: () =>
                            Provider.of<TasksProvider>(context, listen: false)
                                .getTask())
                    .catchError((error) {
                  debugPrint('Error deleting task: $error');
                  Fluttertoast.showToast(
                      msg: "Somwthing went wrong",
                      toastLength: Toast.LENGTH_LONG,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16);
                });
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: height * 0.16,
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(end: width * 0.044),
                height: height * 0.1,
                width: width * 0.015,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              SizedBox(
                width: width * 0.58,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(task.title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: theme.primaryColor)),
                    Text(task.description, style: theme.textTheme.titleSmall),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: height * 0.05,
                width: width * 0.16,
                decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const Icon(
                  Icons.check,
                  color: AppTheme.white,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
