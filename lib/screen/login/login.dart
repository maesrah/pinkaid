import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinkaid/screen/home/patients_home_page.dart';
import 'package:pinkaid/screen/login/widget/login_logo_widget.dart';
import 'package:pinkaid/screen/registration/register.dart';

import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class LoginScreen extends StatefulWidget {
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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LoginLogoWidget(),
            const SizedBox(height: 10),
            Form(
              key: _formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    validator: (value) {
                      //a.aaba@aa1a_a.com
                      if (value!.isEmpty ||
                          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                        return 'Enter correct email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email*',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
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
                        return 'Enter password';
                      }
                      return null;
                    },
                    obscureText: _visible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      labelText: 'Password*',
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                        child: Icon(
                            _visible ? Icons.visibility : Icons.visibility_off),
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
                            text: 'Forgot password?',
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: kSpaceScreenPadding),
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
                      onPressed: () {
                        setState(() {
                          // if (_formkey.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content: Text("Successfuly Log In!"),
                          //     ),
                          //   );
                          // }
                          Navigator.of(context).push(PatientsHomePage.route());
                        });
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                  const SizedBox(height: kSpaceScreenPadding),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .push(RegistrationPage.route());
                              // Navigator.of(context)
                              //     .push(RegistrationUserRolePage.route());
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kSpaceScreenPaddingLg * 2),
                  Text(
                    'Continue with',
                    style: KTextTheme.lightTextTheme.bodyMedium,
                  ),
                  const SizedBox(height: kSpaceScreenPadding),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Image(
                      image: AssetImage(
                        'assets/icons/google.png',
                      ),
                      height: 40,
                      width: 30,
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
