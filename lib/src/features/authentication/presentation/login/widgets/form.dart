import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/client_environment_controller.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field_checkbox.dart';
import 'package:smart_fridge/src/features/authentication/presentation/login/login_controller.dart';
import 'package:smart_fridge/src/features/authentication/presentation/password_form_field.dart';
import 'package:smart_fridge/src/features/authentication/presentation/recover/pages/verification.dart';
import 'package:smart_fridge/utils/validators/validation.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../form_field.dart';
import '../../primary_button.dart';
import '../../secondary_button.dart';

class LoginForm extends StatelessWidget {
  final PageController pageController;

  const LoginForm({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLoginController());

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: [
            AppAuthFormField(
              label: "Email",
              labelHint: "gabrielgraham@gmail.com",
              inputType: TextInputType.emailAddress,
              icon: Iconsax.directbox_notif_copy,
              controller: controller.email,
              validator: (value) => AppValidators.validateEmail(value),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => AppAuthPasswordFormField(
                label: "Password",
                labelHint: "********",
                inputType: TextInputType.visiblePassword,
                icon: Iconsax.password_check_copy,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_copy
                        : Iconsax.eye_slash_copy,
                    size: 20 * Scaler.textScaleFactor(context),
                    color: AppTheme.lightGrey.withOpacity(0.8),
                  ),
                  onPressed: () {
                    controller.hidePassword.toggle();
                  },
                ),
                obscureText: controller.hidePassword.value,
                controller: controller.password,
                validator: (value) => AppValidators.validatePassword(value),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => AuthCheckbox(
                        value: controller.rememberMeConfirmed.value,
                        onChanged: (value) =>
                            controller.rememberMeConfirmed.toggle(),
                      ),
                    ),
                    Text(
                      "Remember Me",
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 12.0 * Scaler.textScaleFactor(context),
                      ),
                      textScaleFactor: Scaler.textScaleFactor(context),
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
                      fontSize: 12.0 * Scaler.textScaleFactor(context),
                    ),
                    textScaleFactor: Scaler.textScaleFactor(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            AppAuthPrimaryButton(
              text: "Login",
              onPressed: () => controller.process(),
            ),
            const SizedBox(height: 16),
            AuthSecondaryButton(
              text: "Create an account",
              onPressed: toggleAuthPage,
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

  void toggleAuthPage() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
