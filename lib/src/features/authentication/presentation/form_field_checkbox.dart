import 'package:flutter/material.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AuthCheckbox extends StatelessWidget {
  const AuthCheckbox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      // width: 24,
      // height: 24,
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.nearlyDarkOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
