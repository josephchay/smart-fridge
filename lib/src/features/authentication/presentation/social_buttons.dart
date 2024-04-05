import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:smart_fridge/src/features/authentication/presentation/login/login_controller.dart';

import 'social_button.dart';

class AppAuthSocialButtons extends StatelessWidget {
  const AppAuthSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppLoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthSocialButton(
          image: "assets/images/logos/google.png",
          onPressed: () => controller.processWithGoogle(),
        ),
        SizedBox(width: 20),
        AuthSocialButton(
          image: "assets/images/logos/facebook.png",
        ),
      ],
    );
  }
}
