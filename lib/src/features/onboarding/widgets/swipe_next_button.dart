import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/themes/app_theme.dart';

class AppOnboardSwipeNextButton extends StatelessWidget {
  const AppOnboardSwipeNextButton({
    super.key,
    required this.currentPageIndex,
    required this.onSignupPressed,
    required this.onLoginPressed,
  });

  final int currentPageIndex;
  final VoidCallback onSignupPressed;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildSwipeAndSignUpWidget(context),
        buildLoginTextWidget(context),
      ],
    );
  }

  Widget buildSwipeAndSignUpWidget(BuildContext context) {
    const double padding = 15.0;
    const double initialRight = 20.0;

    double buttonWidth = currentPageIndex == 4 ? 280.0 : 50.0;

    double adjustedBottom = currentPageIndex == 4 ? 110.0 : 40.0;

    double adjustedRight = currentPageIndex == 4
        ? (MediaQuery.of(context).size.width - buttonWidth) / 2 - initialRight
        : initialRight;

    BorderRadius adjustedBorderRadius = currentPageIndex == 4
        ? const BorderRadius.all(Radius.circular(14.0))
        : const BorderRadius.all(Radius.circular(18.0));

    IconData adjustedIcon = currentPageIndex == 4
        ? Icons.arrow_forward_rounded
        : Iconsax.arrow_right_3_copy;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      bottom: adjustedBottom,
      right: adjustedRight,
      child: TextButton(
        onPressed: onSignupPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          width: buttonWidth,
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: adjustedBorderRadius,
            color: AppTheme.darkGrey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (currentPageIndex == 4)
                const Text(
                  'Get Started',
                  style: TextStyle(
                    color: AppTheme.nearlyWhite,
                    fontSize: 15.0,
                  ),
                ),
              const Spacer(),
              Icon(
                adjustedIcon,
                size: 20.0,
                color: AppTheme.nearlyWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginTextWidget(BuildContext context) {
    double adjustedBottom = currentPageIndex == 4 ? 90.0 : 0.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      bottom: adjustedBottom,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: currentPageIndex == 4 ? onLoginPressed : null,
          child: AnimatedOpacity(
            opacity: currentPageIndex == 4 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: const Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: AppTheme.grey,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: AppTheme.darkGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
