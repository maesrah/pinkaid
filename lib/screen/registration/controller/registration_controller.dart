import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(int index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {}

  void nextPage() {
    if (currentPageIndex.value == 2) {
      //Get.to(RegistrationBasicInfoPage());
    } else {
      int page = currentPageIndex.value + 1;
      print('Navigating to next page: $page');

      pageController.jumpToPage(page);
    }
  }

  void previousPage() {
    int page = currentPageIndex.value - 1;
    if (page >= 0) {
      pageController.jumpToPage(page);
    }
  }

//   void nextPage(String role) {
//   if (role == 'doctor') {
//     // Navigate to a page specific to doctors
//     // Example: Get.to(DoctorPage());
//   } else if (role == 'patient') {
//     if (currentPageIndex.value == 2) {
//       // Navigate to a page specific to patients when on the last page
//       // Example: Get.to(PatientRegistrationPage());
//     } else {
//       // Navigate to the next page for patients
//       int page = currentPageIndex.value + 1;
//       pageController.jumpToPage(page);
//     }
//   }
// }

  void skipPage() {}
}
