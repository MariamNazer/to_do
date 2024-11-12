import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/app_theme.dart';
import 'package:to_do/tabs/settings/settings_provider.dart';

class DafultTaskFormFielld extends StatefulWidget {
  final bool isPassword;
  const DafultTaskFormFielld({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<DafultTaskFormFielld> createState() => _DafultTaskFormFielldState();
}

class _DafultTaskFormFielldState extends State<DafultTaskFormFielld> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure; 
                  });
                },
                icon: Icon(
                  isObsecure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        hintStyle: TextStyle(
          fontSize: 20,
          color: settingsProvider.defultThemeMode == ThemeMode.light
              ? AppTheme.grey
              : AppTheme.darkGrey.withOpacity(0.6118),
        ),
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: widget.isPassword ? isObsecure : false,
      controller: widget.controller,
      style: TextStyle(
        color: settingsProvider.defultThemeMode == ThemeMode.light
            ? AppTheme.black
            : AppTheme.white,
      ),
    );
  }
}
