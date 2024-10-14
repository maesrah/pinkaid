import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TryOnboardPage extends StatefulWidget {
  const TryOnboardPage({super.key});

  @override
  State<TryOnboardPage> createState() => _TryOnboardPageState();
}

class _TryOnboardPageState extends State<TryOnboardPage> {
  // Questions grouped by pages
List<List<Map<String, dynamic>>> pagesOfQuestions = [
  [
    {'id': 'q1', 'type': 'text', 'text': 'What is your age?'},
    {'id': 'q2', 'type': 'yes_no', 'text': 'Do you exercise daily?'},
  ],
  [
    {'id': 'q3', 'type': 'checkbox', 'text': 'Select your symptoms:', 'options': ['Fever', 'Cough', 'Headache']},
    {'id': 'q4', 'type': 'radio', 'text': 'What is your gender?', 'options': ['Male', 'Female', 'Other']},
  ],
  // Add more pages of questions as needed
];

  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> pagesOfQuestions = [
  [
    {'id': '1', 'type': 'text', 'text': 'What is your age?'},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
  ],
  [
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '5', 'type': 'text', 'text': 'Occupation'},
    {'id': '6', 'type': 'dropdown', 'text': 'Marital status','options':['Single','Married','Divorce']},
    {'id': '7', 'type': 'text', 'text': 'No of children'},
    {'id': '8', 'type': 'dropdown', 'text': 'Total income', 'options': ['<Rm999','Rm1000-Rm1999','Rm2000-Rm2999','Rm3000-Rm3999','Rm4000-Rm4999','Rm5000-Rm5999','Rm6000-Rm6999','Rm7000-Rm7999','Rm8000-Rm8999'
'Rm9000-Rm9999','Rm10000-Rm15000','Rm15001-Rm19999','>RM20000']},
    {'id': '9', 'type': 'radio', 'text': 'Residence', 'options': ['Urban','Rural']},
    {'id': '10', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '3', 'type': 'dropdown', 'text': 'Race:', 'options': ['Malay', 'Chinese', 'Indian','Others']},
    {'id': '4', 'type': 'dropdown', 'text': 'Education level', 'options': ['Degree','Diploma','Secondary school','Primary school','Not schooling']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
    {'id': '2', 'type': 'radio', 'text': 'Gender?','options':['Male','Female']},
  ]
  
  // Add more pages of questions as needed
];
    return 
    
    Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Medical Form'),
        actions: [TextButton(onPressed: () {
          onBoardingController.skipToLastPage();
        }, child: const Text('SKIP'))],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: Form(
            key: onBoardingController.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceScreenPadding,
                  vertical: kSpaceScreenPadding),
              child: PageView(
                controller: onBoardingController.pageController,
                onPageChanged: (index) {
                  onBoardingController.updatePageIndicator(index);
                },
                children: [
                  OnboardingPage1(onBoardingController: onBoardingController),
                  OnboardingPage2(onBoardingController: onBoardingController),
                  OnboardingPage3(onBoardingController: onBoardingController),
                  OnboardingPage4(onBoardingController: onBoardingController),
                  OnboardingPage5(onBoardingController: onBoardingController),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section E: Risk Factor',
                          style: KTextTheme.lightTextTheme.headlineSmall,
                        ),
                        // Question 1: Are you aware that breast cancer can be inherited?
                        const Text(
                          'Are you aware that breast cancer can be inherited?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('Yes'),
                              value: true,
                              groupValue:
                                  onBoardingController.isAwareInherited.value,
                              onChanged: (value) {
                                onBoardingController.isAwareInherited.value =
                                    value!;
                              },
                            )),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('No'),
                              value: false,
                              groupValue:
                                  onBoardingController.isAwareInherited.value,
                              onChanged: (value) {
                                onBoardingController.isAwareInherited.value =
                                    value!;
                              },
                            )),
                        const SizedBox(height: 16.0),

                        // Question 2: Do you have a family history of breast cancer?
                        const Text(
                          'Do you have a family history of breast cancer?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('Yes'),
                              value: true,
                              groupValue:
                                  onBoardingController.hasFamilyHistory.value,
                              onChanged: (value) {
                                onBoardingController.hasFamilyHistory.value =
                                    value!;
                              },
                            )),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('No'),
                              value: false,
                              groupValue:
                                  onBoardingController.hasFamilyHistory.value,
                              onChanged: (value) {
                                onBoardingController.hasFamilyHistory.value =
                                    value!;
                              },
                            )),
                        const SizedBox(height: 16.0),

                        // Question 3: Menstruation or menopause history
                        const Text(
                          'Have you started menstruating at an early age or experienced late menopause?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => DropdownButton<String>(
                              value: onBoardingController
                                  .menstruationOrMenopause.value,
                              items: onBoardingController
                                  .menstruationOrMenopauseOptions
                                  .map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  onBoardingController
                                      .menstruationOrMenopause.value = newValue;
                                }
                              },
                              isExpanded: true,
                              underline: Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            )),
                        const SizedBox(height: 16.0),

                        // Question 4: Medication or supplements related to breast health
                        const Text(
                          'Are you currently taking any medication or supplements related to breast health?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('Yes'),
                              value: true,
                              groupValue:
                                  onBoardingController.takingMedication.value,
                              onChanged: (value) {
                                onBoardingController.takingMedication.value =
                                    value!;
                              },
                            )),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('No'),
                              value: false,
                              groupValue:
                                  onBoardingController.takingMedication.value,
                              onChanged: (value) {
                                onBoardingController.takingMedication.value =
                                    value!;
                              },
                            )),
                        if (onBoardingController.takingMedication.value)
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Please specify type and dosage',
                            ),
                            onChanged: (text) {
                              onBoardingController.medicationDetails.value =
                                  text;
                            },
                          ),
                        const SizedBox(height: 16.0),

                        // Question 5: Alcohol consumption
                        const Text(
                          'Have you ever consumed alcohol regularly?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('Yes'),
                              value: true,
                              groupValue:
                                  onBoardingController.consumedAlcohol.value,
                              onChanged: (value) {
                                onBoardingController.consumedAlcohol.value =
                                    value!;
                              },
                            )),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('No'),
                              value: false,
                              groupValue:
                                  onBoardingController.consumedAlcohol.value,
                              onChanged: (value) {
                                onBoardingController.consumedAlcohol.value =
                                    value!;
                              },
                            )),
                        if (onBoardingController.consumedAlcohol.value)
                          TextField(
                            decoration: const InputDecoration(
                              labelText:
                                  'How many drinks do you typically consume per week?',
                            ),
                            onChanged: (text) {
                              onBoardingController.alcoholDetails.value = text;
                            },
                          ),
                        const SizedBox(height: 16.0),

                        // Question 6: Smoking habits
                        const Text(
                          'Have you ever smoked before?',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('Yes'),
                              value: true,
                              groupValue: onBoardingController.hasSmoked.value,
                              onChanged: (value) {
                                onBoardingController.hasSmoked.value = value!;
                              },
                            )),
                        Obx(() => RadioListTile<bool>(
                              title: const Text('No'),
                              value: false,
                              groupValue: onBoardingController.hasSmoked.value,
                              onChanged: (value) {
                                onBoardingController.hasSmoked.value = value!;
                              },
                            )),
                        if (onBoardingController.hasSmoked.value)
                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'How often do you smoke?',
                            ),
                            onChanged: (text) {
                              onBoardingController.smokingFrequency.value =
                                  text;
                            },
                          ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  onBoardingController.previousPage();
                },
                child: const Text('BACK')),
            Center(
              child: SmoothPageIndicator(
                  controller: onBoardingController.pageController, count: 6),
            ),
            TextButton(
                onPressed: () {
                  onBoardingController.nextPage();
                },
                child: const Text('NEXT'))
          ],
        ),
      ),
    );
  }
}

