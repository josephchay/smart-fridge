import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_fridge/commons/widgets/snackbar.dart';
import 'package:smart_fridge/data/repositories/user/user_repository.dart';
import 'package:smart_fridge/src/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  Future<void> save(UserCredential? credentials) async {
    try {
      if (credentials != null) {
        final nameParts =
            UserModel.nameParts(credentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(credentials.user!.displayName ?? '');

        final user = UserModel(
          id: credentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          email: credentials.user!.email ?? '',
          contactNumber: credentials.user!.phoneNumber ?? '',
        );

        // Save user data
        await userRepository.save(user);
      }
    } catch (e) {
      AppSnackbar.warning(
        message: 'An error occurred! Please try again later.',
      );
    }
  }
}
