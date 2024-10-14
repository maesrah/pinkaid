import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/patientsFeatures/controller/trend_controller.dart';
import 'package:pinkaid/features/patientsFeatures/model/patient_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class MealController extends GetxController {
  var meals = <Map<String, dynamic>>[].obs;

  var filteredMeals = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  Rx<Patient> patient = Patient.empty().obs;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final trencController=Get.put(TrendController());

  @override
  void onInit() {
    super.onInit();
    fetchMeals();
    fetchUserRecord();
    
  }

  // Function to add a custom meal
  void addMeal(Map<String, dynamic> meal) {
    meals.add(meal); // Add the new meal to the list
    filteredMeals.add(meal);
  }

  void searchMeal(String query) {
    if (query.isEmpty) {
      filteredMeals.value =
          List.from(meals); // Copy the full list if query is empty
    } else {
      filteredMeals.value = meals
          .where((meal) => meal['mealName']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList(); // Convert the filtered meals to a list
    }
  }

  var selectedDate = DateTime.now().obs;

  // Method to update date using date picker
  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final patient = await getUserDetails();
      this.patient(patient);
      trencController.updateDailyProgress(patient.dailyTracking);
    } catch (e) {
      patient(Patient.empty());
    } finally {
      isLoading.value = false;
    }
  }

  Future<Patient> getUserDetails() async {
    try {
      isLoading.value = true;
      final documentSnapshot = await _firebaseFirestore
          .collection("Patients")
          .doc(AuthRepository.instance.authUser?.uid)
          .get();
      isLoading.value = false;
      if (documentSnapshot.exists) {
        return Patient.fromSnapshot(documentSnapshot);
      } else {
        return Patient.empty();
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

  Future<void> fetchMeals() async {
    try {
      // Fetch meals from Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Meals').get();

      // Process the retrieved data
      meals.value = snapshot.docs.map((doc) {
        return {
          'mealName': doc['mealName'] ??
              'Unknown', // Adjust key names based on your data structure
          'calories': doc['calories'] ?? 0,
          'nutrient': doc['nutrient'] ?? 0,
          'id': doc['id'] ?? '0',
        };
      }).toList();

      filteredMeals.value = List.from(meals); // Initialize filtered meals
    } catch (e) {
      print('Error fetching meals: $e');
    }
  }

  Future<void> updateMeal(String mealType, String meal, int calories) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      Map<String, dynamic> breakfastEntry = {
        'meal': meal,
        'calories': calories,
      };

      // Update the 'dailyExercises' list for the specific date
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailyMeals.$mealType':
            FieldValue.arrayUnion([breakfastEntry])
      });

      print('Exercise updated for $date');
      onInit();
    } catch (e) {
      print('Error updating exercises: $e');
    }
  }

  Future<void> removeMeal(String mealType, String meal, int calories) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);

      Map<String, dynamic> breakfastEntry = {
        'meal': meal,
        'calories': calories,
      };

      // Update the 'dailyExercises' list for the specific date
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailyMeals.$mealType':
            FieldValue.arrayRemove([breakfastEntry])
      });

      print('Meals removed for $date');
      onInit();
    } catch (e) {
      print('Error removing meals: $e');
    }
  }

   var glassesFilled = 0.obs;

  // Function to update the glasses filled
  void updateGlassesFilled(int value) {
    glassesFilled.value = value;
    updateWaterIntake(glassesFilled.value);
  }

  // Function to reset glasses
  void resetGlasses() {
    glassesFilled.value = 0;
  }

  Future<void> updateWaterIntake(int glass) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.waterIntake': glass,
      });
      print('Sleep hours updated for $date');
      onInit();
    } catch (e) {
      print('Error updating sleep hours: $e');
    }
  }
}
