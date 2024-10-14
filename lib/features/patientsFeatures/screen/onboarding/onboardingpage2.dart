import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

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