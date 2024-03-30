import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/presentation/primary_button.dart';
import 'package:smart_fridge/src/features/authentication/presentation/screen.dart';
import 'package:smart_fridge/src/features/authentication/presentation/tertiary_button.dart';
import 'package:smart_fridge/src/features/success_screen.dart';

import '../../../../../../core/util/color.dart';

class AppVerifyEmailScreen extends StatefulWidget {
  const AppVerifyEmailScreen({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.only(
                      top: 60.0,
                      bottom: 24.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    child: Column(
                      children: [
                        Lottie.asset(
                          "assets/images/auth/registration/email-notification.json",
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
                        const Text(
                          'support@joseph.com',
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
                            onPressed: () => Get.to(
                              () => AppSuccessToastScreen(
                                image: 'assets/images/miscellaneous/tick.json',
                                title: 'Account Created Successfully!',
                                subTitle:
                                    'Start tracking your grocery inventory in real-time, get alerts on expiry dates, and even enjoy automated shopping list creation based on your consumption patterns!',
                                onPressed: () => Get.to(
                                    () => const AppAuthScreen(isLogin: true)),
                              ),
                            ),
                          ),
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
