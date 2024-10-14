import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/survey_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/try_survery_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/user_details.dart';
import 'package:pinkaid/theme/elevated_button_theme.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class FirstOnboardingPage extends StatelessWidget {
  const FirstOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kSpaceScreenPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80,),
                Image.asset('assets/images/pinkhand.png', height: 150,),
                const SizedBox(height: 20,),
                Text('Pink Aid',style: KTextTheme.lightTextTheme.headlineMedium,),
                const SizedBox(height: kSpaceScreenPadding,),
                Text('Empower Your Journey',style: KTextTheme.lightTextTheme.bodyLarge,),
                Text('with Pink Aid',style: KTextTheme.lightTextTheme.bodyLarge,),
                SizedBox(height: kSpaceScreenPadding,),
                SizedBox(width: 300,child: ElevatedButton(
                  style:KElevatedButtonTheme.lightElevatedButtonTheme.style,
                   onPressed: () {
                    // Get.to(() => SurveyOnboardingPage());
                    Get.to(() => TryOnboardPage());
                   },
                   child: Text('Get started'),),)
            
              ],
                    
            ),
          ),
        ),
      ),
    );
  }
}