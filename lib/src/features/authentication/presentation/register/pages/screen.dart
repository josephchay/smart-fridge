import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../divider.dart';
import '../../social_buttons.dart';
import '../widgets/form.dart';

class AppRegisterScreen extends StatelessWidget {
  final PageController pageController;
  final Animation<double> animation;

  const AppRegisterScreen({
    super.key,
    required this.pageController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            width: 460,
            left: -100,
            child: Image.asset(
                'assets/images/miscellaneous/yellow-orange-gradient-blob.png'),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: animation.value,
                    sigmaY: animation.value,
                  ),
                  child: const SizedBox(),
                ),
              );
            },
          ),
          Positioned(
            width: 200,
            left: 280,
            bottom: -40,
            child: Image.asset(
                'assets/images/miscellaneous/pink-purple-gradient-blob.png'),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: animation.value,
                    sigmaY: animation.value,
                  ),
                  child: const SizedBox(),
                ),
              );
            },
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80.0,
                bottom: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Unleash the Power',
                    style: AppTheme.display2,
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(
                    width: 300.0,
                    child: Text(
                      "Enroll your refrigerator into the choir of unanticipated capabilities.",
                      style: AppTheme.subtitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppRegisterForm(
                    pageController: pageController,
                  ),
                  AppAuthDivider(
                    text: "OR SIGN UP WITH",
                  ),
                  SizedBox(height: 16),
                  AppAuthSocialButtons(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
