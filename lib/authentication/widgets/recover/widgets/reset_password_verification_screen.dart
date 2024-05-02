import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/utils/formatters/color.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/controllers/forget_password/reset_password_controller.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field.dart';
import 'package:smart_fridge/src/features/authentication/presentation/primary_button.dart';
import 'package:smart_fridge/utils/validators/validation.dart';

class AppResetPasswordEmailVerificationScreen extends StatefulWidget {
  const AppResetPasswordEmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<AppResetPasswordEmailVerificationScreen> createState() =>
      _AppResetPasswordEmailVerificationScreenState();
}

class _AppResetPasswordEmailVerificationScreenState
    extends State<AppResetPasswordEmailVerificationScreen>
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
    final controller = Get.put(AppResetPasswordController());

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
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/images/auth/search.json",
                          ),
                          const SizedBox(height: 90.0),
                          const Text(
                            'Confirm Your Identity',
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
                              'On the road to recovery! Securely verify your identify and start fresh with a new password.',
                              style: AppTheme.subtitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppAuthFormField(
                            label: "Email",
                            labelHint: "gabrielgraham@gmail.com",
                            inputType: TextInputType.emailAddress,
                            icon: Iconsax.directbox_notif_copy,
                            controller: controller.email,
                            validator: AppValidators.validateEmail,
                          ),
                          const SizedBox(height: 24),
                          AppAuthPrimaryButton(
                            text: 'Continue',
                            onPressed: controller.sendEmail,
                          ),
                        ],
                      ),
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
