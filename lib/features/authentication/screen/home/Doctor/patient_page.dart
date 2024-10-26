import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/doctors_homepage.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_appt_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';


import 'package:pinkaid/features/patientsFeatures/model/datetime_coverted.dart';
import 'package:pinkaid/separated/separated_list.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColorPrimaryOne.withOpacity(0.7),
          leading: IconButton(onPressed: (){
            Get.to(()=>DoctorHomeScreen());
          }, icon: Icon(Icons.arrow_back)),
          title: Text('Patient Page'),
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: 'Schedule Appointment'),
              Tab(text: 'Past Patient History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScheduleAppointmentTab(),
            PastPatientHistoryTab(),
          ],
        ),
      ),
    );
  }
}

class ScheduleAppointmentTab extends StatelessWidget {
  const ScheduleAppointmentTab({
    super.key,
    //required this.appt,
  });
  //final Appointment appt;

  @override
  Widget build(BuildContext context) {
   // final formattedDate = DateConverted.getDate(DateTime.now());
   final controller = Get.put(DoctorApptController());
   
    return  SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kSpaceScreenPadding, horizontal: kSpaceScreenPadding),
          child:  Obx(() {
                if (controller.isLoading.value) {
                  return const Center();
                }

                return FutureBuilder(
                  future: controller.fetchDoctorAppointment(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading appointment'));
                    } else if (!snapshot.hasData ||
                        controller.doctorApptList.isEmpty) {
                      return const Center(
                          child: const Text('No appointment today'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.doctorApptList.length,
                        itemBuilder: (_, index) => DoctorConsultCard(
                          appt: controller.doctorApptList[index],
                        ),
                      );
                    }
                  }),
                );
              }),
        ));
  }
}

class PastPatientHistoryTab extends StatelessWidget {
  const PastPatientHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorApptController());
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: kSpaceScreenPadding, horizontal: kSpaceScreenPadding),
          child:  Obx(() {
                if (controller.isLoading.value) {
                  return const Center();
                }

                return FutureBuilder(
                  future: controller.fetchPastAppointment(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading appointment'));
                    } else if (!snapshot.hasData ||
                        controller.doctorPastList.isEmpty) {
                      return const Center(
                          child: const Text('No appointment today'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.doctorPastList.length,
                        itemBuilder: (_, index) => DoctorConsultCard(
                          appt: controller.doctorPastList[index],
                        ),
                      );
                    }
                  }),
                );
              }),
        ));
  }
}
