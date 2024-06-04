import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/postModel.dart';
import 'package:pinkaid/features/patientsFeatures/screen/discussion_screen.dart';
import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pickImage.dart';
import 'package:pinkaid/utils/utils.dart';
import 'package:uuid/uuid.dart';

class AddPostController extends GetxController {
  static AddPostController get instance => Get.find();

  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);
  final caption = TextEditingController();
  final title = TextEditingController();
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  Future<void> selectImage() async {
    final image = await ImagePickerDialog.showImageSourceDialog(Get.context!);

    if (image != null) {
      selectedImage.value = await image.readAsBytes();
    }
  }

  Future<void> postData(
    String title,
    String description,
    Uint8List file,
  ) async {
    try {
      KFullScreenLoaders.openLoadingDialog(
          'We are processing your information', KImages.bufferAnimation);
      String photoUrl =
          await userRepository.uploadImageToStorage('Posts', file, true);
      final user = await userRepository.getUserDetails();
      this.user(user);

      String postId = const Uuid().v1();

      Post post = Post(
        title: title,
        caption: description,
        id: user.id,
        fullName: user.fullName,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: user.profilePicture,
        likes: [],
        categoryId: '1',
      );

      userRepository.uploadPost(postId, post);
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Something went wrong');
    } finally {
      KFullScreenLoaders.stopLoading();
      KLoaders.successSnackBar(
          title: 'Success', message: 'Your post succesfully posted!');
      clearImage();
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
