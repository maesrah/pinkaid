import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/screen/registration/controller/registration_controller.dart';
import 'package:pinkaid/screen/registration/register_basic_info.page.dart';
import 'package:pinkaid/screen/registration/register_user_roles.dart';
import 'package:pinkaid/separated/separated_list.dart';
import 'package:pinkaid/theme/theme.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static const String routeName = 'RegistrationPage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const RegistrationPage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    const int initialStepValue = 1;

    final step = ValueNotifier(initialStepValue);
    final controller = Get.put(RegistrationController());

    final pages = [
      const RegistrationUserRolePage(),
      const RegistrationBasicInfoPage(),
    ];

    String resolvePageTitle(int step) {
      switch (step) {
        case 1:
          return S.of(context).userRoles;
        case 2:
          return S.of(context).personalInfoLabel;
        default:
          return S.of(context).userRoles;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).registration,
          ),
          leading: BackButton(
            onPressed: () {
              if (step.value <= 1) {
                Navigator.of(context).maybePop();
              } else {
                RegistrationController.instance.previousPage();
              }
            },
          ),
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(kToolbarHeight + 16),
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: kColorSecondary,
          //       border: Border(
          //         top: BorderSide(color: Colors.grey),
          //       ),
          //     ),
          //     child: ValueListenableBuilder(
          //       valueListenable: step,
          //       builder: (context, value, child) {
          //         return SeparatedList(
          //             padding: const EdgeInsets.only(
          //               left: kSpaceScreenPadding,
          //               right: kSpaceScreenPadding,
          //               bottom: 10,
          //               top: 10,
          //             ),
          //             separator: const SizedBox(width: kSpaceScreenPadding),
          //             children: [
          //               CircularPercentIndicator(
          //                 radius: 24,
          //                 animation: true,
          //                 animationDuration: 1200,
          //                 percent: (value / pages.length),
          //                 center: Text(
          //                   '$value / ${pages.length}',
          //                   style: Theme.of(context)
          //                       .textTheme
          //                       .bodySmall
          //                       ?.copyWith(color: kColorOnLight)
          //                       .apply(fontWeightDelta: 3),
          //                   textAlign: TextAlign.center,
          //                 ),
          //                 circularStrokeCap: CircularStrokeCap.butt,
          //                 backgroundColor: Colors.green,
          //                 progressColor: kColorPrimary,
          //                 animateFromLastPercent: true,
          //               ),
          //               Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       '$value / ${pages.length}',
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodySmall
          //                           ?.copyWith(color: kColorOnLight),
          //                     ),
          //                     const SizedBox(height: 2),
          //                     Text(
          //                       resolvePageTitle(value),
          //                       style: Theme.of(context)
          //                           .textTheme
          //                           .bodySmall
          //                           ?.copyWith(color: kColorOnLight)
          //                           .apply(fontSizeDelta: 4),
          //                     ),
          //                   ])
          //             ]);
          //       },
          //     ),
          //   ),
          // ),
        ),
        body:
            // const RegistrationUserRolePage(),

            Stack(
          children: [
            PageView(
              controller: controller.pageController,
              onPageChanged: controller.updatePageIndicator,
              children: pages,
            ),
          ],
        ));
  }
}
