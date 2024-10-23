import 'package:flutter/material.dart';
import 'package:to_do/app_theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: height * 0.02, horizontal: width * 0.04),
      height: height * 0.16,
      width: width * 0.6,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
          color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: width * 0.044),
            height: height * 0.1,
            width: width * 0.015,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
          SizedBox(
            width: width * 0.58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Play basket ball',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: theme.primaryColor)),
                Text('Play basket ballPlay basket ball',
                    style: theme.textTheme.titleSmall),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: height * 0.05,
            width: width * 0.16,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: const Icon(
              Icons.check,
              color: AppTheme.white,
              size: 32,
            ),
          )
        ],
      ),
    );
  }
}
