import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/screen/discussion_screen.dart';
import 'package:pinkaid/features/authentication/screen/home/Patient/patients_home_page.dart';

import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/theme.dart';

class PatientBottomNavigationBar extends StatelessWidget {
  const PatientBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            backgroundColor: kColorInfo,
            destinations: [
              NavigationDestination(
                  icon: const Icon(Iconsax.home),
                  label: S.of(context).homeLabel),
              NavigationDestination(
                  icon: const Icon(Iconsax.message),
                  label: S.of(context).forumLabel),
              NavigationDestination(
                  icon: const Icon(Iconsax.diagram),
                  label: S.of(context).trendLabel),
              NavigationDestination(
                  icon: const Icon(Iconsax.calendar),
                  label: S.of(context).consultationLabel),
            ],
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const PatientsHomePage(),
    const DiscussionScreen(),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.red,
    )
  ];

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}
