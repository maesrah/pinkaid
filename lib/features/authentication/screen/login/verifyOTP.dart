import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinkaid/features/authentication/controller/login/loginController.dart';

import 'package:pinkaid/theme/elevated_button_theme.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

import 'package:pinput/pinput.dart';

class VerifyOTP extends StatelessWidget {
  final String verificationId;

  const VerifyOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kSpaceScreenPaddingLg,
                  horizontal: kSpaceScreenPaddingLg),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg * 2,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    padding: const EdgeInsets.all(kSpaceScreenPadding),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: kColorSecondary),
                    child: Padding(
                      padding: const EdgeInsets.all(kSpaceScreenPaddingLg),
                      child: Image.asset('assets/icons/one-time-password.png'),
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Text(
                    'Verification',
                    style: KTextTheme.lightTextTheme.headlineMedium,
                  ),
                  Text(
                    'We have sent the OTP to your phone number',
                    style: KTextTheme.lightTextTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Pinput(
                    controller: controller.verifyNo,
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kColorSecondary))),
                  ),
                  const SizedBox(height: kSpaceScreenPaddingLg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style:
                            KElevatedButtonTheme.lightElevatedButtonTheme.style,
                        onPressed: () async {
                          await controller.verifyCodeandLogin(
                              verID: verificationId,
                              userInput: controller.verifyNo.text);
                        },
                        child: const Text('Verify')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
