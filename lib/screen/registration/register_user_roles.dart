import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pinkaid/generated/l10n.dart';

import 'package:pinkaid/screen/registration/controller/registration_controller.dart';
import 'package:pinkaid/theme/theme.dart';

class RegistrationUserRolePage extends StatefulWidget {
  const RegistrationUserRolePage({
    super.key,
  });

  static const String routeName = 'RegistrationUserRolePage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const RegistrationUserRolePage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<RegistrationUserRolePage> createState() =>
      _RegistrationUserRolePageState();
}

class _RegistrationUserRolePageState extends State<RegistrationUserRolePage> {
  // bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).userRoles,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            Container(
              decoration: BoxDecoration(
                  color: kColorSecondary,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {},
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/doctor.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).doctorLabel,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                        Text(
                          S.of(context).doctorLabelDesc,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            Container(
              decoration: BoxDecoration(
                  color: kColorSecondary,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                onPressed: () {},
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/patient.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).publicLabel,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                        Text(
                          S.of(context).publicLabelDesc,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: kSpaceScreenPaddingLg,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    RegistrationController.instance.nextPage();
                  });
                },
                child: const Icon(Icons.arrow_right_rounded, size: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
