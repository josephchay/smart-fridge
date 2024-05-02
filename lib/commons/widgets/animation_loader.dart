import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_fridge/config/math/scaler.dart';
import 'package:smart_fridge/config/themes/app_theme.dart';

class AppAnimationLoaderWidget extends StatelessWidget {
  final String text;
  final String animation;
  final bool showAction;
  final VoidCallback? onAction;

  const AppAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          const SizedBox(height: 200),
          showAction
              ? SizedBox(
                  width: 260,
                  child: OutlinedButton(
                    onPressed: onAction,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppTheme.nearlyOrange,
                    ),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: AppTheme.lightText,
                          ),
                      textScaleFactor: Scaler.textScaleFactor(context),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
