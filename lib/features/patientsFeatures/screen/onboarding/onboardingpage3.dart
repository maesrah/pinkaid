import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

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