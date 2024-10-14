import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pinkaid/features/patientsFeatures/controller/onboarding_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

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
