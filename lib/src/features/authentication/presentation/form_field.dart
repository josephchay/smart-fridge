import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthFormField extends StatelessWidget {
  const AppAuthFormField({
    super.key,
    required this.label,
    required this.labelHint,
    required this.inputType,
    required this.icon,
    this.expands = false,
  });

  final bool expands;
  final String label;
  final String labelHint;
  final TextInputType inputType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: expands,
      obscureText: TextInputType.visiblePassword == inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 24,
        ),
        suffixIcon: TextInputType.visiblePassword == inputType
            ? IconButton(
                icon: Icon(
                  Iconsax.eye_slash_copy,
                  size: 24,
                  color: AppTheme.lightGrey.withOpacity(0.8),
                ),
                onPressed: () {
                  // TODO: Implement password visibility toggle
                },
              )
            : null,
        labelText: label,
        labelStyle: const TextStyle(
          color: AppTheme.grey,
        ),
        hintText: labelHint,
        hintStyle: TextStyle(
          color: AppTheme.grey.withOpacity(0.4),
        ),
        filled: true,
        fillColor: AppTheme.nearlyWhite.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppTheme.grey,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          // Border color when TextFormField is enabled but not focused
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppTheme.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          // Border color when TextFormField is focused
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppTheme.grey.withOpacity(0.6),
            width: 2,
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: AppTheme.grey,
          fontSize: 18,
        ),
      ),
      keyboardType: inputType,
    );
  }
}
