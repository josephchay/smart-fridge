import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field.dart';
import 'package:smart_fridge/src/features/authentication/presentation/primary_button.dart';
import 'package:smart_fridge/src/features/authentication/presentation/recover/pages/reset_password.dart';

import '../../../../../../core/util/color.dart';
import '../../../../../config/themes/app_theme.dart';

class AppRecoverVerificationScreen extends StatefulWidget {
  const AppRecoverVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AppRecoverVerificationScreen> createState() =>
      _AppRecoverVerificationScreenState();
}

class _AppRecoverVerificationScreenState
    extends State<AppRecoverVerificationScreen>
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
    final dark = ColorHelper.isDarkMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/images/auth/login/search.json",
                        ),
                        const SizedBox(height: 90.0),
                        const Text(
                          'Verify Your Identity',
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
                            'On the Road to Recovery! Securely Verify Your Identity and Start Fresh with a New Password.',
                            style: AppTheme.subtitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const AppAuthFormField(
                          label: "Email",
                          labelHint: "gabrielgraham@gmail.com",
                          inputType: TextInputType.emailAddress,
                          icon: Iconsax.directbox_notif_copy,
                        ),
                        const SizedBox(height: 24),
                        AppAuthPrimaryButton(
                          text: 'Recover Password',
                          onPressed: () =>
                              Get.offAll(() => const AppResetPasswordScreen()),
                        ),
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
