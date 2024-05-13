import 'package:flutter/material.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/screen/login/widget/login_form.dart';
import 'package:pinkaid/screen/login/widget/login_logo_widget.dart';

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
            const LoginForm(),
            const SizedBox(height: kSpaceScreenPaddingLg * 2),
            Center(
              child: Text(
                S.of(context).continueW,
                style: KTextTheme.lightTextTheme.bodyMedium,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
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
