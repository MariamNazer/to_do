import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/auth/register_screen.dart';
import 'package:to_do/auth/user_provider.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/home_screen.dart';
import 'package:to_do/widgets/dafult_text_form_fielld.dart';
import 'package:to_do/widgets/defult_elevated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                isPassword: true,
                validator: (value) {
                  if (value == null || value.trim().length < 5) {
                    return AppLocalizations.of(context)!.password_error;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              DefultElevatedButton(
                  lable: AppLocalizations.of(context)!.login,
                  onPressed: () => login()),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(RegisterScreen.routeName),
                  child: Text(AppLocalizations.of(context)!.do_not_have))
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.login(
              email: emailController.text.trim(),
              password: passwordController.text)
          .then((User) {
        print('Success');
        Provider.of<UserProvider>(context, listen: false).updateUser(User);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }).catchError((error) {
        String? message;
        if (error is FirebaseAuthException) {
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