class OnboardingPage5 extends StatelessWidget {
  const OnboardingPage5({
    super.key,
    required this.onBoardingController,
  });

  final OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section D: Screening Practices',
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Obx(
            () => CheckboxListTile(
              title: const Text(
                  'Have you ever undergone any breast cancer screening?'),
              value: onBoardingController.hasUndergoneScreening.value,
              onChanged: (value) {
                onBoardingController.hasUndergoneScreening.value = value!;
              },
            ),
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Obx(() {
            if (onBoardingController.hasUndergoneScreening.value) {
              return Column(
                children: [
                  if (onBoardingController.hasUndergoneScreening.value) ...[
                    CheckboxListTile(
                      title: const Text('Breast Self Examination (BSE)'),
                      value: onBoardingController.screeningMethod
                          .contains('Breast Self Examination (BSE)'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.screeningMethod
                              .add('Breast Self Examination (BSE)');
                        } else {
                          onBoardingController.screeningMethod
                              .remove('Breast Self Examination (BSE)');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Clinical Breast Examination (BSE)'),
                      value: onBoardingController.selectedTreatments
                          .contains('Clinical Breast Examination (BSE)'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Clinical Breast Examination (BSE)');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Clinical Breast Examination (BSE)');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Mammography'),
                      value: onBoardingController.selectedTreatments
                          .contains('Mammography'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Mammography');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Mammography');
                        }
                      },
                    ),
                  ],
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Obx(
            () => CheckboxListTile(
              title: const Text('Do you engage in regular self-examination?'),
              value: onBoardingController.doesSelfExamination.value,
              onChanged: (value) {
                onBoardingController.doesSelfExamination.value = value!;
              },
            ),
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          const Text(
            'When is the best time to do a self-breast exam?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(() => DropdownButton<String>(
                value: onBoardingController.selectedBreastExamTime.value,
                items: onBoardingController.breastExamTimes.map((String time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onBoardingController.selectedBreastExamTime.value =
                        newValue;
                  }
                },
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              )),
          Text(
            'If you never done breast cancer screen before, do you have any intention of doing it?',
            style: KTextTheme.lightTextTheme.titleSmall,
          ),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Yes'),
                      value: 'Yes',
                      groupValue: onBoardingController.wantBreastScreen.value,
                      onChanged: (value) {
                        onBoardingController.wantBreastScreen.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('No'),
                      value: 'No',
                      groupValue: onBoardingController.wantBreastScreen.value,
                      onChanged: (value) {
                        onBoardingController.wantBreastScreen.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                ],
              )),
          const Text(
            'How do you perform breast self examination (BSE)?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(() => DropdownButton<String>(
                value: onBoardingController.selectedBreastExamWays.value,
                items: onBoardingController.breastExamWays.map((String time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onBoardingController.selectedBreastExamWays.value =
                        newValue;
                  }
                },
                isExpanded: true,
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}

class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({
    super.key,
    required this.onBoardingController,
  });

  final OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section C: Symptoms',
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < onBoardingController.questions.length; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      onBoardingController.questions[i],
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(() => ToggleButtons(
                          borderColor: Colors.grey,
                          selectedBorderColor: kColorSecondaryLight,
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey,
                          selectedColor: Colors.black,
                          fillColor: kColorSecondaryLight,
                          isSelected: [
                            onBoardingController.questionValues[i].value,
                            !onBoardingController.questionValues[i].value,
                          ],
                          onPressed: (index) {
                            onBoardingController.questionValues[i].value =
                                index == 0;
                          },
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Yes'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('No'),
                            ),
                          ],
                        )),
                    const SizedBox(height: 16.0), // Space between questions
                  ],
                ),
            ],
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({
    super.key,
    required this.onBoardingController,
  });

  final OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section B: History of Admission',
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Obx(
            () => CheckboxListTile(
              title:
                  const Text('Have you get any admission from any hospital?'),
              value: onBoardingController.historyofAdmission.value,
              onChanged: (value) {
                onBoardingController.historyofAdmission.value = value!;
              },
            ),
          ),
          Obx(() {
            if (onBoardingController.historyofAdmission.value) {
              return Column(
                children: [
                  CheckboxListTile(
                      title: const Text('Universiti Malaya Medical Centre'),
                      value: onBoardingController.nameOfHospital
                          .contains('Universiti Malaya Medical Centre'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.nameOfHospital
                              .add('Universiti Malaya Medical Centre');
                        } else {
                          onBoardingController.nameOfHospital
                              .remove('Universiti Malaya Medical Centre');
                        }
                      }),
                  CheckboxListTile(
                      title: const Text('Universiti Malaya Specialist Centre'),
                      value: onBoardingController.nameOfHospital
                          .contains('Universiti Malaya Specialist Centre'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.nameOfHospital
                              .add('Universiti Malaya Specialist Centre');
                        } else {
                          onBoardingController.nameOfHospital
                              .remove('Universiti Malaya Specialist Centre');
                        }
                      }),
                  CheckboxListTile(
                    title: const Text('Others'),
                    value:
                        onBoardingController.nameOfHospital.contains('Others'),
                    onChanged: (value) {
                      if (value!) {
                        onBoardingController.nameOfHospital.add('Others');
                      } else {
                        onBoardingController.nameOfHospital.remove('Others');
                        onBoardingController.otherHospitalName =
                            ''; // Reset the other hospital name
                      }
                      onBoardingController
                          .update(); // Update the controller to refresh the U
                    },
                  ),
                  if (onBoardingController.nameOfHospital.contains('Others'))
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Please specify the hospital name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (text) {
                        onBoardingController.otherHospitalName = text;
                      },
                    ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  Text(
                    'Type of Hospitalization',
                    style: KTextTheme.lightTextTheme.titleSmall,
                  ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('First time'),
                              value: 'First time',
                              groupValue: onBoardingController
                                  .typeOfHospitalization.value,
                              onChanged: (value) {
                                onBoardingController
                                    .typeOfHospitalization.value = value!;
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, // To show radio button before the text
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Several times'),
                              value: 'Several times',
                              groupValue: onBoardingController
                                  .typeOfHospitalization.value,
                              onChanged: (value) {
                                onBoardingController
                                    .typeOfHospitalization.value = value!;
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, // To show radio button before the text
                            ),
                          ),
                        ],
                      )),
                  Obx(() => DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Length of Hospital Stay',
                          border: OutlineInputBorder(),
                        ),
                        value: onBoardingController
                                .lengthOfHospitalStay.value.isEmpty
                            ? null
                            : onBoardingController.lengthOfHospitalStay.value,
                        items: const [
                          DropdownMenuItem(
                              value: '1-5 days', child: Text('1-5 days')),
                          DropdownMenuItem(
                              value: '6-10 days', child: Text('6-10 days')),
                          DropdownMenuItem(
                              value: 'More than 10 days',
                              child: Text('More than 10 days')),
                        ],
                        onChanged: (value) {
                          onBoardingController.lengthOfHospitalStay.value =
                              value ?? '';
                        },
                        validator: (value) => value == null
                            ? 'Please select your length of stay'
                            : null,
                      )),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({
    super.key,
    required this.onBoardingController,
  });

  final OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Total income',
                  border: OutlineInputBorder(),
                ),
                value: onBoardingController.totalIncome.value.isEmpty
                    ? null
                    : onBoardingController.totalIncome.value,
                items: const [
                  DropdownMenuItem(value: '<RM999', child: Text('<RM999')),
                  DropdownMenuItem(
                      value: 'RM1000-RM1999', child: Text('RM1000-RM1999')),
                  DropdownMenuItem(
                      value: 'RM2000-RM2999', child: Text('RM2000-RM2999')),
                  DropdownMenuItem(
                      value: 'RM3000-RM3999', child: Text('RM3000-RM3999')),
                  DropdownMenuItem(
                      value: 'RM4000-RM4999', child: Text('RM4000-RM4999')),
                  DropdownMenuItem(
                      value: 'RM5000-RM5999', child: Text('RM5000-RM5999')),
                  DropdownMenuItem(
                      value: 'RM6000-RM6999', child: Text('RM6000-RM6999')),
                  DropdownMenuItem(
                      value: 'RM7000-RM7999', child: Text('RM7000-RM7999')),
                  DropdownMenuItem(
                      value: 'RM8000-RM8999', child: Text('RM8000-RM8999')),
                  DropdownMenuItem(
                      value: 'RM9000-RM9999', child: Text('RM9000-RM9999')),
                  DropdownMenuItem(
                      value: 'RM10000-RM15000', child: Text('RM10000-RM15000')),
                  DropdownMenuItem(
                      value: 'RM15001-RM19999', child: Text('RM15001-RM19999')),
                  DropdownMenuItem(value: 'RM20000', child: Text('RM20000')),
                ],
                onChanged: (value) {
                  onBoardingController.totalIncome.value = value ?? '';
                },
                validator: (value) =>
                    value == null ? 'Please select your total income' : null,
              )),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Text(
            'Residence',
            style: KTextTheme.lightTextTheme.titleSmall,
          ),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Urban'),
                      value: 'Urban',
                      groupValue: onBoardingController.residence.value,
                      onChanged: (value) {
                        onBoardingController.residence.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Rural'),
                      value: 'Rural',
                      groupValue: onBoardingController.residence.value,
                      onChanged: (value) {
                        onBoardingController.residence.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                ],
              )),
          Obx(() => CheckboxListTile(
                title:
                    const Text('Have you been diagnosed with cancer before?'),
                value: onBoardingController.hasCancer.value,
                onChanged: (value) {
                  onBoardingController.hasCancer.value = value!;
                },
              )),
          Obx(() {
            if (onBoardingController.hasCancer.value) {
              return Column(
                children: [
                  // Date of Diagnosis
                  ListTile(
                    title: const Text('When were you diagnosed?'),
                    subtitle: onBoardingController.diagnosisDate.value == null
                        ? const Text('Select Date')
                        : Text(
                            '${onBoardingController.diagnosisDate.value?.toLocal()}'
                                .split(' ')[0]),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        onBoardingController.diagnosisDate.value = picked;
                      }
                    },
                  ),
                  // Treatment Undergoing
                  CheckboxListTile(
                    title: const Text('Have you undergone any treatment?'),
                    value: onBoardingController.hasUndergoneTreatment.value,
                    onChanged: (value) {
                      onBoardingController.hasUndergoneTreatment.value = value!;
                    },
                  ),
                  if (onBoardingController.hasUndergoneTreatment.value) ...[
                    CheckboxListTile(
                      title: const Text('Chemotherapy'),
                      value: onBoardingController.selectedTreatments
                          .contains('Chemotherapy'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Chemotherapy');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Chemotherapy');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Radiotherapy'),
                      value: onBoardingController.selectedTreatments
                          .contains('Radiotherapy'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Radiotherapy');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Radiotherapy');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Surgery'),
                      value: onBoardingController.selectedTreatments
                          .contains('Surgery'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Surgery');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Surgery');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Chemotherapy + Surgery'),
                      value: onBoardingController.selectedTreatments
                          .contains('Chemotherapy + Surgery'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Chemotherapy + Surgery');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Chemotherapy + Surgery');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Radiotherapy + Surgery'),
                      value: onBoardingController.selectedTreatments
                          .contains('Radiotherapy + Surgery'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Radiotherapy + Surgery');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Radiotherapy + Surgery');
                        }
                      },
                    ),
                    CheckboxListTile(
                      title:
                          const Text('Chemotherapy + Radiotherapy + Surgery'),
                      value: onBoardingController.selectedTreatments
                          .contains('Chemotherapy + Radiotherapy + Surgery'),
                      onChanged: (value) {
                        if (value!) {
                          onBoardingController.selectedTreatments
                              .add('Chemotherapy + Radiotherapy + Surgery');
                        } else {
                          onBoardingController.selectedTreatments
                              .remove('Chemotherapy + Radiotherapy + Surgery');
                        }
                      },
                    ),
                  ],
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({
    super.key,
    required this.onBoardingController,
  });

  final OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Section A: Demographic Data',
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              onBoardingController.age.value = int.tryParse(value) ?? 0;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          Text(
            'Gender',
            style: KTextTheme.lightTextTheme.titleSmall,
          ),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: onBoardingController.gender.value,
                      onChanged: (value) {
                        onBoardingController.gender.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: onBoardingController.gender.value,
                      onChanged: (value) {
                        onBoardingController.gender.value = value!;
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, // To show radio button before the text
                    ),
                  ),
                ],
              )),

          // Race Selection
          Obx(() => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Race',
                  border: OutlineInputBorder(),
                ),
                value: onBoardingController.selectedRace.value.isEmpty
                    ? null
                    : onBoardingController.selectedRace.value,
                items: const [
                  DropdownMenuItem(value: 'Malay', child: Text('Malay')),
                  DropdownMenuItem(value: 'Chinese', child: Text('Chinese')),
                  DropdownMenuItem(value: 'Indian', child: Text('Indian')),
                  DropdownMenuItem(value: 'Others', child: Text('Others')),
                ],
                onChanged: (value) {
                  onBoardingController.selectedRace.value = value ?? '';
                },
                validator: (value) =>
                    value == null ? 'Please select your race' : null,
              )),
          const SizedBox(height: 16.0),
          // Education Level Selection
          Obx(() => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Education Level',
                  border: OutlineInputBorder(),
                ),
                value: onBoardingController.selectedEducation.value.isEmpty
                    ? null
                    : onBoardingController.selectedEducation.value,
                items: const [
                  DropdownMenuItem(value: 'Degree', child: Text('Degree')),
                  DropdownMenuItem(value: 'Diploma', child: Text('Diploma')),
                  DropdownMenuItem(
                      value: 'Secondary School',
                      child: Text('Secondary School')),
                  DropdownMenuItem(
                      value: 'Primary School', child: Text('Primary School')),
                  DropdownMenuItem(
                      value: 'Not schooling', child: Text('Not schooling')),
                ],
                onChanged: (value) {
                  onBoardingController.selectedEducation.value = value ?? '';
                },
                validator: (value) =>
                    value == null ? 'Please select your education level' : null,
              )),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Occupation',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your occupation';
              }
              return null;
            },
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),

          Obx(() => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Marital Status',
                  border: OutlineInputBorder(),
                ),
                value: onBoardingController.maritalStatus.value.isEmpty
                    ? null
                    : onBoardingController.maritalStatus.value,
                items: const [
                  DropdownMenuItem(value: 'Single', child: Text('Single')),
                  DropdownMenuItem(value: 'Married', child: Text('Married')),
                  DropdownMenuItem(value: 'Divorce', child: Text('Divorce')),
                ],
                onChanged: (value) {
                  onBoardingController.maritalStatus.value = value ?? '';
                },
                validator: (value) =>
                    value == null ? 'Please select your marital status' : null,
              )),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'No of children',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              onBoardingController.noChildren.value = int.tryParse(value) ?? 0;
            },
          ),
          const SizedBox(
            height: kSpaceScreenPadding,
          ),
        ],
      ),
    );
  }
}
