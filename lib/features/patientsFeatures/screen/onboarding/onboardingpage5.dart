import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

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