import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/widgets/dafult_text_form_fielld.dart';
import 'package:to_do/widgets/defult_elevated_button.dart';

class AddTaskBottomsheet extends StatefulWidget {
  const AddTaskBottomsheet({super.key});

  @override
  State<AddTaskBottomsheet> createState() => _AddTaskBottomsheetState();
}

class _AddTaskBottomsheetState extends State<AddTaskBottomsheet> {
  TextEditingController titltcontroller = TextEditingController();
  TextEditingController descriptiontcontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/mm/yyyy');
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    return Container(
      height: height * 0.54,
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Text(
                'Add new Task',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            DafultTaskFormFielld(
              controller: titltcontroller,
              hintText: 'Enter task title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title can not be empty';
                }
                return null;
              },
            ),
            DafultTaskFormFielld(
              controller: descriptiontcontroller,
              hintText: 'Enter task descrition',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description can not be empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.032,
            ),
            Text(
              'select date',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDate: selectedDate,
                    initialEntryMode: DatePickerEntryMode.calendar);
                if (dateTime != null && selectedDate != dateTime) {
                  selectedDate = dateTime;
                  setState(() {});
                }
              },
              child: Text(
                dateFormat.format(selectedDate),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            DefultElevatedButton(
                lable: 'Add',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addTask();
                  }
                })
          ],
        ),
      ),
    );
  }

  void addTask() {
    TaskModel task = TaskModel(
      title: titltcontroller.text,
      date: selectedDate,
      description: descriptiontcontroller.text,
    );
  }
}
