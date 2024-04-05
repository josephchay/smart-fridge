import 'package:flutter/cupertino.dart';

import 'social_icon.dart';

class AppAuthSocialButtons extends StatelessWidget {
  const AppAuthSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthSocialIcon(
          image: "assets/images/logos/google.png",
        ),
        SizedBox(width: 20),
        AuthSocialIcon(
          image: "assets/images/logos/facebook.png",
        ),
      ],
    );
  }
}
