import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/api.dart';
import 'package:pinkaid/data/repositories/doctor/doctor_repository.dart';
import 'package:pinkaid/data/repositories/post/post_repository.dart';

import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pick_image.dart';
import 'package:pinkaid/utils/utils.dart';
import 'package:uuid/uuid.dart';

class DoctorController extends GetxController {
  static DoctorController get instance => Get.find();
  var commentLen = 0.obs;
  var isLikeAnimating = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  // RxList<Post> posts = <Post>[].obs;
  RxList<Doctor> doctorsList = <Doctor>[].obs;
 
  final _categoryId = ''.obs;
  RxBool tabStatus = false.obs;

  String get categoryId => _categoryId.value;
  set categoryId(String value) => _categoryId.value = value;

  final UserRepository _userRepository = UserRepository();
  final DoctorRepository _doctorRepository = DoctorRepository();
  final apiService= Api();

  @override
  void onInit() {
    fetchDoctor();
    //fetchUserRecord();
    super.onInit();

    
  }

  Future<List<Doctor>> fetchDoctor() async {
    try {
      isLoading.value = false;
      final doctorList = await _doctorRepository.getDoctor();
      //final listdoctor=await apiService.getDoctor();
      doctorsList.assignAll(doctorList);
      return doctorList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Doctor>> fetchAppointment() async {
    try {
      isLoading.value = false;
      final doctorList = await _doctorRepository.getDoctor();
      doctorsList.assignAll(doctorList);
      return doctorList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  // Future<List<Doctor>> fetchAllDoctors() async {
  //   try {
  //     isLoading.value = true;
  //     final doctorList = await _doctorRepository.getDoctor();
  //     doctorsList.assignAll(doctorList);
  //     return postList;
  //   } catch (e) {
  //     KLoaders.errorSnackBar(
  //         title: 'Something went wrong!', message: e.toString());
  //     return [];
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

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

  void deletePost(String doctorId) async {
    try {
      isLoading.value = true;
      await _doctorRepository.deleteDoctor(doctorId);
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

 
}
