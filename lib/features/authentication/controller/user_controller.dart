import 'package:get/get.dart';
import 'package:pinkaid/api.dart';

import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/data/repositories/categories/categories_repository.dart';
import 'package:pinkaid/data/repositories/doctor/doctor_repository.dart';
import 'package:pinkaid/data/repositories/post/post_repository.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/utils/helpers/dummydata.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pick_image.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final authRepository = AuthRepository.instance;
  final categoryRepository = Get.put(CategoryRepository());
  final postRepository = Get.put(PostRepository());
  final doctorRepository = Get.put(DoctorRepository());
  final apiService = Api();
  var currentIndex = 0.obs;
  var fillInForm = true.obs; // This indicates if the form is filled
  var showAlert = false.obs; // This controls whether to show the alert
   var dialogShown = false;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.getUserDetails();
      this.user(user);
      //print(user.toString());
     print('FillForm value: ${user.fillForm}'); // Log the fillForm value

    // Set showAlert based on fillForm
    fillInForm.value=user.fillForm;
    showAlert.value = !user.fillForm;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  void checkFormStatus() async {
    final user = await userRepository.getUserDetails();
      this.user(user);
      //print(user.toString());
     print('FillForm value: ${user.fillForm}'); // Log the fillForm value

    fillInForm.value=user.fillForm;
    showAlert.value = !user.fillForm;
  }

  void hideAlert() {
    showAlert.value = false;
    dialogShown = false;  // Hide the alert
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
      KLoaders.errorSnackBar(title: 'OhSnap', message: 'Something went wrong');
    }
  }

  updateUserData(String field, String newValue, String userId) async {
    try {
      profileLoading.value = true;
      if (field == 'fullName') {
        user.value.fullName = newValue;
      } else if (field == 'phoneNumber') {
        user.value.phoneNumber = newValue;
      }
      Map<String, dynamic> json = {field: newValue};
      await userRepository.updateSingleField(json);
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      KLoaders.successSnackBar(
          title: 'Success', message: 'Succesfully update your profile');
      user.refresh();
      profileLoading.value = false;
    }
  }

  uploadCategoryData() async {
    await categoryRepository.uploadDummyData(KDummyData.categories);
  }

  uploadPostsData() async {
    await categoryRepository.uploadPostData(KDummyData.posts);
  }

  uploadDoctorData() async {
    await categoryRepository.uploadDoctorData(KDummyData.doctors);
  }

  uploadDoctorAPI() async {
    await apiService.createDoctors(KDummyData.doctors);
  }

  uploadMealData() async {
    await categoryRepository.uploadMealData(KDummyData.dummyMeals);
  }

  uploadQuizData() async {
    await categoryRepository.uploadQuizData(KDummyData.dummyQuizzes);
  }
}
