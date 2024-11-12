import 'package:flutter/material.dart';
import 'package:to_do/auth/login_screen.dart';
import 'package:to_do/widgets/dafult_text_form_fielld.dart';
import 'package:to_do/widgets/defult_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DafultTaskFormFielld(
                controller: nameController,
                hintText: AppLocalizations.of(context)!.name,
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return AppLocalizations.of(context)!.name_error;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DafultTaskFormFielld(
                controller: emailController,
                hintText: AppLocalizations.of(context)!.email,
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return AppLocalizations.of(context)!.email_error;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DafultTaskFormFielld(
                controller: passwordController,
                hintText: AppLocalizations.of(context)!.password,
                validator: (value) {
                  if (value == null || value.trim().length < 8) {
                    return AppLocalizations.of(context)!.password_error;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              DefultElevatedButton(
                  lable: AppLocalizations.of(context)!.register,
                  onPressed: login),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName),
                  child: Text(AppLocalizations.of(context)!.already_have)),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {}
  }
}
