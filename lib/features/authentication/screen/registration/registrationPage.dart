import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:pinkaid/features/authentication/controller/registration/registration_controller.dart';

import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';

import 'package:pinkaid/theme/textheme.dart';

import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/formatters/formatter.dart';
import 'package:pinkaid/utils/validators/validators.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    super.key,
  });
  static const String routeName = 'RegistrationForm';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const RegistrationForm();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool _visible = false;

  String dropdownValue = 'doctor';
  UserRole? _selectedUserRole;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorSecondary,
        title: Text(
          S.of(context).registration,
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Let\'s create your account',
                  style: KTextTheme.lightTextTheme.headlineMedium,
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                TextFormField(
                  controller: controller.fullName,
                  validator: (value) => KValidator.validateEmptyText(value),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.profile_tick),
                    hintText: S.of(context).nameLabel,
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                // IntlPhoneField(
                //   controller: controller.phoneNumber,
                //   flagsButtonPadding: const EdgeInsets.all(8),
                //   decoration: const InputDecoration(
                //     labelText: 'Phone Number',
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(),
                //     ),
                //   ),
                //   initialCountryCode: 'MY',
                // ),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => KValidator.validatePhoneNumber(value),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.call),
                    hintText: S.of(context).phoneNo,
                    filled: true,
                    fillColor: Colors.white,
                    errorStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                DropdownButtonFormField<UserRole>(
                  value: _selectedUserRole,
                  onChanged: (UserRole? newValue) {
                    setState(() {
                      _selectedUserRole = newValue;
                    });
                  },
                  validator: (UserRole? value) {
                    if (value == null) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.people),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)))),
                  items: [
                    // Add a default value to indicate selection is required
                    const DropdownMenuItem<UserRole>(
                      value: null,
                      child: Text('Select a role'),
                    ),
                    // Add enum values
                    ...UserRole.values.map((UserRole userRole) {
                      return DropdownMenuItem<UserRole>(
                        value: userRole,
                        child: Text(userRole.toString().split('.').last),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                if (_selectedUserRole == UserRole.doctor)
                  TextFormField(
                    validator: (value) => KValidator.validateEmptyText(value),
                    decoration: const InputDecoration(
                      hintText: 'Medical Id',
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Obx(
                          () => Checkbox(
                            value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy
                                .value = !controller.privacyPolicy.value,
                          ),
                        )),
                    const SizedBox(
                      width: kSpaceSectionSm,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).agreeLabel,
                            style: const TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: S.of(context).termAndCondition,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                      minimumSize: MaterialStateProperty.resolveWith<Size>(
                        (states) => const Size(double.infinity, 50),
                      ),
                    ),
                    onPressed: () async {
                      await controller.signInWithPhoneNumber(
                          phoneNo: KFormatter.formatPhoneNumber(
                              controller.phoneNumber.text));
                    },
                    child: Text(
                      S.of(context).verifyNo,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                const SizedBox(
                  height: kSpaceScreenPaddingLg,
                ),
                Obx(() {
                  return controller.codeSentResult == 'yes'
                      ? Column(
                          children: [
                            TextFormField(
                              controller: controller.verifyNo,
                              validator: (value) =>
                                  KValidator.validatePhoneNumber(value),
                              obscureText: _visible,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Iconsax.password_check),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: S.of(context).verifyNo,
                                errorStyle:
                                    const TextStyle(color: Colors.black),
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                              ),
                            ),
                            const SizedBox(
                              height: kSpaceSectionLg,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor),
                                  minimumSize:
                                      MaterialStateProperty.resolveWith<Size>(
                                    (states) => const Size(double.infinity, 50),
                                  ),
                                ),
                                onPressed: () {
                                  String codeInput = controller.verifyNo.text;
                                  UserRole? userRole = _selectedUserRole;
                                  String fullname = controller.fullName.text;
                                  controller.myCredentials(
                                    phoneNumber: controller.phoneNumber.text,
                                    name: fullname,
                                    verID: controller.verificationResult,
                                    userInput: codeInput,
                                    userRole: userRole!,
                                  );
                                },
                                child: Text(
                                  S.of(context).register,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                )),
                            const SizedBox(
                              height: kSpaceSectionLg,
                            ),
                          ],
                        )
                      : const Text('');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
