import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/bottom_nav_bar.dart';
import 'package:pinkaid/features/authentication/controller/login/loginController.dart';
import 'package:pinkaid/features/authentication/screen/home/patients_home_page.dart';

import 'package:pinkaid/features/authentication/screen/registration/registrationPage.dart';
import 'package:pinkaid/generated/l10n.dart';

import 'package:pinkaid/features/authentication/screen/login/widget/login_logo_widget.dart';
import 'package:pinkaid/theme/elevated_button_theme.dart';

import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/formatters/formatter.dart';
import 'package:pinkaid/utils/validators/validators.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = 'LoginScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const LoginScreen();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoginLogoWidget(),
            const SizedBox(height: 10),
            Form(
              key: controller.loginFormKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) => KValidator.validatePhoneNumber(value),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.call),
                      hintText: S.of(context).phoneNo,
                      labelText: S.of(context).phoneNo,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                        child: Checkbox(value: true, onChanged: (value) {}),
                      ),
                      const SizedBox(
                        width: kSpaceSectionSm,
                      ),
                      const Text('Remember me?')
                    ],
                  ),
                  const SizedBox(height: kSpaceScreenPaddingLg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style:
                            KElevatedButtonTheme.lightElevatedButtonTheme.style,
                        onPressed: () async {
                          // await controller.logInWithPhoneNumber(
                          //     phoneNo: KFormatter.formatPhoneNumber(
                          //         controller.phoneNumber.text));
                          Get.to(() => const CustomBottomNavigationBar());
                        },
                        child: Text(S.of(context).login)),
                  ),
                  const SizedBox(height: kSpaceScreenPadding),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: S.of(context).nonAccount,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                        TextSpan(
                          text: S.of(context).register,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .push(RegistrationForm.route());
                            },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: kSpaceScreenPaddingLg * 2),
            Center(
              child: Text(
                S.of(context).continueW,
                style: KTextTheme.lightTextTheme.bodyMedium,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: kColorSecondary,
                    foregroundColor: Colors.black),
                child: const Text(
                  'Guest',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
