import 'package:get/get.dart';

class SurveyController extends GetxController {
  // Progress percentage
  RxDouble completionPercentage = 0.0.obs;

  // Form Fields
  RxInt age = 0.obs;
  RxString gender = ''.obs;

  // Method to update the completion percentage
  void updateCompletionPercentage(int sectionCompleted) {
    switch (sectionCompleted) {
      case 1: // After completing Section A
        completionPercentage.value = 0.33; // 33%
        break;
      case 2: // After completing Section B
        completionPercentage.value = 0.66; // 66%
        break;
      case 3: // After completing Section C
        completionPercentage.value = 1.0; // 100%
        break;
      default:
        completionPercentage.value = 0.0;
        break;
    }
  }
}
