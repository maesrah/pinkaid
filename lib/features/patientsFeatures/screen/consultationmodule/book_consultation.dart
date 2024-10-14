import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/controller/doctor_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class BookConsultation extends StatelessWidget {
  BookConsultation({super.key, required this.doctor});

  final Doctor doctor;
  final DoctorController controller = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    // Fetch unavailable bookings when the page is initialized
    controller.selectedIndex.value = -1;
    //controller.fetchUnavailable(doctor);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
        title: const Text('Book consultation'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kSpaceScreenPadding,
                horizontal: kSpaceScreenPaddingLg,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius:
                              50, // Adjust the radius to make the CircleAvatar bigger
                          backgroundColor: Colors.grey
                              .shade200, // Optional: Set a background color
                          child: ClipOval(
                            child: Image.network(
                              doctor.profImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 230,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.fullName,
                                style: KTextTheme.lightTextTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: kSpaceScreenPadding,
                              ),
                              Text(
                                doctor.position,
                                style: KTextTheme.lightTextTheme.headlineSmall!
                                    .copyWith(fontSize: 16),
                              ),
                              const SizedBox(
                                height: kSpaceScreenPadding,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  Text(
                    'Experience',
                    style: KTextTheme.lightTextTheme.headlineSmall,
                  ),
                  Text(
                    doctor.workExperience,
                    style: KTextTheme.lightTextTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Text(
                    'Select A Date',
                    style: KTextTheme.lightTextTheme.headlineSmall,
                  ),
                  Obx(() {
                    return TableCalendar(
                      focusedDay: controller.selectedDate.value,
                      firstDay: DateTime.now(),
                      lastDay: DateTime.now().add(Duration(days: 365)),
                      calendarFormat: CalendarFormat.month,
                      currentDay: controller.selectedDate.value,
                      rowHeight: 48,
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: kColorPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        controller.selectDate(selectedDay, doctor);
                        //controller.fetchUnavailable(doctor, selectedDay);
                      },
                    );
                  }),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Text(
                    'Select Consultation Time',
                    style: KTextTheme.lightTextTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return controller.isWeekend.value || controller.isBlocked.value
                ? SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      alignment: Alignment.center,
                      child: const Text(
                        'This doctor is not available on the selected date.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final timeSlot =
                            '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}';

                        // Wrap the time slot availability logic inside Obx
                        return Obx(() {
                          // Dynamically check if the time slot is unavailable
                          bool isUnavailable =
                              controller.unavailableList.any((appt) {
                            return appt.appointmentDate.year ==
                                    controller.selectedDate.value.year &&
                                appt.appointmentDate.month ==
                                    controller.selectedDate.value.month &&
                                appt.appointmentDate.day ==
                                    controller.selectedDate.value.day &&
                                appt.appointmentTime == timeSlot;
                          });

                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: isUnavailable
                                ? null // Do nothing if the time slot is unavailable
                                : () {
                                    controller.selectTime(index, doctor);
                                  },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.selectedIndex.value == index
                                      ? Colors.white
                                      : isUnavailable
                                          ? Colors.grey
                                          : Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: controller.selectedIndex.value == index
                                    ? kColorPrimary
                                    : isUnavailable
                                        ? Colors.grey.shade300
                                        : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                timeSlot,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.selectedIndex.value == index
                                      ? Colors.white
                                      : isUnavailable
                                          ? Colors.grey
                                          : null,
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      childCount: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns
                      childAspectRatio: 1.5, // Aspect ratio of each item
                    ),
                  );
          }),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(kSpaceScreenPadding),
              child: Obx(() {
                return ElevatedButton(
                  onPressed: controller.selectedIndex.value == -1
                      ? null
                      : () {
                          controller.bookAppointment(
                              doctor.id, doctor.fullName);
                          controller.selectedDate.value = DateTime.now();

                          // Reset the selected time index (no time is selected)
                          controller.selectedIndex.value = -1;
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedIndex.value == -1
                        ? Colors.grey
                        : kColorPrimary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kSpaceScreenPadding),
                    child: Text('Book an appointment',
                        style: KTextTheme.lightTextTheme.headlineSmall),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
