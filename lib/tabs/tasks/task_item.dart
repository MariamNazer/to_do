import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/auth/user_provider.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/tabs/edit/task_editing.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;

  TaskItem(this.task, {super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    ThemeData theme = Theme.of(context);
    String userID = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.04),
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskEditing(
                  selectedDate: widget.task.date,
                  taskId: widget.task.taskId,
                  title: widget.task.title,
                  desc: widget.task.description),
            ),
          );

          // تحديث القائمة بعد التعديل
          Provider.of<TasksProvider>(context, listen: false).getTask(userID);
        },
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  FirebaseFunctions.deleteTaskFromFirestore(widget.task.taskId, userID)
                      .timeout(const Duration(microseconds: 5000),
                          onTimeout: () =>
                              // ignore: use_build_context_synchronously
                              Provider.of<TasksProvider>(context, listen: false)
                                  .getTask(userID))
                      .catchError((error) {
                    Fluttertoast.showToast(
                        msg: AppLocalizations.of(context)!.something_went_wrong,
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
                label: AppLocalizations.of(context)!.delete,
              ),
            ],
          ),
          child: Container(
            height: height * 0.16,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            decoration: BoxDecoration(
                color: settingsProvider.defultThemeMode == ThemeMode.light
                    ? AppTheme.white
                    : AppTheme.dark,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: width * 0.044),
                  height: height * 0.1,
                  width: width * 0.015,
                  decoration: BoxDecoration(
                      color: widget.task.isDone
                          ? AppTheme.green
                          : theme.primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
                SizedBox(
                  width: width * 0.58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.task.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                              color: widget.task.isDone
                                  ? AppTheme.green
                                  : theme.primaryColor)),
                      Text(widget.task.description,
                          style: theme.textTheme.titleSmall),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.05,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    color: widget.task.isDone
                        ? Colors.transparent
                        : theme.primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.task.isDone = !widget.task.isDone;
                      });
                      FirebaseFunctions.updateTaskStatus(
                          widget.task.taskId, widget.task.isDone, userID);
                    },
                    child: Center(
                      child: widget.task.isDone
                          ? Text(
                              AppLocalizations.of(context)!.done,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: AppTheme.green,
                                fontSize: 22,
                              ),
                            )
                          : const Icon(
                              Icons.check,
                              color: AppTheme.white,
                              size: 32,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
