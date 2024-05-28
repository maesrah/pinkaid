import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/screen/registration/userModel.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final authRepository = AuthRepository.instance;

  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.getUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  signOut() {
    authRepository.signOut();
  }

  // Future<void> saveUserRecord(
  //     UserCredential? userCredential, UserRole role) async {
  //   try {
  //     if (userCredential != null) {
  //       final user = UserModel(
  //           id: userCredential.user!.uid,
  //           fullName: userCredential.user!.displayName ?? '',
  //           phoneNumber: userCredential.user!.phoneNumber ?? '',
  //           role: role);

  //       await userRepository.saveUserRecord(user);
  //     }
  //   } catch (e) {
  //     print('Failed to save user record: $e');
  //   }
  // }
}
