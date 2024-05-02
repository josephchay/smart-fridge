import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smart_fridge/utils/formatters/color.dart';
import 'package:smart_fridge/src/features/authentication/presentation/divider.dart';
import 'package:smart_fridge/src/features/authentication/presentation/login/widgets/form.dart';
import 'package:smart_fridge/src/features/authentication/presentation/login/widgets/header.dart';
import 'package:smart_fridge/src/features/authentication/presentation/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  final PageController pageController;
  final Animation<double> animation;

  const LoginScreen({
    super.key,
    required this.pageController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ColorHelper.isDarkMode(context);

    return Stack(
      children: [
        Positioned(
          width: 460,
          right: -100,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
                'assets/images/miscellaneous/yellow-orange-gradient-blob.png'),
          ),
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
          right: 280,
          bottom: -40,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset(
                'assets/images/miscellaneous/pink-purple-gradient-blob.png'),
          ),
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
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40.0,
                bottom: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: [
                  const AppLoginHeader(),
                  LoginForm(
                    pageController: pageController,
                  ),
                  const AuthDivider(
                    text: "OR SIGN IN WITH",
                  ),
                  const SizedBox(height: 16),
                  const AppAuthSocialButtons(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
