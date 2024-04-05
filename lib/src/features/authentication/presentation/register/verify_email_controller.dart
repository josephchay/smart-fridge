import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_fridge/src/features/email_verified_screen.dart';

class AppVerifyEmailController extends GetxController {
  static AppVerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    process();
    super.onInit();
  }

  void process() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      AppSnackbar.error(
        message: e.toString(),
      );
    }
  }

  void checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        Get.off(() => AppEmailVerifiedScreen(
              image: 'assets/images/miscellaneous/tick.json',
              title: 'Account Created Successfully!',
              subTitle:
                  'Start tracking your grocery inventory in real-time, get alerts on item durations, and even enjoy automated shopping list creation based on your consumption patterns!',
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ));
      } else {
        AppSnackbar.warning(
          message: 'Please verify your email address to continue.',
        );
      }
    } else {
      AppSnackbar.warning(message: 'Please register to continue.');
    }
  }
}
