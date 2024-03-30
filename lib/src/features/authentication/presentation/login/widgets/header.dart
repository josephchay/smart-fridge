import 'package:flutter/material.dart';

import '../../../../../config/themes/app_theme.dart';

class AppLoginHeader extends StatelessWidget {
  const AppLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.nearlyWhite.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Icon(
              Icons.kitchen_rounded,
              color: AppTheme.nearlyWhite.withOpacity(0.8),
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        const Text(
          'Back on Track',
          style: AppTheme.display2,
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: 300.0,
          child: Text(
            "Reconnect with the world behind the door of your refrigerator.",
            style: AppTheme.subtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
