import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/controller/consultation_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:table_calendar/table_calendar.dart'; // Calendar package
import 'package:pinkaid/theme/theme.dart';

class ConsultationPage extends StatelessWidget {
  const ConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the ConsultationController
    final controller = Get.put(ConsultationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryLight,
        title: Text(
          'Consultation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unavailable dates',
              style: KTextTheme.lightTextTheme.titleSmall,
            ),
            SizedBox(
              height: kSpaceScreenPadding,
            ),
            Obx(() {
              return controller.blockedSchedule.isEmpty
                  ? Center(
                      child: Text('No blocked dates found.'),
                    )
                  : Column(
                      children: List.generate(
                        controller.blockedSchedule.length,
                        (index) {
                          var blockedDate = controller.blockedSchedule[index];
                          return ListTile(
                            title: Text('Blocked Date: ${blockedDate['date']}'),
                            subtitle: Text('Blocked Time: ${blockedDate['time']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                 controller.removeBlockedDate(blockedDate);
                              },
                            ),
                          );
                        },
                      ),
                    );
            }),
            const SizedBox(height: 20),
            Obx(() => TableCalendar(
                  focusedDay: controller.selectedDays.isNotEmpty
                      ? controller.selectedDays.last
                      : DateTime.now(),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: 365)),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) {
                    // Highlight only the days selected by the user
                    return controller.selectedDays.contains(day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.updateSelectedDays(selectedDay);
                  },
                  rowHeight: 48,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent, // Make today’s decoration transparent
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange, // Color for selected days
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(color: Colors.black),
                  ),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateBlockDateAndTime();
              },
              child: const Text('Block Date and Time'),
            ),
          ],
        ),
      ),
    );
  }
}
