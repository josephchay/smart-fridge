import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/client_environment_controller.dart';
import 'package:smart_fridge/src/features/authentication/presentation/recover/pages/verification.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../form_field.dart';
import '../../primary_button.dart';
import '../../secondary_button.dart';

class AppLoginForm extends StatelessWidget {
  final PageController pageController;

  const AppLoginForm({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            const AppAuthFormField(
              label: "Email",
              labelHint: "gabrielgraham@gmail.com",
              inputType: TextInputType.emailAddress,
              icon: Iconsax.directbox_notif_copy,
            ),
            const SizedBox(height: 16.0),
            const AppAuthFormField(
              label: "Password",
              labelHint: "********",
              inputType: TextInputType.visiblePassword,
              icon: Iconsax.password_check_copy,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (bool? newValue) {
                        // TODO: Implement remember me functionality
                      },
                      activeColor: AppTheme.nearlyDarkOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const Text(
                      "Remember Me",
                      style: TextStyle(
                        color: AppTheme.grey,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () =>
                      Get.to(() => const AppRecoverVerificationScreen()),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    disabledForegroundColor:
                        Colors.transparent.withOpacity(0.1),
                  ),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: AppTheme.lightGrey.withOpacity(0.6),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppAuthPrimaryButton(
              text: "Login",
              onPressed: () =>
                  Get.to(() => const AppClientEnvironmentController()),
            ),
            const SizedBox(height: 16),
            AppAuthSecondaryButton(
              text: "Create an account",
              onPressed: goToRegisterPage,
              // onPressed: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => const AppRegisterScreen(),
              //     ),
              //   );
              // },
            ),
          ],
        ),
      ),
    );
  }

  void goToRegisterPage() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
