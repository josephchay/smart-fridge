import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppOnboardSwipePreviousButton extends StatefulWidget {
  final Function() onPressed;
  final int currentPageIndex;

  const AppOnboardSwipePreviousButton({
    super.key,
    required this.onPressed,
    required this.currentPageIndex,
  });

  @override
  _AppOnboardSwipePreviousButtonState createState() =>
      _AppOnboardSwipePreviousButtonState();
}

class _AppOnboardSwipePreviousButtonState
    extends State<AppOnboardSwipePreviousButton> {
  // Alignment for the beginning and end points
  Alignment beginAlignment = Alignment.bottomLeft;
  Alignment endAlignment = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    double adjustedBottom = widget.currentPageIndex == 4 ? 30.0 : 45.0;

    // Determine the correct alignment based on currentPageIndex
    Alignment targetAlignment =
        widget.currentPageIndex == 4 ? endAlignment : beginAlignment;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      alignment: targetAlignment,
      padding: EdgeInsets.only(bottom: adjustedBottom),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0), // Adjust padding if necessary
          shape: CircleBorder(),
        ),
        child: Icon(
          Iconsax.arrow_left_2_copy,
          size: 20.0,
          weight: 10,
          color: AppTheme.nearlyBlack,
        ),
      ),
    );
  }
}
