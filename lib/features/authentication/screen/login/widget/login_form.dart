import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/features/authentication/screen/registration/register_basic_info.page.dart';

import 'package:pinkaid/theme/elevated_button_theme.dart';

import 'package:pinkaid/theme/theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formkey = GlobalKey<FormState>();
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            validator: (value) {
              //a.aaba@aa1a_a.com
              if (value!.isEmpty ||
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value)) {
                return S.of(context).correctEmail;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.direct_right),
              hintText: S.of(context).email,
              labelText: S.of(context).email,
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
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return S.of(context).passReq;
              }
              return null;
            },
            obscureText: _visible,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              hintText: S.of(context).password,
              labelText: S.of(context).password,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _visible = !_visible;
                  });
                },
                child: Icon(_visible ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(height: kSpaceScreenPadding),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).forgotPass,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: kSpaceScreenPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: KElevatedButtonTheme.lightElevatedButtonTheme.style,
                onPressed: () {},
                child: Text(S.of(context).login)),
          ),
          const SizedBox(height: kSpaceScreenPadding),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: S.of(context).nonAccount,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
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
                          .push(RegistrationBasicInfoPage.route());
                      // Navigator.of(context)
                      //     .push(RegistrationUserRolePage.route());
                    },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
