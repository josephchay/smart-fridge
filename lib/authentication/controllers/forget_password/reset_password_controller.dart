import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/constants/asset.dart';
import 'package:smart_fridge/commons/widgets/network_manager.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_fridge/src/features/authentication/presentation/recover/pages/reset_password.dart';
import 'package:smart_fridge/utils/modals/full_screen_loader.dart';

class AppResetPasswordController extends GetxController {
  static AppResetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void sendEmail() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "Sending email...", AppAsset.loader);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!formKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(
        email.text.trim(),
      );

      AppFullScreenLoader.stopLoading();

      Get.to(() => AppResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackbar.error(
        message: 'An error occurred! Please try again later.',
      );
    }
  }

  void resendEmail(String email) async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "Sending email...", AppAsset.loader);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      AppFullScreenLoader.stopLoading();

      AppSnackbar.success(
        message: 'Password reset email sent successfully!',
      );
    } catch (e) {
      AppFullScreenLoader.stopLoading();
      AppSnackbar.error(
        message: 'An error occurred! Please try again later.',
      );
    }
  }
}
