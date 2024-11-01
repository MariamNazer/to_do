import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  String description;
  DateTime date;
  bool isDone;
  String taskId;
  TaskModel(
      {required this.title,
      required this.date,
      required this.description,
      this.isDone = false,
      this.taskId = ''});
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          date: (json['date'] as Timestamp).toDate(),
          description:
              json['description'] ?? '', 
          title: json['title'] ?? '',
          taskId: json['taskId'] ?? '', 
          isDone: json['isDone'] is bool ? json['isDone'] : false,
        );

  Map<String, dynamic> toJson() => {
        'id': taskId,
        'description': description,
        'title': title,
        'isDone': isDone,
        'date': Timestamp.fromDate(date)
      };
}
