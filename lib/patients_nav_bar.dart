import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/appointment_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/discussion_screen.dart';
import 'package:pinkaid/features/authentication/screen/home/Patient/patients_home_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/info_main_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/information_module/info_main_page_second.dart';
import 'package:pinkaid/features/patientsFeatures/screen/activity_module/trend_screen.dart';

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
            indicatorColor: kColorPrimaryOne.withOpacity(0.1),
            selectedIndex: controller.selectedIndex.value,
            indicatorShape: UnderlineInputBorder(),
            backgroundColor: kColorPrimary.withOpacity(0.1),
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            //backgroundColor: kColorPrimaryOne.withOpacity(0.7),
            destinations: [
              NavigationDestination(
                  icon: const Icon(Iconsax.home,color: Colors.black,),
                  label: S.of(context).homeLabel),
              const NavigationDestination(
                  icon: Icon(Iconsax.book_1,color: Colors.black,),
                  label: 'Info'),
              
              NavigationDestination(
                  icon: Icon(Iconsax.diagram, color: Colors.black,),
                  label: S.of(context).activityLabel),
              const NavigationDestination(
                  icon: Icon(Iconsax.calendar,color: Colors.black,),
                  label: 'Consult'),
                  NavigationDestination(
                  icon: const Icon(Iconsax.message,color: Colors.black,),
                  label: S.of(context).forumLabel),
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
     const InfoScreen(),
    //  const InfoMainPageSecond(),
    
   const HealthTrendPage(),
    const AppointmentPage(),
    const DiscussionScreen(),
  ];

  void selectTab(int index) {
    selectedIndex.value = index;
  }
}
