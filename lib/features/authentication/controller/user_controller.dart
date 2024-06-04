import 'package:get/get.dart';

import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/data/repositories/categories/categories_repository.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/utils/helpers/dummydata.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pickImage.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final authRepository = AuthRepository.instance;
  final categoryRepository = Get.put(CategoryRepository());
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

  uploadProfilePicture() async {
    try {
      final image = await ImagePickerDialog.showImageSourceDialog(Get.context!);
      if (image != null) {
        imageLoading.value = true;
        final imageUrl =
            await userRepository.uploadImage("Users/Images/Profile/", image);

        Map<String, dynamic> json = {'profilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        KLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Your profile image has been updated');
      }
    } catch (e) {
      KLoaders.errorSnackBar(title: 'OhSnap', message: 'Somthing went wrong');
    }
  }

  uploadCategoryData() async {
    await categoryRepository.uploadDummyData(KDummyData.categories);
  }

  uploadPostsData() async {
    await categoryRepository.uploadPostData(KDummyData.posts);
  }
}
