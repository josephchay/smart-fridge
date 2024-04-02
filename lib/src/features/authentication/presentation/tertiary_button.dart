import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AuthTertiaryButton extends StatelessWidget {
  const AuthTertiaryButton({
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
          fontSize: 14.0,
        ),
        textScaleFactor: Scaler.textScaleFactor(context),
      ),
    );
  }
}
