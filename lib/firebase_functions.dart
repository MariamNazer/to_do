import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
          fromFirestore: (docSnapshot, _) =>
              TaskModel.fromJson(docSnapshot.data()!),
          toFirestore: (taskModel, _) => (taskModel.toJson()));
  static Future<void> addTaskToFiresore(TaskModel task) {
    CollectionReference<TaskModel> tasksCollection = getCollection();
    DocumentReference doc = tasksCollection.doc();
    task.taskId = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> gitAllTasksFirestore() async {
    CollectionReference<TaskModel> tasksCollection = getCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId) async {
    CollectionReference<TaskModel> tasksCollection = getCollection();
    return tasksCollection.doc(taskId).delete();
  }
}
