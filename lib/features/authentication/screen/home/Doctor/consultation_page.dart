import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/controller/consultation_controller.dart';
import 'package:table_calendar/table_calendar.dart'; // Calendar package
import 'package:pinkaid/theme/theme.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the ConsultationController
    final ConsultationController controller = Get.put(ConsultationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryLight,
        title: Text(
          'Consultation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: ConsultationBody(),
    );
  }
}

class ConsultationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ConsultationController controller = Get.find();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Calendar to select the date
          Obx(() => TableCalendar(
                focusedDay: controller.selectedDay.value,
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 365)),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) =>
                    isSameDay(controller.selectedDay.value, day),
                onDaySelected: (selectedDay, focusedDay) {
                  controller.updateSelectedDay(selectedDay);
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: kColorPrimary,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: kColorSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
              )),
          const SizedBox(height: 20),

          // Button to select time slot
          // Obx(() => ElevatedButton(
          //       onPressed: () async {
          //         TimeOfDay? selectedTime = await showTimePicker(
          //           context: context,
          //           initialTime: controller.selectedTime.value,
          //         );
          //         controller.updateSelectedTime(selectedTime);
          //       },
          //       child: Text(
          //         controller.selectedTime.value == null
          //             ? 'Select a Time Slot'
          //             : 'Selected Time: ${controller.selectedTime.value.format(context)}',
          //       ),
          //     )),

          const SizedBox(height: 20),

          // Button to block date and time
          ElevatedButton(
            onPressed: () {
              controller.updateBlockDateAndTime();
            },
            child: const Text('Block Date and Time'),
          ),
        ],
      ),
    );
  }
}
