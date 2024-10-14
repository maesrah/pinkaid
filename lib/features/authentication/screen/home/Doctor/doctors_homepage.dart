import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/consultation_page.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/patient_page.dart';
import 'package:pinkaid/features/authentication/screen/profile/profilePage.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/generated/l10n.dart';

class DoctorHomeScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryLight,
        leading: IconButton(
          onPressed: () {
            Get.to(() => ProfileScreen());
          },
          icon: const Icon(CupertinoIcons.profile_circled, size: 30),
        ),
        
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kSpaceScreenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Doctor',
              style: KTextTheme.lightTextTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _HomeOptionCard(
                    title: S.of(context).consultationLabel,
                    icon: CupertinoIcons.calendar,
                    onTap: () {
                      // Navigate to Consultation Page
                      Get.to(()=>ConsultationPage());
                    },
                  ),
                  _HomeOptionCard(
                    title: 'Patient',
                    icon: CupertinoIcons.group_solid,
                    onTap: () {
                      // Navigate to Patients Page
                      Get.to(() => PatientPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeOptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kColorSecondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.black),
            const SizedBox(height: 10),
            Text(
              title,
              style: KTextTheme.lightTextTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
