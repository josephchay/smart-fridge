import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/presentation/divider.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/widgets/form.dart';
import 'package:smart_fridge/src/features/authentication/presentation/social_buttons.dart';

class RegisterScreen extends StatelessWidget {
  final PageController pageController;
  final Animation<double> animation;

  const RegisterScreen({
    super.key,
    required this.pageController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                Text(
                  'Unleash the Power',
                  style: AppTheme.display2,
                  textScaleFactor: Scaler.textScaleFactor(context),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 300.0,
                  child: Text(
                    "Enroll your refrigerator into the choir of unanticipated capabilities.",
                    style: AppTheme.subtitle,
                    textAlign: TextAlign.center,
                    textScaleFactor: Scaler.textScaleFactor(context),
                  ),
                ),
                AppRegisterForm(
                  pageController: pageController,
                ),
                AuthDivider(
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
    );
  }
}
