import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';

class OnboardingPage6 extends StatelessWidget {
  const OnboardingPage6({
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
            'Section E: Risk Factor',
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          // Question 1: Are you aware that breast cancer can be inherited?
          const Text(
            'Are you aware that breast cancer can be inherited?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Obx(() => RadioListTile<bool>(
                title: const Text('Yes'),
                value: true,
                groupValue: onBoardingController.isAwareInherited.value,
                onChanged: (value) {
                  onBoardingController.isAwareInherited.value = value!;
                },
              )),
          Obx(() => RadioListTile<bool>(
                title: const Text('No'),
                value: false,
                groupValue: onBoardingController.isAwareInherited.value,
                onChanged: (value) {
                  onBoardingController.isAwareInherited.value = value!;
                },
              )),
          const SizedBox(height: 16.0),

          // Question 2: Do you have a family history of breast cancer?
          const Text(
            'Do you have a family history of breast cancer?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Obx(() => RadioListTile<bool>(
                title: const Text('Yes'),
                value: true,
                groupValue: onBoardingController.hasFamilyHistory.value,
                onChanged: (value) {
                  onBoardingController.hasFamilyHistory.value = value!;
                },
              )),
          Obx(() => RadioListTile<bool>(
                title: const Text('No'),
                value: false,
                groupValue: onBoardingController.hasFamilyHistory.value,
                onChanged: (value) {
                  onBoardingController.hasFamilyHistory.value = value!;
                },
              )),
          const SizedBox(height: 16.0),

          // Question 3: Menstruation or menopause history
          const Text(
            'Have you started menstruating at an early age or experienced late menopause?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Obx(() => DropdownButton<String>(
                value: onBoardingController.menstruationOrMenopause.value,
                items: onBoardingController.menstruationOrMenopauseOptions
                    .map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onBoardingController.menstruationOrMenopause.value =
                        newValue;
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
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Obx(() => RadioListTile<bool>(
                title: const Text('Yes'),
                value: true,
                groupValue: onBoardingController.takingMedication.value,
                onChanged: (value) {
                  onBoardingController.takingMedication.value = value!;
                },
              )),
          Obx(() => RadioListTile<bool>(
                title: const Text('No'),
                value: false,
                groupValue: onBoardingController.takingMedication.value,
                onChanged: (value) {
                  onBoardingController.takingMedication.value = value!;
                },
              )),
          if (onBoardingController.takingMedication.value)
            TextField(
              decoration: const InputDecoration(
                labelText: 'Please specify type and dosage',
              ),
              onChanged: (text) {
                onBoardingController.medicationDetails.value = text;
              },
            ),
          const SizedBox(height: 16.0),

          // Question 5: Alcohol consumption
          const Text(
            'Have you ever consumed alcohol regularly?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Obx(() => RadioListTile<bool>(
                title: const Text('Yes'),
                value: true,
                groupValue: onBoardingController.consumedAlcohol.value,
                onChanged: (value) {
                  onBoardingController.consumedAlcohol.value = value!;
                },
              )),
          Obx(() => RadioListTile<bool>(
                title: const Text('No'),
                value: false,
                groupValue: onBoardingController.consumedAlcohol.value,
                onChanged: (value) {
                  onBoardingController.consumedAlcohol.value = value!;
                },
              )),
          if (onBoardingController.consumedAlcohol.value)
            TextField(
              decoration: const InputDecoration(
                labelText: 'How many drinks do you typically consume per week?',
              ),
              onChanged: (text) {
                onBoardingController.alcoholDetails.value = text;
              },
            ),
          const SizedBox(height: 16.0),

          // Question 6: Smoking habits
          const Text(
            'Have you ever smoked before?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                onBoardingController.smokingFrequency.value = text;
              },
            ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

