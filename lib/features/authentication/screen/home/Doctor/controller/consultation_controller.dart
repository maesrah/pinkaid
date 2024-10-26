import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class ConsultationController extends GetxController {
  var selectedDay = DateTime.now().obs; // Observable for selected date
  var selectedTime = TimeOfDay.now().obs; // Observable for selected time
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var selectedIndex = (-1).obs;
    final profileLoading = false.obs;

  var selectedDays = <DateTime>[].obs; 

  @override
  onInit(){
    super.onInit();
    //getDoctorDetails();
    fetchBlockedDates(); 
  }

  void updateSelectedDays(DateTime selectedDay) {
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else if (selectedDays.length < 3) {
      // Allow only 2-3 days
      selectedDays.add(selectedDay);
    } else {
      Get.snackbar('Limit reached', 'You can only select up to 3 days.');
    }
  }

  // Function to update selected time
  void updateSelectedTime(TimeOfDay? time) {
    if (time != null) {
      selectedTime.value = time;
    }
  }

  void selectTime(int index) {
    selectedIndex.value = index;
  }

  // Function to block date and time in Firestore

  Future<void> updateBlockDateAndTime() async {
    try {
      // Date formatting for each selected day
      DateFormat formatter = DateFormat('dd-MM-yy');

      // Loop through each selected day and add to Firebase
      for (var day in selectedDays) {
        String date = formatter.format(day);

        Map<String, dynamic> blockedDatesEntry = {
          'date': date,
          'time': selectedTime.value
              .toString(), // Adjust based on how you're selecting time
        };

        await FirebaseFirestore.instance
            .collection('Doctors')
            .doc(AuthRepository.instance.authUser?.uid)
            .update({
          'blockedDates':
              FieldValue.arrayUnion([blockedDatesEntry]) // Add each block entry
        });
      }

      print('DateBlock(s) added');
      Get.snackbar("Success", "Date(s) and time(s) blocked successfully.");
      onInit();
      selectedDays.clear();
    } catch (e) {
      print('Error adding block dates and times: $e');
      Get.snackbar("Error", "Failed to block the date(s) and time(s).");
    }
  }

 Rx<Doctor> doc = Doctor.empty().obs;
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final doc = await getDoctorDetails();
      this.doc(doc);
      //print(user.toString());
    } catch (e) {
    doc(Doctor.empty());
    } finally {
      profileLoading.value = false;
    }
  }

   Future<Doctor> getDoctorDetails() async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection("Doctor")
          .doc(AuthRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return Doctor.fromSnapshot(documentSnapshot);
      } else {
        return Doctor.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

   var blockedSchedule= <Map<String, dynamic>>[].obs; // Observable list to hold blocked dates

  // Fetch blocked dates from Firestore
  Future<void> fetchBlockedDates() async {
    try {
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(AuthRepository.instance.authUser?.uid)
          .get();

      if (doctorDoc.exists) {
        var data = doctorDoc.data() as Map<String, dynamic>;

        if (data.containsKey('blockedDates')) {
          blockedSchedule.value = List<Map<String, dynamic>>.from(data['blockedDates']);
        } else {
          blockedSchedule.clear();
        }
      }
    } catch (e) {
      print('Error fetching blocked dates: $e');
    }
  }

  Future<void> removeBlockedDate(Map<String, dynamic> blockedDate) async {
  try {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(AuthRepository.instance.authUser?.uid)
        .update({
      'blockedDates': FieldValue.arrayRemove([blockedDate])
    });

    blockedSchedule.remove(blockedDate); // Remove locally after successful deletion
    Get.snackbar("Success", "Blocked date removed successfully.");
  } catch (e) {
    print('Error removing blocked date: $e');
  }
}

}
