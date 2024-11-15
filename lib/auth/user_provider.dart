import 'package:flutter/material.dart';
import 'package:to_do/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }

  static of(BuildContext context) {}
}
