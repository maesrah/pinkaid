import 'package:flutter/material.dart'; // Import this for PageController
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/first_onboarding_page.dart';
import 'package:pinkaid/patients_nav_bar.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Add a PageController
  final pageController = PageController();
  RxInt age = 0.obs;
  RxString gender = ''.obs;
   final formKey = GlobalKey<FormState>();

  // Section A Variables
  var selectedRace = ''.obs;
  var selectedEducation = ''.obs;
  var maritalStatus = ''.obs;
  RxInt noChildren = 0.obs;
  var totalIncome=''.obs;
  var residence = ''.obs;
  var hasCancer = false.obs;
   String otherHospitalName = '';
  var diagnosisDate = Rxn<DateTime>();
  var hasUndergoneTreatment = false.obs;
  var historyofAdmission = false.obs;
  var typeOfHospitalization = ''.obs;
  var lengthOfHospitalStay=''.obs;
  var nameOfHospital=<String>[].obs;
  var selectedTreatments = <String>[].obs;
  var isExperiencingLump= false.obs;
  var hasUndergoneScreening = false.obs;
  var screeningMethod = <String>[].obs;
  
  var doesSelfExamination = false.obs;


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

  final List<String> breastExamTimes = [
    'Select an option', // Default placeholder option
    '1 week after oneset of menstruation',
    '1 month after oneset of menstruation',
    'Not sure',
    
  ];
  var selectedBreastExamTime = 'Select an option'.obs;

  final List<String> breastExamWays = [
    'Select an option', // Default placeholder option
    'Lying down',
    'Standing up',
    'Sitting down',
    
  ];
  var selectedBreastExamWays = 'Select an option'.obs;

  RxString wantBreastScreen=''.obs;

  // Question: Are you aware that breast cancer can be inherited?
  var isAwareInherited = false.obs; // For radio buttons

  // Question: Do you have a family history of breast cancer?
  var hasFamilyHistory = false.obs; // For radio buttons

  // Question: Menstruation or menopause history
  var menstruationOrMenopause = 'Select an option'.obs; // For dropdown
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
  var smokingFrequency = ''.obs; // For text input

  // Corresponding list of observable boolean values for each question
  final List<RxBool> questionValues = List.generate(8, (_) => false.obs);

  // Section B Variables
  var hasHospitalAdmissions = false.obs;
  var hospitalizationType = ''.obs;

  // Section C Variables
  var experiencingBreastLumps = false.obs;
  var noticedBreastChanges = false.obs;
  var nippleDischarge = false.obs;
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

  // Method to navigate to the next page
  void nextPage() {
  // Get the current page index
  int currentPage = pageController.page!.toInt();
  // Calculate the next page index
  int nextPage = currentPage + 1;
  
  // Check if the current page is the last page
  if (currentPage == 5) {
    // Navigate to the home page
    Get.off(const PatientBottomNavigationBar()); // Replace `HomePage()` with your home page widget
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
  int lastPageIndex = 6;
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
}
