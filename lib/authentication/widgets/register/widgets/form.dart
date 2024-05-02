import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field_checkbox.dart';
import 'package:smart_fridge/src/features/authentication/presentation/form_field_twin.dart';
import 'package:smart_fridge/src/features/authentication/presentation/password_form_field.dart';
import 'package:smart_fridge/src/features/authentication/presentation/primary_button.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/register_controller.dart';
import 'package:smart_fridge/utils/validators/validation.dart';

class AppRegisterForm extends StatelessWidget {
  final PageController pageController;

  const AppRegisterForm({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppRegisterController());

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: <Widget>[
            AppAuthFormFieldTwin(
              firstLabel: "First Name",
              firstLabelHint: "Gabriel",
              firstIcon: Iconsax.user_edit_copy,
              firstInputType: TextInputType.name,
              firstController: controller.firstName,
              firstValidator: (value) =>
                  AppValidators.validateEmpty('First Name', value),
              secondLabel: "Last Name",
              secondLabelHint: "Graham",
              secondIcon: Iconsax.user_edit_copy,
              secondInputType: TextInputType.name,
              secondController: controller.lastName,
              secondValidator: (value) =>
                  AppValidators.validateEmpty('Last Name', value),
            ),
            const SizedBox(height: 16.0),
            AppAuthFormField(
              label: "Email",
              labelHint: "grabrielgraham@gmail.com",
              inputType: TextInputType.emailAddress,
              icon: Iconsax.directbox_notif_copy,
              controller: controller.email,
              validator: (value) => AppValidators.validateEmail(value),
            ),
            const SizedBox(height: 16.0),
            AppAuthFormField(
              label: "Contact Number",
              labelHint: "+60 12 326 1405",
              inputType: TextInputType.number,
              icon: Iconsax.call_copy,
              controller: controller.contactNumber,
              validator: (value) => AppValidators.validateContactNumber(value),
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
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                    child: Obx(
                  () => AuthCheckbox(
                    value: controller.privacyPolicyConfirmed.value,
                    onChanged: (bool? newValue) =>
                        controller.privacyPolicyConfirmed.value = newValue!,
                  ),
                )),
                const SizedBox(height: 16.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'I agree to',
                        style: TextStyle(
                          color: AppTheme.grey,
                          fontSize: 12.0 * Scaler.textScaleFactor(context),
                        ),
                      ),
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                          color: AppTheme.nearlyDarkOrange,
                          fontSize: 12.0 * Scaler.textScaleFactor(context),
                        ),
                      ),
                      TextSpan(
                        text: ' and',
                        style: TextStyle(
                          color: AppTheme.grey,
                          fontSize: 12.0 * Scaler.textScaleFactor(context),
                        ),
                      ),
                      TextSpan(
                        text: ' Terms of use',
                        style: TextStyle(
                          color: AppTheme.nearlyDarkOrange,
                          fontSize: 12.0 * Scaler.textScaleFactor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            AppAuthPrimaryButton(
              text: "Sign Up",
              onPressed: () => controller.process(),
            ),
          ],
        ),
      ),
    );
  }

  void toggleAuthPage() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
