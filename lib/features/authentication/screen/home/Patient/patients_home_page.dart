import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';
import 'package:pinkaid/features/authentication/screen/profile/profilePage.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PatientsHomePage extends StatelessWidget {
  const PatientsHomePage({super.key});
  static const String routeName = 'PatientsHomePage';

  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return const PatientsHomePage();
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final List<String> discussions = [
      'Discussion 1',
      'Discussion 2',
      'Discussion 3',
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.question_circle))
        ],
        leading: IconButton(
            onPressed: () {
              Get.to(() => const ProfileScreen());
            },
            icon: const Icon(CupertinoIcons.profile_circled)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).helloLabel,
                      style: KTextTheme.lightTextTheme.titleLarge,
                    ),
                    Obx(
                      () => Text(
                        controller.user.value.fullName,
                        style: KTextTheme.lightTextTheme.titleLarge,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: kColorPrime,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSpaceScreenPaddingLg,
                        vertical: kSpaceScreenPaddingLg),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          S.of(context).quizHeader,
                          style: KTextTheme.lightTextTheme.bodyLarge,
                        )),
                        Image.asset(
                          'assets/icons/badge.png',
                          height: 100,
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceScreenPadding,
                            vertical: kSpaceScreenPadding),
                        decoration: BoxDecoration(
                            color: kColorSecondaryLight,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Iconsax.document_favorite_copy,
                              size: 50,
                            ),
                            Text(
                              S.of(context).journeyHeader,
                              style: KTextTheme.lightTextTheme.titleSmall,
                            ),
                            Text(
                              S.of(context).journeySub,
                              style: KTextTheme.lightTextTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceScreenPadding,
                            vertical: kSpaceScreenPadding),
                        decoration: BoxDecoration(
                            color: kColorInfo,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Iconsax.profile_2user_copy,
                              size: 50,
                            ),
                            Text(
                              S.of(context).bookConsultTitle,
                              style: KTextTheme.lightTextTheme.titleSmall,
                            ),
                            Text(
                              S.of(context).doctorSub,
                              style: KTextTheme.lightTextTheme.bodySmall,
                            ),
                            Text(
                              S.of(context).rescheduleTitle,
                              style: KTextTheme.lightTextTheme.bodySmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).discussionTitle),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.arrow_right_1_copy))
                ],
              ),
              discussions.isEmpty
                  ? const Text('No data')
                  //
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: discussions
                              .map(
                                (item) => SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kSpaceSectionSm),
                                    child: DiscussionWidget(
                                      title: 'BreastCancer',
                                      description: 'Meow meow',
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscussionWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl; // Image URL can be null

  const DiscussionWidget({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
      decoration: BoxDecoration(
          color: kColorPrimaryLight, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null) // Check if imageUrl is not null
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200, // You can adjust the height as needed
              ),
            ),
          Text(
            title,
            style: KTextTheme.lightTextTheme.headlineSmall,
          ),
          Text(
            description,
            style: KTextTheme.lightTextTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
