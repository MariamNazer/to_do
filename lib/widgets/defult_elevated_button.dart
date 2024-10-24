import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';

class DefultElevatedButton extends StatelessWidget {
  String lable;
  VoidCallback onPressed;
  DefultElevatedButton(
      {super.key, required this.lable, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.sizeOf(context).width * 0.75, 52)),
        child: Text(lable,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppTheme.white)));
  }
}
