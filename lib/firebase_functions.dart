import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/models/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
          fromFirestore: (docSnapshot, _) =>
              UserModel.fromJson(docSnapshot.data()!),
          toFirestore: (userModel, _) => (userModel.toJson()));

  static CollectionReference<TaskModel> getCollection(String userId) =>
      getUsersCollection()
          .doc(userId)
          .collection('tasks')
          .withConverter<TaskModel>(
              fromFirestore: (docSnapshot, _) =>
                  TaskModel.fromJson(docSnapshot.data()!),
              toFirestore: (taskModel, _) => (taskModel.toJson()));

  static Future<void> addTaskToFiresore(TaskModel task, String userId) {
    CollectionReference<TaskModel> tasksCollection = getCollection(userId);
    DocumentReference doc = tasksCollection.doc();
    task.taskId = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> gitAllTasksFirestore(String userId) async {
    CollectionReference<TaskModel> tasksCollection = getCollection(userId);
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> updateTaskStatus(
      String taskId, bool isDone, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getCollection(userId);
    return tasksCollection.doc(taskId).update({'isDone': isDone});
  }

  static Future<void> deleteTaskFromFirestore(
      String taskId, String userId) async {
    CollectionReference<TaskModel> tasksCollection = getCollection(userId);
    return tasksCollection.doc(taskId).delete();
  }

  static Future<void> editTaskStatus(String taskId, String name,
      String description, DateTime date, String userId) async {
    CollectionReference tasksCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks');
    await tasksCollection.doc(taskId).update({
      'title': name,
      'description': description,
      'date': Timestamp.fromDate(date), // تحويل التاريخ إلى Timestamp
    });
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user =
        UserModel(id: userCredential.user!.uid, name: name, email: email);
    CollectionReference<UserModel> userscollection = getUsersCollection();
    await userscollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> userscollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapShot =
        await userscollection.doc(userCredential.user!.uid).get();
    return docSnapShot.data();
  }
}
