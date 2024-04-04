import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:smart_fridge/commons/widgets/animation_loader.dart';

class AppFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible:
          false, // set to false to prevent user from dismissing the dialog by tapping outside
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            AppAnimationLoaderWidget(
              text: text,
              animation: animation,
            ),
          ],
        ),
      ),
    );
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
