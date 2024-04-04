import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/constants/asset.dart';
import 'package:smart_fridge/commons/constants/firebase.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/commons/widgets/network_manager.dart';
import 'package:smart_fridge/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_fridge/data/repositories/user/user_repository.dart';
import 'package:smart_fridge/src/features/authentication/models/user_model.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/pages/verify_email_screen.dart';
import 'package:smart_fridge/utils/modals/full_screen_loader.dart';

class AppRegisterController extends GetxController {
  static AppRegisterController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final contactNumber = TextEditingController();
  final password = TextEditingController();

  final hidePassword = true.obs; // Hide password by default
  final privacyPolicyConfirmed =
      false.obs; // Privacy policy not confirmed by default

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> process() async {
    try {
      AppFullScreenLoader.openLoadingDialog("Registering...", AppAsset.loader);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        AppFullScreenLoader.stopLoading();
        return;
      }

      if (!privacyPolicyConfirmed.value) {
        AppFullScreenLoader.stopLoading();
        AppSnackbar.warning(
          message: 'Please confirm the privacy policy to continue.',
        );
        return;
      }

      final credential =
          await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final newUser = UserModel(
        id: credential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        contactNumber: contactNumber.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.save(newUser);

      AppFullScreenLoader.stopLoading();

      AppSnackbar.success(
        message:
            'Registration successful. Please verify your email to continue.',
      );

      Get.to(
        () => AppVerifyEmailScreen(
          email: email.text.trim(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      AppFullScreenLoader.stopLoading();

      AppSnackbar.error(
        message: AppFirebase.messageFromAuthErrorCode(e.code),
      );
    } catch (e) {
      AppFullScreenLoader.stopLoading();

      AppSnackbar.error(
        message: 'An error occurred while registering. Please try again later.',
      );
    }
  }

  Future<void> verifyEmail() async {
    try {
      // Login user
    } catch (e) {
      // Handle error
    } finally {
      // Clean up
    }
  }
}
