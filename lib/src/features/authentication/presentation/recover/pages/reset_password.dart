import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/src/features/authentication/presentation/screen.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../primary_button.dart';
import '../../tertiary_button.dart';

class AppResetPasswordScreen extends StatefulWidget {
  const AppResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<AppResetPasswordScreen> createState() => _AppResetPasswordScreenState();
}

class _AppResetPasswordScreenState extends State<AppResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 180.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: 400,
            right: -40,
            bottom: -30,
            child: Image.asset(
              "assets/images/miscellaneous/orange-pink-gradient-blob.png",
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _animation.value,
                    sigmaY: _animation.value,
                  ),
                  child: const SizedBox(),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top - 32,
            left: 10.0,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(
                  Iconsax.arrow_left_copy,
                  size: 24.0,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/images/auth/lock.json",
                        ),
                        const Text(
                          'Reset Your Password',
                          style: TextStyle(
                            color: AppTheme.darkerText,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(
                          width: 300.0,
                          child: Text(
                            'Your ticket to a hassle-free password reset has just landed in your inbox. Open up and securely reset your password!',
                            style: AppTheme.subtitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppAuthPrimaryButton(
                          text: 'Login to Account',
                          onPressed: () => Get.offAll(() => const AppAuthScreen(
                                isLogin: true,
                              )),
                        ),
                        const SizedBox(height: 24.0),
                        AppAuthTertiaryButton(
                          text: 'Resend Email',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
