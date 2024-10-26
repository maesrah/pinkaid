import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/patient_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class TrendController extends GetxController {
  static TrendController get instance => Get.find();

  var isLoading = false.obs;
  Rx<Patient> patient = Patient.empty().obs;
  var sleepHours = 0.obs; // Observable to track hours

  var height = 0.0.obs;
  var weight = 0.0.obs;

  var selectedExercise = 'Running'.obs;
  var exerciseMinutes = 0.obs;
  final heightControl = TextEditingController();
  final weightControl = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  User? get authUser => _firebaseAuth.currentUser;
  // var symptoms = <String>[].obs; // Observable list of symptoms
  RxList<String> symptoms = <String>[].obs; // Observable list to store symptoms
  final symptomTextController = TextEditingController();
  final medicationNameController = TextEditingController();
  final dosageController = TextEditingController();
  final frequencyController = TextEditingController();
  var touchedBarIndex = (-1).obs;
  var exerciseTouchedBar=(-1).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final patient = await getUserDetails();
      this.patient(patient);
      updateDailyProgress(patient.dailyTracking);
    } catch (e) {
      patient(Patient.empty());
    } finally {
      isLoading.value = false;
    }
  }

  // Method to increment sleep hours
  void incrementHours() {
    sleepHours++;
  }

  bool isNotEmpty(TextEditingController controller) {
    return controller.text.trim().isEmpty;
  }

  // Method to decrement sleep hours
  void decrementHours() {
    if (sleepHours > 0) {
      sleepHours--;
    }
  }

  final mealCountController = TextEditingController();
  final mealDetailsController = TextEditingController();
  final waterIntakeController = TextEditingController();

  // Method to clear all the input fields
  void clearFields() {
    mealCountController.clear();
    mealDetailsController.clear();
    waterIntakeController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is destroyed
    mealCountController.dispose();
    mealDetailsController.dispose();
    waterIntakeController.dispose();
    super.onClose();
  }

  final List<Map<String, dynamic>> exercises = [
    {'name': 'Running', 'icon': Icons.directions_run},
    {'name': 'Cycling', 'icon': Icons.directions_bike},
    {'name': 'Swimming', 'icon': Icons.pool},
    {'name': 'Yoga', 'icon': Icons.self_improvement},
    {'name': 'Weight Lifting', 'icon': Icons.fitness_center},
    {'name': 'Walking', 'icon': Icons.directions_walk},
  ];

  // Observable variables
  //var selectedExercise = 'Running'.obs; // Default selected exercise
  var isOtherSelected = false.obs; // Checkbox state
  final otherExerciseController = TextEditingController();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Method to update a single field in Firebase
  Future<void> updateField(String field, dynamic value) async {
    final user = _firebaseAuth.currentUser;
    try {
      isLoading.value = true;
      await _firebaseFirestore.collection("Patients").doc(user?.uid).update({
        field: value,
      });
      print("$field updated successfully");
      isLoading.value = false;
    } catch (e) {
      print("Error updating $field: $e");
    }
  }

  Future<void> updateHeight(String height) async {
    await updateField('height', height);

    onInit();
  }

  Future<void> updateWeight(String weight) async {
    await updateField('weight', weight);

    onInit();
  }

  // Method to reset fields
  void resetFields() {
    selectedExercise.value = 'Running';
    isOtherSelected.value = false;
    otherExerciseController.clear();
    exerciseMinutes.value = 0;
    symptomTextController.clear();
    medicationNameController.clear();
    dosageController.clear();
    frequencyController.clear();
  }

  // Increment and decrement methods for exercise duration
  void incrementMinutes() {
    exerciseMinutes++;
  }

  void decrementMinutes() {
    if (exerciseMinutes > 0) {
      exerciseMinutes--;
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

  Future<void> updateMeal(String mealType, List<String> meals) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      await _firebaseFirestore
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.$mealType': meals,
      });
    } catch (e) {
      print('Error updating meal: $e');
    }
  }

  Future<void> removeMeal(String mealType, List<String> meals) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.$mealType': FieldValue.arrayRemove(meals),
      });
      print('Meals removed for $date');
      onInit();
    } catch (e) {
      print('Error removing meals: $e');
    }
  }

