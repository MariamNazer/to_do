import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:to_do/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

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
            padding:
                EdgeInsets.fromLTRB(width * 0.1, height * 0.06, width * 0.1, 0),
            child: Text(AppLocalizations.of(context)!.to_do,
                style: theme.textTheme.titleMedium?.copyWith(
                    color: settingsProvider.defultThemeMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.darkBackground,
                    fontSize: 22)),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: height * 0.151),
            child: EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              focusDate: tasksProvider.selectedDate,
              lastDate: DateTime.now().add(const Duration(days: 365)),
              showTimelineHeader: false,
              onDateChange: (selectedDate) {
                tasksProvider.changeSelectedDate(selectedDate);
                tasksProvider.getTask();
              },
              dayProps: EasyDayProps(
                  height: height * 0.12,
                  width: width * 0.16,
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color:
                            settingsProvider.defultThemeMode == ThemeMode.light
                                ? AppTheme.white
                                : AppTheme.dark,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      dayNumStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary),
                      dayStrStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary)),
                  inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: settingsProvider.defultThemeMode ==
                                  ThemeMode.light
                              ? AppTheme.white
                              : AppTheme.dark,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      dayNumStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            settingsProvider.defultThemeMode == ThemeMode.light
                                ? AppTheme.black
                                : AppTheme.white,
                      ),
                      dayStrStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:
                            settingsProvider.defultThemeMode == ThemeMode.light
                                ? AppTheme.black
                                : AppTheme.white,
                      )),
                  todayStyle: const DayStyle(
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
