import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/themes/app_theme.dart';

class AppOnboardSwipePreviousButton extends StatelessWidget {
  const AppOnboardSwipePreviousButton({
    super.key,
    required this.onPressed,
    required this.currentPageIndex,
  });

  final Function() onPressed;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      bottom: 40.0,
      left: 20.0,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: const Icon(
            Iconsax.arrow_left_2_copy,
            size: 20.0,
            weight: 600,
            color: AppTheme.nearlyBlack,
          ),
        ),
      ),
    );
  }
}
