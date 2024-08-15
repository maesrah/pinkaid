import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/model/datetime_coverted.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/screen/consultationmodule/list_doctors_page.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class BookConsultation extends StatelessWidget {
  const BookConsultation({super.key,
  required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    CalendarFormat _format = CalendarFormat.month;
    DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
  String? token; 
    return Scaffold(appBar:AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Iconsax.arrow_circle_left_copy)),
              title: const Text('Book consultation'),
        ),
        body: CustomScrollView(slivers: [SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kSpaceScreenPadding,horizontal: kSpaceScreenPaddingLg),
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
                    radius: 50, // Adjust the radius to make the CircleAvatar bigger
                    backgroundColor: Colors.grey.shade200, // Optional: Set a background color
                    child: ClipOval(
                    child: Image.network(
                    doctor.profImage,
                    width: 100, 
                    height: 100, 
                    fit: BoxFit.cover, 
                    ),
                  ),
                  ),
                  SizedBox(width: 10,),
                SizedBox(
                  width: 230,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(doctor.fullName,style: KTextTheme.lightTextTheme.headlineSmall,),
                    const SizedBox(height: kSpaceScreenPadding,),
                    Text(
                      doctor.position,
                      style: KTextTheme.lightTextTheme.headlineSmall!.copyWith(fontSize: 16),
                    ),
                     const SizedBox(height: kSpaceScreenPadding,),
                    ],
                  ),
                )
                ],),
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Text('Experience',style: KTextTheme.lightTextTheme.headlineSmall,),
              
              
              Text(doctor.workExperience,style: KTextTheme.lightTextTheme.labelSmall,),
              const SizedBox(height: kSpaceScreenPaddingLg,),
              // Text('Time slot',style: KTextTheme.lightTextTheme.headlineSmall,),
             
              // Text('Experience',style: KTextTheme.lightTextTheme.labelSmall,),
              Text('Select A Date',style: KTextTheme.lightTextTheme.headlineSmall,),
             TableCalendar(
                focusedDay: _focusDay,
                firstDay: DateTime.now(),
                lastDay: DateTime.now(),
                calendarFormat: _format,
                currentDay: _currentDay,
                rowHeight: 48,
                calendarStyle: const CalendarStyle(
          todayDecoration:
             BoxDecoration(color: kColorPrimary, shape: BoxShape.circle),
                ),
                availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
                },
                onFormatChanged: (format) {
              
            _format = format;
          
                },
                onDaySelected: ((selectedDay, focusedDay) {
          // setState(() {
            _currentDay = selectedDay;
            _focusDay = focusedDay;
            _dateSelected = true;
          
            //check if weekend is selected
            if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
              _isWeekend = true;
              _timeSelected = false;
              _currentIndex = null;
            } else {
              _isWeekend = false;
            }
                //  });
                }),
              ),
              SizedBox(height: kSpaceScreenPaddingLg,),
              Text('Select Consultation Time',style: KTextTheme.lightTextTheme.headlineSmall,),],))),
               _isWeekend
                ? SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      alignment: Alignment.center,
                      child: const Text(
                        'Weekend is not available, please select another date',
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
                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            // setState(() {
                            //   _currentIndex = index;
                            //   _timeSelected = true;
                            // });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _currentIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: _currentIndex == index
                                  ? kColorPrimary
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 9}:00 ${index + 9 > 11 ? "PM" : "AM"}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    _currentIndex == index ? Colors.white : null,
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: 8,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1.5),
                  ),
                   SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(kSpaceScreenPadding),
              child: ElevatedButton(
                
                onPressed: () {  },
                child: Padding(
                  padding: const EdgeInsets.all(kSpaceScreenPadding),
                  child: Text('Book an appointment',style: KTextTheme.lightTextTheme.headlineSmall,),
                ),),
              // child: Button(
              //   width: double.infinity,
              //   title: 'Make Appointment',
              //   onPressed: () async {
              //     //convert date/day/time into string first
              //     final getDate = DateConverted.getDate(_currentDay);
              //     final getDay = DateConverted.getDay(_currentDay.weekday);
              //     final getTime = DateConverted.getTime(_currentIndex!);

              //     // final booking = await DioProvider().bookAppointment(
              //     //     getDate, getDay, getTime, doctor['doctor_id'], token!);

              //     //if booking return status code 200, then redirect to success booking page

              //     if (booking == 200) {
                   
              //     }
              //   },
              //   disable: _timeSelected && _dateSelected ? false : true,
              // ),
            ),
          ),
        ],
      ),
            
             
          );
       
  }
}