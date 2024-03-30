import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../config/themes/app_theme.dart';

class OnboardingSwipeNextButton extends StatefulWidget {
  final int currentPageIndex;
  final VoidCallback onPressed;
  final VoidCallback onLoginPressed;

  const OnboardingSwipeNextButton({
    Key? key,
    required this.currentPageIndex,
    required this.onPressed,
    required this.onLoginPressed,
  }) : super(key: key);

  @override
  _OnboardingSwipeNextButtonState createState() =>
      _OnboardingSwipeNextButtonState();
}

class _OnboardingSwipeNextButtonState extends State<OnboardingSwipeNextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentPageIndex == 4) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(covariant OnboardingSwipeNextButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentPageIndex == 4) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    IconData adjustedIcon = widget.currentPageIndex == 4
        ? Icons.arrow_forward_rounded
        : Iconsax.arrow_right_3_copy;

    double buttonWidth = widget.currentPageIndex == 4 ? 280.0 : 50.0;
    double adjustedBottom = widget.currentPageIndex == 4 ? 120.0 : 40.0;

    return AnimatedAlign(
      duration: const Duration(milliseconds: 400),
      alignment: widget.currentPageIndex == 4
          ? Alignment.bottomCenter
          : Alignment.bottomRight,
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: buttonWidth,
        height: 50.0,
        margin: EdgeInsets.only(
          bottom: adjustedBottom,
          right: widget.currentPageIndex == 4 ? 0 : 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppTheme.darkGrey,
        ),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.currentPageIndex == 4)
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: AppTheme.nearlyWhite,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                right: widget.currentPageIndex == 4
                    ? buttonWidth * 0.08
                    : (buttonWidth - 20) / 2,
                child: Icon(
                  adjustedIcon,
                  size: 20.0,
                  color: AppTheme.nearlyWhite,
                ),
                top: 0,
                bottom: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginTextWidget(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      bottom: widget.currentPageIndex == 4 ? 90.0 : 0.0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: widget.currentPageIndex == 4 ? widget.onLoginPressed : () {},
        child: AnimatedOpacity(
          opacity: widget.currentPageIndex == 4 ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: Center(
            child: Text.rich(
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
