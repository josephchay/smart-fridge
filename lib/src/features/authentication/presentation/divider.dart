import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthDivider extends StatelessWidget {
  const AppAuthDivider({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: AppTheme.lightGrey.withOpacity(0.6),
            thickness: 0.5,
            indent: 60,
            endIndent: 10,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: AppTheme.lighterGrey.withOpacity(1),
            fontSize: 13,
          ),
        ),
        Flexible(
          child: Divider(
            color: AppTheme.lightGrey.withOpacity(0.6),
            thickness: 0.5,
            indent: 10,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
