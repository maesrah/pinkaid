import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/features/authentication/screen/home/patients_home_page.dart';

import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  static const String routeName = 'DoctorHomeScreen';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const DoctorHomeScreen();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryLight,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(PatientsHomePage.route());
            },
            icon: const Icon(
              CupertinoIcons.profile_circled,
              size: 30,
            )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSpaceScreenPadding,
                      vertical: kSpaceScreenPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Hello,',
                          style: KTextTheme.lightTextTheme.headlineMedium),
                      Text(
                        'Michella',
                        style: KTextTheme.lightTextTheme.titleLarge,
                      ),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: kSpaceScreenPaddingLg),
                  decoration: BoxDecoration(
                      color: kColorSecondary,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.calendar,
                          size: 50,
                        ),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      Text(
                        S.of(context).consultationLabel,
                        style: KTextTheme.lightTextTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: kSpaceScreenPaddingLg),
                  decoration: BoxDecoration(
                      color: kColorSecondary,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.group_solid,
                          size: 50,
                        ),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                      Text(
                        S.of(context).communityLabel,
                        style: KTextTheme.lightTextTheme.titleSmall,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
              child: ApptSessionWidget(),
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
              child: CommunityWidget(),
            )
          ],
        ),
      ),
    );
  }
}

class CommunityWidget extends StatelessWidget {
  const CommunityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kColorSecondary, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).expertiseLabel,
              style: KTextTheme.lightTextTheme.headlineSmall,
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).joinLabel,
                    style: KTextTheme.lightTextTheme.labelMedium,
                  ),
                ),
                const SizedBox(
                  width: kSpaceSectionMd,
                ),
                const Image(
                  image: AssetImage('assets/images/hands.png'),
                  height: 100,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ApptSessionWidget extends StatelessWidget {
  const ApptSessionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: kColorSecondary, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    S.of(context).sessionLabel,
                    style: KTextTheme.lightTextTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding - 10,
                  ),
                  Text(
                    maxLines: 2, // Set maxLines to allow wrapping
                    overflow: TextOverflow.ellipsis,
                    S.of(context).scheduleLabel,
                    style: KTextTheme.lightTextTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: kSpaceSectionLg * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: kColorPrimary,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text('Appointment'),
                    ),
                  ),
                ],
              ),
            ),
            const Image(
              image: AssetImage(KImages.medical),
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
