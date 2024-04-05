import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_fridge/commons/constants/asset.dart';
import 'package:smart_fridge/commons/constants/firebase.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/commons/widgets/network_manager.dart';
import 'package:smart_fridge/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_fridge/utils/modals/full_screen_loader.dart';

class AppLoginController extends GetxController {
  static AppLoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final hidePassword = true.obs; // Hide password by default
  final rememberMeConfirmed = true.obs; // remember me confirmed by default
  final localStorage = GetStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> process() async {
    try {
      AppFullScreenLoader.openLoadingDialog("Logging in...", AppAsset.loader);

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

      if (rememberMeConfirmed.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final credential =
          await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final uid = credential.user!.uid;
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final userData = docSnapshot.data();
      final fullName = '${userData!['firstName']} ${userData['lastName']}';

      AppFullScreenLoader.stopLoading();

      AppSnackbar.success(
        message: 'Welcome back, $fullName!',
      );

      AuthenticationRepository.instance.screenRedirect();
    } on FirebaseAuthException catch (e) {
      AppFullScreenLoader.stopLoading();

      AppSnackbar.error(
        message: AppFirebase.messageFromAuthErrorCode(e.code),
      );
    } catch (e) {
      AppFullScreenLoader.stopLoading();

      AppSnackbar.error(
        message: 'Login failed. Please try again later.',
      );
    }
  }
}
