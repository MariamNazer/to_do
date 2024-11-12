import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/home_screen.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';
import 'package:to_do/tabs/tasks/tasks_provider.dart';
import 'package:to_do/widgets/dafult_text_form_fielld.dart';
import 'package:to_do/widgets/defult_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskEditing extends StatefulWidget {
  static const String routeName = 'edit';
  String taskId;
  DateTime selectedDate;
  String title;
  String desc;

  TaskEditing(
      {super.key,
      required this.taskId,
      required this.selectedDate,
      required this.desc,
      required this.title});

  @override
  State<TaskEditing> createState() => _TaskEditingState();
}

class _TaskEditingState extends State<TaskEditing> {
  TextEditingController titltcontroller = TextEditingController();
  TextEditingController descriptiontcontroller = TextEditingController();

  var formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat('dd/mm/yyyy');
  @override
  Widget build(BuildContext context) {
    titltcontroller.text = widget.title;
    descriptiontcontroller.text = widget.desc;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: height * 0.22,
                width: width,
                color: AppTheme.primary,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    width * 0.1, height * 0.06, width * 0.1, 0),
                child: Text(AppLocalizations.of(context)!.to_do,
                    style: theme.textTheme.titleMedium?.copyWith(
                        color:
                            settingsProvider.defultThemeMode == ThemeMode.light
                                ? AppTheme.white
                                : AppTheme.dark,
                        fontSize: 22)),
              )
            ]),
            Transform.translate(
              offset: Offset(0, -height * 0.06),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15), right: Radius.circular(15)),
                    color: settingsProvider.defultThemeMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.dark,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: Text(
                            AppLocalizations.of(context)!.edit_task,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        DafultTaskFormFielld(
                          controller: titltcontroller,
                          hintText: AppLocalizations.of(context)!.this_is_title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.title_error;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        DafultTaskFormFielld(
                          controller: descriptiontcontroller,
                          hintText: AppLocalizations.of(context)!.task_details,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!
                                  .description_error;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.032,
                        ),
                        Text(
                          AppLocalizations.of(context)!.select_date,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? dateTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                                initialDate: widget.selectedDate,
                                initialEntryMode: DatePickerEntryMode.calendar);
                            if (dateTime != null &&
                                widget.selectedDate != dateTime) {
                              widget.selectedDate = dateTime;
                              setState(() {});
                            }
                          },
                          child: Text(dateFormat.format(widget.selectedDate),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleMedium?.copyWith(
                                  color: settingsProvider.defultThemeMode ==
                                          ThemeMode.light
                                      ? AppTheme.grey
                                      : AppTheme.white,
                                  fontWeight: FontWeight.w300)),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        DefultElevatedButton(
                          lable: AppLocalizations.of(context)!.save_Changes,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              FirebaseFunctions.editTaskStatus(
                                widget.taskId,
                                titltcontroller.text,
                                descriptiontcontroller.text,
                                widget.selectedDate,
                              ).timeout(
                                const Duration(microseconds: 100),
                                onTimeout: () {
                                  Navigator.of(context).pop();
                                  Provider.of<TasksProvider>(context,
                                          listen: false)
                                      .getTask();
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeScreen.routeName);
                                },
                              ).catchError((error) {
                                Fluttertoast.showToast(
                                    msg: AppLocalizations.of(context)!
                                        .something_went_wrong,
                                    toastLength: Toast.LENGTH_LONG,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16);
                              });
                              setState(() {});
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
