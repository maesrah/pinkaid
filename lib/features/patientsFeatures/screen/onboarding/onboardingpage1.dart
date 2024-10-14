import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

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
