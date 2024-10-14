import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
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
          backgroundColor: kColorPrimary,
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
    final formattedDate = DateConverted.getDate(DateTime.now());
    final controller = Get.put(DoctorController());
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kSpaceScreenPadding, horizontal: kSpaceScreenPadding),
      child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Shadow color
                  offset:
                      const Offset(0.1, 0.1), // Position of the shadow (x, y)
                  blurRadius: 0.5, // Blur effect
                  spreadRadius: 2, // Spread radiu
                ),
              ]),
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceScreenPaddingLg,
                  vertical: kSpaceScreenPaddingLg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Patient name',
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
                                //controller.deleteAppt(appt.id);
                                Navigator.of(context).pop();
                              },
                              onCancel: () {
                                Navigator.of(context)
                                    .pop(); // Close the dialog if the user taps "No"
                              },
                            );
                          },
                          icon: Icon(Icons.more_vert))
                    ],
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
                          Text(formattedDate)
                        ],
                      ),
                      const SizedBox(
                        width: kSpaceScreenPadding,
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                 Align(
                      alignment:
                          Alignment.topRight, // Aligns to the top right
                      child: TextButton(onPressed: (){
                        showBottomSheet(context: Get.context!, builder: (context) => SingleChildScrollView(
                        child: Container(
                          color: Colors.pink,
                          height: 200,
                          width: 200,
                          child: Text('PatientHistory')),
                      ));
                      }, child: Text('View patient history')),
                    ),
                  
                  const SizedBox(
                    height: 5,
                  ),
                  SeparatedList(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Mark as finished',
                          style: KTextTheme.lightTextTheme.titleSmall,
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
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
    ));
  }
}

class PastPatientHistoryTab extends StatelessWidget {
  const PastPatientHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Display past patient history here.'),
      // You can add a ListView or other widgets to show patient history
    );
  }
}
