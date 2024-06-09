import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/post/post_repository.dart';

import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pick_image.dart';
import 'package:pinkaid/utils/utils.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find();
  var commentLen = 0.obs;
  var isLikeAnimating = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  // RxList<Post> posts = <Post>[].obs;
  RxList<Post> posts = <Post>[].obs;
  RxList<Post> homePost = <Post>[].obs;
  final _categoryId = ''.obs;
  RxBool tabStatus = false.obs;

  String get categoryId => _categoryId.value;
  set categoryId(String value) => _categoryId.value = value;

  final UserRepository _userRepository = UserRepository();
  final PostRepository _postRepository = PostRepository();

  @override
  void onInit() {
    fetchAllPosts();
    fetchUserRecord();
    super.onInit();

    ever(_categoryId, (_) {
      fetchPosts(_categoryId.value);
    });
  }

  Future<List<Post>> fetchPosts(String categoryId) async {
    try {
      isLoading.value = false;
      final postList = await _postRepository.getPosts(categoryId);
      posts.assignAll(postList);
      return postList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Post>> fetchAllPosts() async {
    try {
      isLoading.value = true;
      final postList = await _postRepository.getAllPosts();
      homePost.assignAll(postList);
      return postList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final user = await _userRepository.getUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isLoading.value = false;
    }
  }

  void deletePost(String postId) async {
    try {
      isLoading.value = true;
      await _postRepository.deletePost(postId);
    } catch (err) {
      KLoaders.errorSnackBar(title: err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);
  final caption = TextEditingController();
  final title = TextEditingController();
  final userRepository = Get.put(UserRepository());

  Future<void> selectImage() async {
    final image = await ImagePickerDialog.showImageSourceDialog(Get.context!);

    if (image != null) {
      selectedImage.value = await image.readAsBytes();
    }
  }

  Future<void> postData(
    String title,
    String description,
    Uint8List? file,
  ) async {
    try {
      isLoading.value = true;
      KFullScreenLoaders.openLoadingDialog(
          'We are processing your information', KImages.bufferAnimation);
      String? photoUrl;
      if (file != null) {
        photoUrl =
            await userRepository.uploadImageToStorage('Posts', file, true);
      }
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
        postUrl: photoUrl ?? '',
        profImage: user.profilePicture,
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
      isLoading.value = false;
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
