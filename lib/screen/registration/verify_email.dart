import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/screen/login/login.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class EmailVerifyPage extends StatelessWidget {
  const EmailVerifyPage({super.key});
  static const String routeName = 'EmailVerifyPage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const EmailVerifyPage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Get.offAll(const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: kSpaceScreenPaddingLg,
              ),
              const Icon(
                Icons.mail_outline,
                size: 200,
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Text(
                S.of(context).verifyEmailLabel,
                style: KTextTheme.lightTextTheme.headlineSmall,
              ),
              Text(S.of(context).sentEmailLabel),
              const SizedBox(
                height: kSpaceScreenPadding * 4,
              ),
              ElevatedButton(
                  onPressed: () {}, child: Text(S.of(context).continueLabel)),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kColorPrimaryLight),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Change color here
                ),
                child: Text(S.of(context).resendLabel),
              )
            ],
          ),
        ),
      ),
    );
  }
}
