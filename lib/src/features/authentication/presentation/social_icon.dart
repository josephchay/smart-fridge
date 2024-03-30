import 'package:flutter/material.dart';

import '../../../config/themes/app_theme.dart';

class AppAuthSocialIcon extends StatelessWidget {
  const AppAuthSocialIcon({
    super.key,
    required this.image,
  });

  final String image;

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
        onPressed: () {
          // TODO Implement sign in with google functionality
        },
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
