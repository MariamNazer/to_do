import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTasks) {
      tasksProvider.getTask();
      shouldGetTasks = false;
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Stack(children: [
          Container(
            height: height * 0.22,
            width: width,
            color: AppTheme.primary,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.1, height * 0.06, 0, 0),
            child: Text('To Do List',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: AppTheme.white, fontSize: 22)),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: height * 0.151),
            child: EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              focusDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              showTimelineHeader: false,
              dayProps: EasyDayProps(
                  height: height * 0.12,
                  width: width * 0.16,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: const DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      dayNumStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary),
                      dayStrStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                  inactiveDayStyle: const DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      dayNumStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.black),
                      dayStrStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.black))),
            ),
          ),
        ]),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.only(top: height * 0.03),
          itemBuilder: (_, index) => TaskItem(tasksProvider.tasks[index]),
          itemCount: tasksProvider.tasks.length,
        )),
      ],
    );
  }
}
