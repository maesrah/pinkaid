import 'package:flutter/material.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/screen/login/login.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = 'WelcomeScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const LoginScreen();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: kColorPrimary),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSpaceScreenPaddingLg * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(S.of(context).welcome,
                        style: Theme.of(context).textTheme.headlineMedium),
                    const Image(
                      image: AssetImage(KImages.appLogo),
                      width: 300,
                      height: 300,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(kSpaceScreenPadding)),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: kColorSecondary),
                      child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: kSpaceScreenPadding),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(LoginScreen.route());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(kSpaceScreenPadding)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Log in',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
