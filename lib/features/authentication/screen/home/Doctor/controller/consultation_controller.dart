import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';

class ConsultationController extends GetxController {
  var selectedDay = DateTime.now().obs;  // Observable for selected date
  var selectedTime = TimeOfDay.now().obs; // Observable for selected time
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Function to update selected day
  void updateSelectedDay(DateTime day) {
    selectedDay.value = day;
  }

  // Function to update selected time
  void updateSelectedTime(TimeOfDay? time) {
    if (time != null) {
      selectedTime.value = time;
    }
  }

  // Function to block date and time in Firestore
  Future<void> blockDateAndTime() async {
    final blockedDateTime = DateTime(
      selectedDay.value.year,
      selectedDay.value.month,
      selectedDay.value.day,
      selectedTime.value.hour,
      selectedTime.value.minute,
    );

    try {
      await _db.collection('appointments').add({
        'doctorId': 'doctor123', // Replace with actual doctor ID
        'blockedTime': blockedDateTime,
      });
      Get.snackbar("Success", "Date and time blocked successfully.");
    } catch (error) {
      Get.snackbar("Error", "Failed to block date and time: $error");
    }
  }

  Future<void> updateBlockDateAndTime(
      ) async {

    try {
    
      DateFormat formatter = DateFormat('dd-MM-yy'); 
      String date = formatter.format(selectedDay.value);
      String formattedTime = selectedTime.value.format(Get.context!);


    Map<String, dynamic> blockedDatesEntry = {
        'date': date,
        'time':selectedTime.value.toString()
      };
     

      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'blockedDates': FieldValue.arrayUnion([blockedDatesEntry]) // Array update
      });

      print('DateBlock added');
      Get.snackbar("Success", "Date and time blocked successfully.");
      //onInit();
    } catch (e) {
      print('Error adding medication: $e');
    }
  }

  Future<void> removeMedication(
      String medication, String frequency, String dosage) async {
    try {
      Map<String, dynamic> medicationEntry = {
        'medical': medication,
        'frequency': frequency,
        'dosage': dosage,
      };

      // Remove the exercise entry from the 'dailyExercises' array
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'medication': FieldValue.arrayRemove([medicationEntry])
      });

      print('Exercise removed for');
      onInit();
    } catch (e) {
      print('Error removing exercise: $e');
    }
  }
}
