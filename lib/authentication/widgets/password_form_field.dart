import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/config/math/scaler.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthPasswordFormField extends StatelessWidget {
  final String label;
  final String labelHint;
  final TextInputType inputType;
  final IconData icon;
  final IconButton? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool expands;

  const AppAuthPasswordFormField({
    super.key,
    required this.label,
    required this.labelHint,
    required this.inputType,
    required this.icon,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    required this.validator,
    this.expands = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      expands: expands,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 20 * Scaler.textScaleFactor(context),
        ),
        suffixIcon: suffixIcon ?? null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: AppTheme.grey,
          fontSize: 14 * Scaler.textScaleFactor(context),
        ),
        hintText: labelHint,
        hintStyle: TextStyle(
          color: AppTheme.grey.withOpacity(0.4),
          fontSize: 14 * Scaler.textScaleFactor(context),
        ),
        filled: true,
        fillColor: AppTheme.nearlyWhite.withOpacity(0.3),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16 * Scaler.paddingVerticalScaleFactor(context),
          horizontal: 16 * Scaler.paddingHorizontalScaleFactor(context),
        ),
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
        floatingLabelStyle: TextStyle(
          color: AppTheme.grey,
          fontSize: 14 * Scaler.textScaleFactor(context),
        ),
      ),
      keyboardType: inputType,
    );
  }
}