//var symptoms = <String>[].obs; // List to store symptoms
  var selectedSymptom = ''.obs; // For selected dropdown value
  //TextEditingController symptomTextController = TextEditingController();

  Future<void> updateSymptoms(List<Map<String, dynamic>> symptoms) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);

      // Update the symptoms for the specific date
      await _firebaseFirestore
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .set(
              {
            'dailyTracking.$date.dailySymptom': symptoms,
          },
              SetOptions(
                  merge:
                      true)); // Merge option for updating without overwriting other fields

      print('Symptoms updated for $date');
    } catch (e) {
      print('Error updating symptoms: $e');
    }
  }

  Future<void> updateExercise(String exercise, int minutes) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      Map<String, dynamic> exerciseEntry = {
        'exercise': exercise,
        'minutes': minutes,
      };

      // Update the 'dailyExercises' list for the specific date
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailyExercises':
            FieldValue.arrayUnion([exerciseEntry])
      });

      print('Exercise updated for $date');
      onInit();
    } catch (e) {
      print('Error updating exercises: $e');
    }
  }

  Future<void> removeExercise(String exercise, int minutes) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);

      Map<String, dynamic> exerciseEntry = {
        'exercise': exercise,
        'minutes': minutes,
      };

      // Remove the exercise entry from the 'dailyExercises' array
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailyExercises':
            FieldValue.arrayRemove([exerciseEntry])
      });

      print('Exercise removed for $date');
      onInit();
    } catch (e) {
      print('Error removing exercise: $e');
    }
  }

  Future<void> updateSleepHours(int hours) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.sleepHours': hours,
      });
      print('Sleep hours updated for $date');
      onInit();
    } catch (e) {
      print('Error updating sleep hours: $e');
    }
  }

  Future<void> removeSleepHours() async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.sleepHours': FieldValue.delete(),
      });
      print('Sleep hours removed for $date');
      onInit();
    } catch (e) {
      print('Error removing sleep hours: $e');
    }
  }

  Future<void> addSymptom(String symptom) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);

      // Create a map for the symptom entry, similar to exerciseEntry
      Map<String, dynamic> symptomEntry = {
        'symptom': symptom,
      };

      // Add the symptom entry to the 'dailySymptom' list for the specific date
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailySymptom':
            FieldValue.arrayUnion([symptomEntry])
      });

      onInit();

      print('Symptom added for $date');
    } catch (e) {
      print('Error adding symptom: $e');
    }
  }

  Future<void> removeSymptom(String symptom) async {
    try {
      DateTime now = DateTime.now(); // Current date and time
      DateFormat formatter = DateFormat('dd-MM-yy'); // Define format
      String date = formatter.format(now);

      Map<String, dynamic> symptomEntry = {
        'symptom': symptom,
      };

      // Remove the exercise entry from the 'dailyExercises' array
      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'dailyTracking.$date.dailySymptom':
            FieldValue.arrayRemove([symptomEntry])
      });
      onInit();
    } catch (e) {
      print('Error removing symptom: $e');
    }
  }

  Future<void> updateMedication(
      String medication, String frequency, String dosage) async {
    try {
      Map<String, dynamic> medicationEntry = {
        'medical': medication,
        'frequency': frequency,
        'dosage': dosage,
      };

      await FirebaseFirestore.instance
          .collection('Patients')
          .doc(AuthRepository.instance.authUser?.uid)
          .update({
        'medication': FieldValue.arrayUnion([medicationEntry]) // Array update
      });

      print('Medication added');
      onInit();
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

  var percentageIndicator =
      0.0.obs; // This will track the progress percentage (0.0 to 1.0)

void updateDailyProgress(Map<String, dynamic> dailyData) {
  int totalTasks = 3; // Total number of tasks (e.g., sleep, meals, water intake)
  int completedTasks = 0;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yy');
  String formattedDate = formatter.format(now);

  // Check if the date exists in the system
  if (dailyData.containsKey(formattedDate)) {
    bool hasSleep = dailyData[formattedDate]['sleepHours'] != null &&
        dailyData[formattedDate]['sleepHours'] > 0;
    bool hasMeals = dailyData[formattedDate]['dailyMeals'] != null;
    bool hasWaterIntake = dailyData[formattedDate]['waterIntake'] != null &&
        dailyData[formattedDate]['waterIntake'] > 0;

    if (hasSleep) completedTasks++; // 1/3 progress if sleep is filled
    if (hasMeals) completedTasks++; // 2/3 progress if meals are filled
    if (hasWaterIntake) completedTasks++; // 3/3 progress if water intake is filled
  }

  // Calculate percentage as a fraction of completed tasks
  double percentage = completedTasks / totalTasks;
  percentageIndicator.value = percentage; 
  onInit();
}



}
