import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> save(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
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
    } finally {
      // AppFullScreenLoader.stopLoading();
    }
  }
}
