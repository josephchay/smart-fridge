import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.image,
    this.onPressed,
  });

  final String image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.lighterGrey.withOpacity(0.4),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: IconButton(
        onPressed: () => onPressed?.call(),
        icon: Image(
          width: 40,
          height: 40,
          image: AssetImage(image),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
