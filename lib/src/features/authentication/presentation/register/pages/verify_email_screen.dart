import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/core/util/color.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/presentation/primary_button.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/verify_email_controller.dart';
import 'package:smart_fridge/src/features/authentication/presentation/screen.dart';
import 'package:smart_fridge/src/features/authentication/presentation/tertiary_button.dart';
import 'package:smart_fridge/src/features/email_verified_screen.dart';

class AppVerifyEmailScreen extends StatefulWidget {
  final String? email;

  const AppVerifyEmailScreen({
    super.key,
    this.email,
  });

  @override
  State<AppVerifyEmailScreen> createState() => _AppVerifyEmailScreenState();
}

class _AppVerifyEmailScreenState extends State<AppVerifyEmailScreen>
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ColorHelper.isDarkMode(context);
    final controller = Get.put(AppVerifyEmailController());

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: 200,
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
            top: MediaQuery.of(context).padding.top * 0.1,
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
                    padding: const EdgeInsets.only(
                      top: 60.0,
                      bottom: 24.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/images/auth/email-notification.json",
                        ),
                        const SizedBox(height: 32.0),
                        const Text(
                          'Verify your Email Address',
                          style: TextStyle(
                            color: AppTheme.darkerText,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          widget.email ?? '',
                          style: TextStyle(
                            color: AppTheme.lightGrey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        const SizedBox(
                          width: 300.0,
                          child: Text(
                            'A verification email has been sent to your email address. Authorize it and begin the journey of your smarter fridge!',
                            style: AppTheme.subtitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        SizedBox(
                          width: double.infinity,
                          child: AppAuthPrimaryButton(
                            text: 'Continue',
                            onPressed: () =>
                                controller.checkEmailVerificationStatus(),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        AuthTertiaryButton(
                          text: 'Resend Email',
                          onPressed: () => controller.process(),
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
