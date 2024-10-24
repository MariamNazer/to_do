import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';

class DafultTaskFormFielld extends StatelessWidget {
  DafultTaskFormFielld(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator});
  TextEditingController controller;
  String hintText;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 20, color: AppTheme.grey.withOpacity(0.6118))),
      validator: validator,
      controller: controller,
    );
  }
}
