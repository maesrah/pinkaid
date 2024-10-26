import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/patientsFeatures/controller/appt_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';
import 'package:pinkaid/features/patientsFeatures/controller/post_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/datetime_coverted.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/privatechatting/chat_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/book_consultation.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/list_doctors_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/post_card.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/separated/separated_list.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Consultation',
          style: KTextTheme.lightTextTheme.titleMedium,
        ),
        backgroundColor: kColorPrimaryOne.withOpacity(0.7),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointment today',
                style: KTextTheme.lightTextTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kSpaceScreenPadding),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center();
                }

                return FutureBuilder(
                  future: controller.fetchAppointment(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading appointment'));
                    } else if (!snapshot.hasData ||
                        controller.doctorsList.isEmpty) {
                      return const Center(
                          child: const Text('No appointment today'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.apptsList.length,
                        itemBuilder: (_, index) => ConsultationCard(
                          appt: controller.apptsList[index],
                        ),
                      );
                    }
                  }),
                );
              }),
              const SizedBox(height: kSpaceScreenPaddingLg),
              Text(
                'List of doctors and healthcare',
                style: KTextTheme.lightTextTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kSpaceScreenPadding),
              FutureBuilder(
                future: controller.fetchDoctor(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading doctors'));
                  } else if (!snapshot.hasData ||
                      controller.doctorsList.isEmpty) {
                    return const Center(
                        child: const Text('No doctors available'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.doctorsList.length,
                      itemBuilder: (_, index) => DoctorCard(
                        doctor: controller.doctorsList[index],
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSpaceScreenPadding),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
        width: MediaQuery.of(context).size.width,
        //height: 200,

        decoration: BoxDecoration(
            color: kColorInfo, borderRadius: BorderRadius.circular(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSpaceScreenPadding,
                    vertical: kSpaceScreenPadding),
                child: CircleAvatar(
                  radius:
                      40, // Adjust the radius to make the CircleAvatar bigger
                  backgroundColor:
                      Colors.grey.shade200, // Optional: Set a background color
                  child: ClipOval(
                    child: Image.network(
                      doctor.profImage,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () {
                Get.to(BookConsultation(
                  doctor: doctor,
                ));
              },
              child: SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      doctor.fullName,
                      style: KTextTheme.lightTextTheme.headlineSmall,
                    ),
                    //const SizedBox(height: 8,),
                    Text(
                      doctor.workExperience,
                      style: KTextTheme.lightTextTheme.bodySmall,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    kColorPrimaryOne.withOpacity(0.8),
                                foregroundColor: Colors.black),
                            onPressed: () {
                              Get.to(() => BookConsultation(
                                    doctor: doctor,
                                  ));
                            },
                            child: const Text(
                              'Book',
                            )),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({
    super.key,
    required this.appt,
  });

  final Appointment appt;
  @override
  Widget build(BuildContext context) {
    //final formattedTime = DateConverted.getTime(appt.appointmentTime);
    //final formattedDate = DateConverted.getDate(appt.appointmentDate);
    final controller = Get.put(DoctorController());
    DateFormat formatter = DateFormat('dd-MM-yy');
    String date = formatter.format(appt.appointmentDate);

    // Check if today is the appointment day and the time has reached
    bool isToday = DateTime.now().toLocal().day == appt.appointmentDate.day;
    bool isTimeReached =
        DateTime.now().isAfter(appt.appointmentDate.add(Duration(
      hours: int.parse(appt.appointmentTime.split(":")[0]), // Appointment hour
    )));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kColorSecondaryLight),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceScreenPaddingLg,
                  vertical: kSpaceScreenPaddingLg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appt.doctorName,
                    style: KTextTheme.lightTextTheme.bodyLarge,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kSpaceScreenPadding),
                    child: Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Iconsax.clock_copy),
                          const SizedBox(
                            width: kSpaceScreenPadding,
                          ),
                          Text(appt.appointmentTime)
                        ],
                      ),
                      const SizedBox(
                        width: kSpaceScreenPadding,
                      ),
                      Text(
                        date,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  SeparatedList(
                    children: [
                      OutlinedButton(
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
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              Navigator.of(context)
                                  .pop(); // Close the dialog if the user taps "No"
                            },
                          );
                        },
                        child: Text(
                          'Cancel',
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
                  ),
                ],
              ))),
    );
  }
}
