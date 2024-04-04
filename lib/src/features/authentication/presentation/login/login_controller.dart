import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/constants/asset.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/commons/widgets/network_manager.dart';
import 'package:smart_fridge/utils/modals/full_screen_loader.dart';

class AppLoginController extends GetxController {
  static AppLoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final hidePassword = true.obs; // Hide password by default
  final rememberMeConfirmed =
      false.obs; // Privacy policy not confirmed by default

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> register() async {
    try {
      AppFullScreenLoader.openLoadingDialog("Logging in...", AppAsset.loader);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        return;
      }
    } catch (e) {
      AppSnackbar.error(
        message: 'An error occurred while logging in. Please try again later.',
      );
    } finally {
      AppFullScreenLoader.stopLoading();
    }
  }
}
