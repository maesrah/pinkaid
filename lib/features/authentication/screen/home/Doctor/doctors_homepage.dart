import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/consultation_page.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/patient_page.dart';
import 'package:pinkaid/features/authentication/screen/profile/profilePage.dart';
import 'package:pinkaid/features/notification/notification_service.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_appt_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/datetime_coverted.dart';
import 'package:pinkaid/features/patientsFeatures/privatechatting/chat_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/appointment_screen.dart';
import 'package:pinkaid/separated/separated_list.dart';
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
    final controller = Get.put(DoctorApptController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryLight,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const ProfileScreen());
          },
          icon: const Icon(CupertinoIcons.profile_circled, size: 30),
        ),
        
        centerTitle: true,
        
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
            SizedBox(height: kSpaceScreenPadding,),
             Obx(() {
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
                      return Center(
                          child:  Text('You have no upcoming consultation today',style: KTextTheme.lightTextTheme.bodyMedium,));
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
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _HomeOptionCard(
                    title: 'Calendar',
                    icon: CupertinoIcons.calendar,
                    onTap: () {
                      // Navigate to Consultation Page
                      Get.to(()=>const ConsultationPage());
                    },
                  ),
                  _HomeOptionCard(
                    title: 'Patient',
                    icon: CupertinoIcons.group_solid,
                    onTap: () {
                      // Navigate to Patients Page
                      Get.to(() => const PatientPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
  //     floatingActionButton: TextButton(onPressed: (){

  //       NotificationService().showNotification(title: 'Sample',body: 'meow');
  //        DateTime now = DateTime.now();
  
  // // Let's say you want to schedule the notification for 11:08 AM today
  // DateTime scheduleTime = DateTime(now.year, now.month, now.day, 12,32 );

  // // Call the scheduleNotification method
  //  NotificationService().scheduleNotification(
  //   id: 1, // You can provide a unique ID for the notification
  //   title: 'Scheduled Notification',
  //   body: 'This is your reminder for 11:08 AM!',
  //   scheduledNotificationDateTime: scheduleTime,
  // );
  //     }, child: Text('hi')),
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
            const BoxShadow(
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

class DoctorConsultCard extends StatelessWidget {
  const DoctorConsultCard({
    super.key,
    required this.appt,
  });

  final Appointment appt;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorApptController());
    DateFormat formatter = DateFormat('dd-MM-yy');
    String date = formatter.format(appt.appointmentDate);

    // Check if today is the appointment day and the time has reached
    bool isToday = DateTime.now().toLocal().day == appt.appointmentDate.day;
    bool isTimeReached = DateTime.now().isAfter(appt.appointmentDate.add(Duration(
      hours: int.parse(appt.appointmentTime.split(":")[0]), // Appointment hour
    )));

    

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              offset: const Offset(0.1, 0.1), // Position of the shadow (x, y)
              blurRadius: 0.5, // Blur effect
              spreadRadius: 2, // Spread radius
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSpaceScreenPaddingLg,
              vertical: kSpaceScreenPaddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient name and delete icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appt.patientName.toUpperCase(),
                    style: KTextTheme.lightTextTheme.bodyMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Delete Appointment",
                        middleText:
                            "Are you sure you want to cancel this appointment?",
                        textCancel: "No",
                        textConfirm: "Yes",
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          controller.deleteAppt(appt.id);
                          Get.back();
                        },
                        onCancel: () {
                          Get.back(); // Close the dialog if the user taps "No"
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: kSpaceScreenPadding),
                child: Divider(
                  height: 2,
                  color: Colors.black,
                ),
              ),
              // Appointment time and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Iconsax.clock_copy),
                      const SizedBox(width: kSpaceScreenPadding),
                      Text(appt.appointmentTime),
                    ],
                  ),
                  const SizedBox(width: kSpaceScreenPadding),
                  Text(
                    date,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceScreenPadding),
              Align(
                alignment: Alignment.topRight, // Aligns to the top right
                child: TextButton(
                  onPressed: () {
                    showBottomSheet(
                      context: Get.context!,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          color: Colors.pink,
                          height: 200,
                          width: 200,
                          child: const Text('Patient History'),
                        ),
                      ),
                    );
                  },
                  child: const Text('View patient history'),
                ),
              ),
              const SizedBox(height: 5),
              // Different buttons based on appointment status
              if (appt.status == 'scheduled')
                SeparatedList(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: Text(
                              'Consultation finished?',
                              style: KTextTheme.lightTextTheme.titleSmall,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Write your notes about the patient',
                                  style: KTextTheme.lightTextTheme.bodySmall,
                                ),
                                SizedBox(height: kSpaceScreenPadding),
                                TextField(
                                  onChanged: (value) {
                                    controller.noteText.value = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Enter your note',
                                    border: OutlineInputBorder(),
                                  ),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back(); // Close the dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.updateApptPatient(
                                      appt.id, controller.noteText.value);
                                  Get.back(); // Close the dialog
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      child: Text(
                        'Mark as finished',
                        style: KTextTheme.lightTextTheme.titleSmall,
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (isToday && isTimeReached)
                            ? () {
                                Get.to(() => ChatPage(
                                      receiverId: appt.patientId,
                                      receiverName: appt.patientName,
                                    ));
                              }
                            : null, // Disable if it's not the appointment time
                        child: Text(
                          'Start session',
                          style: KTextTheme.lightTextTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                )
              else if (appt.status == 'completed')
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Your Notes'),
                          content: Text(appt.notes ?? 'No notes available'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('See your notes'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
