import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../config/themes/app_theme.dart';
import '../../form_field.dart';
import '../../form_field_twin.dart';
import '../../primary_button.dart';
import '../pages/verify_email_screen.dart';

class AppRegisterForm extends StatelessWidget {
  final PageController pageController;

  const AppRegisterForm({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          children: <Widget>[
            const AppAuthFormFieldTwin(
              firstLabel: "First Name",
              firstLabelHint: "Gabriel",
              firstIcon: Iconsax.user_edit_copy,
              firstInputType: TextInputType.name,
              secondLabel: "Last Name",
              secondLabelHint: "Graham",
              secondIcon: Iconsax.user_edit_copy,
              secondInputType: TextInputType.name,
            ),
            const SizedBox(height: 16.0),
            const AppAuthFormField(
              label: "Username",
              labelHint: "gabrielgraham",
              inputType: TextInputType.name,
              icon: Iconsax.user_edit_copy,
            ),
            const SizedBox(height: 16.0),
            const AppAuthFormField(
              label: "Email",
              labelHint: "grabrielgraham@gmail.com",
              inputType: TextInputType.emailAddress,
              icon: Iconsax.directbox_notif_copy,
            ),
            const SizedBox(height: 16.0),
            const AppAuthFormField(
              label: "Contact Number",
              labelHint: "+60 12 326 1405",
              inputType: TextInputType.number,
              icon: Iconsax.call_copy,
            ),
            const SizedBox(height: 16.0),
            const AppAuthFormField(
              label: "Password",
              labelHint: "********",
              inputType: TextInputType.visiblePassword,
              icon: Iconsax.eye_slash_copy,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                SizedBox(
                  // width: 24,
                  // height: 24,
                  child: Checkbox(
                    value: true,
                    onChanged: (value) {
                      // TODO implement terms and conditions
                    },
                    activeColor: AppTheme.nearlyDarkOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'I agree to',
                        style: TextStyle(
                          color: AppTheme.grey,
                        ),
                      ),
                      TextSpan(
                        text: ' Privacy Policy',
                        style: TextStyle(
                          color: AppTheme.nearlyDarkOrange,
                        ),
                      ),
                      TextSpan(
                        text: ' and',
                        style: TextStyle(
                          color: AppTheme.grey,
                        ),
                      ),
                      TextSpan(
                        text: ' Terms of use',
                        style: TextStyle(
                          color: AppTheme.nearlyDarkOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AppAuthPrimaryButton(
                text: "Sign Up",
                onPressed: () => Get.to(
                      () => const AppVerifyEmailScreen(),
                    )),
          ],
        ),
      ),
    );
  }

  void goToLoginPage() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
