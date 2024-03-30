import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthTertiaryButton extends StatelessWidget {
  const AppAuthTertiaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppTheme.lighterGrey.withOpacity(0.06),
        foregroundColor: AppTheme.darkText.withOpacity(0.3),
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(
          color: AppTheme.lighterGrey.withOpacity(0.06),
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.0,
        ),
      ),
    );
  }
}
