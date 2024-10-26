import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Import this for PageController
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/first_onboarding_page.dart';
import 'package:pinkaid/patients_nav_bar.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Add a PageController
  final pageController = PageController();
  final formKey = GlobalKey<FormState>();
  RxInt age = 0.obs; //
  var totalPages = 7;
  RxString gender = ''.obs; //

  // Section A Variables
  var selectedRace = ''.obs;
  var selectedEducation = ''.obs;
  var occupation = ''.obs;
  var maritalStatus = ''.obs;
  RxInt noChildren = 0.obs;
  var totalIncome = ''.obs;
  var residence = ''.obs;
  var hasCancer = false.obs;
  String? otherHospitalName = '';
  var diagnosisDate = Rxn<DateTime>();
  var hasUndergoneTreatment = false.obs;
  var historyofAdmission = false.obs;
  var typeOfHospitalization = ''.obs;
  var lengthOfHospitalStay = ''.obs;
  var nameOfHospital = <String>[].obs;
  var selectedTreatments = <String>[].obs;

  var isExperiencingLump = false.obs;

  //section c symptoms
  var hasBreastLump = false.obs;
  var abruptChangesSizeBreast = false.obs;
  var nippleDischarge = false.obs;
  var breastDiscomfort = false.obs;
  var nippleBleeding = false.obs;
  var breastRedness = false.obs;
  var breastWound = false.obs;
  var breastPulling = false.obs;

  //var screeningMethod = <String>[].obs;

  var doesSelfExamination = false.obs;
  var hasUndergoneScreening = false.obs;
  var selectedBreastExamWays = 'Select an option'.obs;
  var selectedBreastExamTime = 'Select an option'.obs;
  final List<String> breastExamTimes = [
    'Select an option', // Default placeholder option
    '1 week after oneset of menstruation',
    '1 month after oneset of menstruation',
    'Not sure',
  ];

  RxString wantBreastScreen = ''.obs;

  final List<String> listWhere = [
    'Select an option',
    'Mother',
    'Sister',
    'Other relatives',
    'Friend',
    'Teacher',
    'Social Media',
    'Electronic Media (TV,video)',
    'Printed Media',
    'Never taught',
  ];

  final List<String> screeningMethod = [
    'Select an option',
    'Breast self-examination (BSE)',
    'Clinical breast examination(BSE)',
    'Mammography',
    'Never done any breast screening',
  ];
  var oftenBSE = 'Daily'.obs; // Initial value
  final List<String> bse = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
    'Anytime feel like doing it',
    'Anytime I suspect something',
    'Unable to remember',
  ];

  final List<String> breastExamWays = [
    'Select an option', // Default placeholder option
    'Lying down',
    'Standing up',
    'Sitting down',
  ];

  var reasonNotDo = 'Do not know how to do it'.obs;
  final List<String> reasons = [
    'Do not know how to do it',
    'Not necessary',
    'No family history',
    'Not aware risk of breast cancer',
    'Do not have time',
    'No reason',
  ];

  //section E

  var isAwareInherited = false.obs; // For radio buttons

  // Question: Do you have a family history of breast cancer?
  var hasFamilyHistory = false.obs; // For radio buttons
  var who = ''.obs;
  var typeofCancer = ''.obs;

  //var hasFamilyHistory=<String>[].obs;
  var positiveCancer = 'No'.obs;
  List<String> optionCancer = ['Yes', 'No', 'Dont know'];

  var menstruationOrMenopause = 'Select an option'.obs;
  final List<String> menstruationOrMenopauseOptions = [
    'Select an option', // Default placeholder
    'Menstruated at early age',
    'Experienced late menopause',
    'Others (please specify)',
  ];

  // Question: Medications or supplements related to breast health
  var takingMedication = false.obs; // For radio buttons
  var medicationDetails = ''.obs; // For text input

  // Question: Alcohol consumption
  var consumedAlcohol = false.obs; // For radio buttons
  var alcoholDetails = ''.obs; // For text input

  // Question: Smoking habits
  var hasSmoked = false.obs; // For radio buttons
  var smokingFrequency = 'Daily'.obs;
  final List<String> smokeFrequent = [
    'Daily',
    'Ever 3-5 days (times) weekly',
    'Once weekly',
    'Bi-weekly',
    'Monthly',
    'Anytime'
  ];

  var haveBeenPregnant = false.obs;
  var countPregnant = ''.obs;
  var ageFirstChild = ''.obs;
  var breastFed = false.obs;
  var contraceptivesMed = false.obs;
  var currentContraceptivesMed = false.obs;
  var hormonTherapyBefore = false.obs;
  var currenthormonTherapy = false.obs;
  var radiationExposurebefore = false.obs;
  var radiationExposureduring = false.obs;
  var lengthExposure = ''.obs;
  var bodyMass = ''.obs;
  var exercise = 'Hiking'.obs;
  final List<String> exerciseList = [
    'Hiking',
    'Jogging',
    'Running',
    'Sports',
    'Others'
  ];

  var otherExercise = ''.obs;

  final List<String> questions = [
    'Are you experiencing any breast lumps/masses?',
    'Have you noticed any changes in the breast skin?',
    'Do you have any nipple discharge?',
    'Do you have any nipple bleeding?'
        'Have you experince any breast pain or discomfort',
    'Have you experince any redness of breast skin',
    'Have you experince any wound around your nipple',
    'Have you experince any pulling of the nipple inward?',
  ];

  final List<RxBool> questionValues = List.generate(8, (_) => false.obs);

  // Method to update the page indicator
  void updatePageIndicator(int index) {
    // Add your logic here to update the indicator
  }

  // Method for dot navigation click
  void dotNavigationClick(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  var currentPageIndex = 0.obs;
  // Method to navigate to the next page
  void nextPage() {
    // Get the current page index
    int currentPage = pageController.page!.toInt();
    // Calculate the next page index
    int nextPage = currentPage + 1;
    currentPageIndex.value = currentPage;

    // Check if the current page is the last page
    if (currentPage == 7) {
      // Navigate to the home page

      Get.off(
          const PatientBottomNavigationBar()); // Replace `HomePage()` with your home page widget
    } else {
      // Animate to the next page
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  // Method to skip to a specific page or the last page
  void skipToLastPage() {
    int lastPageIndex = 7;
    pageController.jumpToPage(lastPageIndex);
  }

  // Method to go to the previous page
  void previousPage() {
    int previousPage = pageController.page!.toInt() - 1;

    // Check if the current page is the first page
    if (previousPage < 0) {
      // Navigate to TryPage
      Get.to(() => const FirstOnboardingPage());
    } else {
      // Navigate to the previous page
      pageController.animateToPage(
        previousPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

// Method to save medical history to Firebase
  Future<void> saveMedicalHistory() async {
    try {
      // Get the user's UID from AuthRepository
      String userId = AuthRepository.instance.authUser?.uid ?? '';

      // Create a map with all medical history fields
      Map<String, dynamic> medicalHistoryData = {
        'age': age.value,
        'gender': gender.value,
        'selectedRace': selectedRace.value,
        'selectedEducation': selectedEducation.value,
        'occupation': occupation.value,
        'maritalStatus': maritalStatus.value,
        'noChildren': noChildren.value,
        'totalIncome': totalIncome.value,
        'residence': residence.value,
        'hasCancer': hasCancer.value,
        'otherHospitalName': otherHospitalName,
        'diagnosisDate': diagnosisDate.value,
        'hasUndergoneTreatment': hasUndergoneTreatment.value,
        'historyOfAdmission': historyofAdmission.value,
        'typeOfHospitalization': typeOfHospitalization.value,
        'lengthOfHospitalStay': lengthOfHospitalStay.value,
        'nameOfHospital': nameOfHospital.toList(), // Convert observable to list
        'selectedTreatments': selectedTreatments.toList(),
        'isExperiencingLump': isExperiencingLump.value,
        'hasBreastLump': hasBreastLump.value,
        'abruptChangesSizeBreast': abruptChangesSizeBreast.value,
        'nippleDischarge': nippleDischarge.value,
        'nippleBleeding': nippleBleeding.value,
        'breastDiscomfort': breastDiscomfort.value,
        'breastRedness': breastRedness.value,
        'breastWound': breastWound.value,
        'breastPulling': breastPulling.value,
        'doesSelfExamination': doesSelfExamination.value,
        'hasUndergoneScreening': hasUndergoneScreening.value,
        'selectedBreastExamWays': selectedBreastExamWays.value,
        'selectedBreastExamTime': selectedBreastExamTime.value,
        'oftenBSE': oftenBSE.value,
        'reasonNotDo': reasonNotDo.value,
        'isAwareInherited': isAwareInherited.value,
        'hasFamilyHistory': hasFamilyHistory.value,
        'who': who.value,
        'typeOfCancer': typeofCancer.value,
        'positiveCancer': positiveCancer.value,
        'menstruationOrMenopause': menstruationOrMenopause.value,
        'takingMedication': takingMedication.value,
        'medicationDetails': medicationDetails.value,
        'consumedAlcohol': consumedAlcohol.value,
        'alcoholDetails': alcoholDetails.value,
        'hasSmoked': hasSmoked.value,
        'smokingFrequency': smokingFrequency.value,
        'haveBeenPregnant': haveBeenPregnant.value,
        'countPregnant': countPregnant.value,
        'ageFirstChild': ageFirstChild.value,
        'breastFed': breastFed.value,
        'contraceptivesMed': contraceptivesMed.value,
        'currentContraceptivesMed': currentContraceptivesMed.value,
        'hormonTherapyBefore': hormonTherapyBefore.value,
        'currenthormonTherapy': currenthormonTherapy.value,
        'radiationExposureBefore': radiationExposurebefore.value,
        'radiationExposureDuring': radiationExposureduring.value,
        'lengthExposure': lengthExposure.value,
        'bodyMass': bodyMass.value,
        'exercise': exercise.value,
        'otherExercise': otherExercise.value,
      };

      // Push the data to Firestore
      await FirebaseFirestore.instance.collection('Patients').doc(userId).set({
        'medicalHistory': medicalHistoryData,
      }, SetOptions(merge: true));
      await FirebaseFirestore.instance.collection('Users').doc(userId).set(
          {
            'fillForm': true,
          },
          SetOptions(
              merge: true)); // Use merge to avoid overwriting other fields

      print('Medical history saved successfully!');
      Get.to(() => PatientBottomNavigationBar());
    } catch (e) {
      print('Error saving medical history: $e');
    }
  }
}
