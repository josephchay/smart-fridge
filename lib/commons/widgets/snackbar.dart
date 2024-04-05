import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For Get.context
import 'package:smart_fridge/src/config/math/scaler.dart';
import 'package:smart_fridge/src/config/themes/app_theme.dart';

class AppSnackbar {
  static void _showSnackbar({
    required String message,
    required Color themeColor,
    required IconData icon,
    int duration = 3,
  }) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: themeColor.withOpacity(.6),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: themeColor.withOpacity(.6),
                  size: 24 * Scaler.textScaleFactor(Get.context!),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: AppTheme.nearlyBlack,
                      fontSize: 14 * Scaler.textScaleFactor(Get.context!),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar(),
                  child: Text(
                    "DISMISS",
                    style: TextStyle(
                      color: AppTheme.nearlyBlack.withOpacity(.4),
                      fontSize: 14 * Scaler.textScaleFactor(Get.context!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  static void info({String message = '', int duration = 3}) {
    _showSnackbar(
      message: message,
      themeColor: AppTheme.grey,
      icon: Icons.info,
      duration: duration,
    );
  }

  static void success({String message = '', int duration = 3}) {
    _showSnackbar(
      message: message,
      themeColor: AppTheme.nearlyGreen,
      icon: Icons.check_circle,
      duration: duration,
    );
  }

  static void warning({String message = '', int duration = 3}) {
    _showSnackbar(
      message: message,
      themeColor: AppTheme.nearlyOrange,
      icon: Icons.warning,
      duration: duration,
    );
  }

  static void error({String message = '', int duration = 3}) {
    _showSnackbar(
      message: message,
      themeColor: AppTheme.nearlyRed,
      icon: Icons.error,
      duration: duration,
    );
  }
}
