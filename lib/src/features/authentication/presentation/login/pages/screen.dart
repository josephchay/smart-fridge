import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_fridge/core/util/color.dart';

import '../../divider.dart';
import '../../social_buttons.dart';
import '../widgets/form.dart';
import '../widgets/header.dart';

class AppLoginScreen extends StatelessWidget {
  final PageController pageController;
  final Animation<double> animation;

  const AppLoginScreen({
    super.key,
    required this.pageController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final dark = ColorHelper.isDarkMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            width: 460,
            right: -100,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
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
              transform: Matrix4.rotationY(pi),
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 56.0,
                bottom: 24.0,
                left: 24.0,
                right: 24.0,
              ),
              child: Column(
                children: [
                  const AppLoginHeader(),
                  AppLoginForm(
                    pageController: pageController,
                  ),
                  const AppAuthDivider(
                    text: "OR SIGN IN WITH",
                  ),
                  const SizedBox(height: 16),
                  const AppAuthSocialButtons(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
