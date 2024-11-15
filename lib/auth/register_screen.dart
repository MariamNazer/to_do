import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/auth/login_screen.dart';
import 'package:to_do/auth/user_provider.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/home_screen.dart';
import 'package:to_do/widgets/dafult_text_form_fielld.dart';
import 'package:to_do/widgets/defult_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
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
                  isPassword: true,
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
                    onPressed: register),
                const SizedBox(height: 8),
                TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName),
                    child: Text(AppLocalizations.of(context)!.already_have)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
              name: nameController.text,
              email: emailController.text.trim(),
              password: passwordController.text)
          .then((User) {
        print('Success');
        Provider.of<UserProvider>(context, listen: false).updateUser(User);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }).catchError((error) {
        String? message;
        if (error is FirebaseException) {
          message = error.message;
        }
        Fluttertoast.showToast(
            msg: message ?? AppLocalizations.of(context)!.something_went_wrong,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
            backgroundColor: AppTheme.red,
            textColor: AppTheme.white);
      });
    }
  }
}
