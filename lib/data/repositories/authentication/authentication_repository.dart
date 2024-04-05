import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_fridge/client_environment_controller.dart';
import 'package:smart_fridge/commons/constants/firebase.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/src/features/authentication/presentation/register/pages/verify_email_screen.dart';
import 'package:smart_fridge/src/features/authentication/presentation/screen.dart';
import 'package:smart_fridge/src/features/onboarding/pages/onboarding_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const AppClientEnvironmentController());
      } else {
        Get.offAll(() => AppVerifyEmailScreen(email: _auth.currentUser!.email));

        AppSnackbar.error(
          message: 'Please verify your email address to continue.',
        );
      }
    } else {
      // Local Storage
      localStorage.writeIfNull('IsFirstTime', true);
      localStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const AuthScreen(isLogin: true))
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(
        message: AppFirebase.messageFromAuthErrorCode(e.code),
      );
    } on FirebaseException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } on FormatException catch (_) {
      AppSnackbar.error(
        message:
            'There was an error while processing your request. Please try again later.',
      );
    } on PlatformException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } catch (e) {
      AppSnackbar.error(
        message: 'An error occurred! Please try again later.',
      );
    }

    throw Exception('An error occurred! Please try again later.');
  }

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(
        message: AppFirebase.messageFromAuthErrorCode(e.code),
      );
    } on FirebaseException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } on FormatException catch (_) {
      AppSnackbar.error(
        message:
            'There was an error while processing your request. Please try again later.',
      );
    } on PlatformException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } catch (e) {
      AppSnackbar.error(
        message: 'An error occurred! Please try again later.',
      );
    }

    throw Exception('An error occurred! Please try again later.');
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      await user!.sendEmailVerification();

      AppSnackbar.success(
        message: 'Email verification sent!',
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when sending an email verification! Please try again later.',
      );
    } on FirebaseException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when sending an email verification! Please try again later.',
      );
    } on FormatException catch (_) {
      AppSnackbar.error(
        message:
            'There was an error while processing your request. Please try again later.',
      );
    } on PlatformException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when sending an email verification! Please try again later.',
      );
    } catch (e) {
      AppSnackbar.error(
        message:
            'An error occurred when sending an email verification! Please try again later.',
      );
    }
  }

  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      Get.offAll(() => const AuthScreen(isLogin: true));
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when logging out! Please try again later.',
      );
    } on FirebaseException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when logging out! Please try again later.',
      );
    } on FormatException catch (_) {
      AppSnackbar.error(
        message:
            'There was an error while processing your request. Please try again later.',
      );
    } on PlatformException catch (e) {
      AppSnackbar.error(
        message: e.message ??
            'An error occurred when logging out! Please try again later.',
      );
    } catch (e) {
      AppSnackbar.error(
        message: 'An error occurred when logging out! Please try again later.',
      );
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Trigger the auth flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Return userCredential after sign in
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      AppSnackbar.error(
        message: AppFirebase.messageFromAuthErrorCode(e.code),
      );
    } on FirebaseException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } on FormatException catch (_) {
      AppSnackbar.error(
        message:
            'There was an error while processing your request. Please try again later.',
      );
    } on PlatformException catch (e) {
      AppSnackbar.error(
        message: e.message ?? 'An error occurred! Please try again later.',
      );
    } catch (e) {
      AppSnackbar.error(
        message: 'An error occurred! Please try again later.',
      );
      return null;
    }
  }
}
