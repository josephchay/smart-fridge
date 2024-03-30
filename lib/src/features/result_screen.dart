import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../config/themes/app_theme.dart';
import 'authentication/presentation/primary_button.dart';

class AppResultScreen extends StatelessWidget {
  const AppResultScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 64.0, 24.0, 24.0) * 2,
              child: Column(
                children: [
                  Lottie.asset(
                    image,
                    repeat: false,
                  ),
                  const SizedBox(height: 100.0),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.darkerText,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    subTitle,
                    style: AppTheme.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
                  SizedBox(
                    width: double.infinity,
                    child: AppAuthPrimaryButton(
                      text: 'Continue',
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
