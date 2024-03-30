import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthSecondaryButton extends StatelessWidget {
  const AppAuthSecondaryButton({
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
        foregroundColor: AppTheme.nearlyDarkOrange,
        minimumSize: const Size(double.infinity, 56),
        side: const BorderSide(
          color: AppTheme.nearlyDarkOrange,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
