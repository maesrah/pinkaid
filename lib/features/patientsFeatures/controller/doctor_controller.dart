import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/api.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/data/repositories/doctor/doctor_repository.dart';
import 'package:pinkaid/data/repositories/post/post_repository.dart';

import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/pick_image.dart';
import 'package:pinkaid/utils/utils.dart';
import 'package:uuid/uuid.dart';

class DoctorController extends GetxController {
  static DoctorController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  RxList<Doctor> doctorsList = <Doctor>[].obs;
  RxList<Appointment> apptsList = <Appointment>[].obs;
  RxList<Appointment> unavailableList = <Appointment>[].obs;
  final _categoryId = ''.obs;
  RxBool tabStatus = false.obs;
  String get categoryId => _categoryId.value;
  set categoryId(String value) => _categoryId.value = value;
  final DoctorRepository _doctorRepository = DoctorRepository();
  final apiService = Api();
  var selectedDate = DateTime.now().obs;
  var selectedIndex = (-1).obs; // -1 means no time slot selected
  var isWeekend = false.obs;
  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);
  final caption = TextEditingController();
  final title = TextEditingController();
  final userRepository = Get.put(UserRepository());
  RxBool isBlocked = false.obs;
  RxBool isUnavailable = false.obs;
  var timeSlot =''.obs;

 void selectDate(DateTime date, Doctor doctor) async {
  selectedDate.value = date;

  // Initially assume it's not blocked
  isBlocked.value = false;
  isWeekend.value = date.weekday == 6 || date.weekday == 7; // Check if it's a weekend

  // Format the date to compare with blocked dates
  DateFormat formatter = DateFormat('dd-MM-yy');
  String dateFormat = formatter.format(date);
  List<Map<String, dynamic>> dateBlock = doctor.blockedDates;

  // Check if the selected date is in the blocked dates list
  for (var entry in dateBlock) {
    if (entry['date'] == dateFormat) {
      isBlocked.value = true; // Correctly set isBlocked to true
      break; // Exit the loop if a match is found
    }
  }

  // If it's a weekend or blocked, reset the selected index and show a snackbar
  if (isWeekend.value || isBlocked.value) {
    selectedIndex.value = -1; // Disable booking
    Get.snackbar(
      'Unavailable',
      'This doctor is not available on the selected date.',
    );
  } else {
    // Fetch unavailable bookings if not blocked or weekend
    await fetchUnavailable(doctor, date);
  }
}


  void selectTime(int index, Doctor doctor) {
    selectedIndex.value = index;
    
  }

  @override
  void onInit() {
    fetchDoctor();
    fetchUserRecord();
    super.onInit();
  }

  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final user = await userRepository.getUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRecord() async {
    try {
      isLoading.value = true;
      final user = await userRepository.getUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Doctor>> fetchDoctor() async {
    try {
      isLoading.value = false;
      final doctorList = await _doctorRepository.getDoctor();
      //final listdoctor=await apiService.getDoctor();
      doctorsList.assignAll(doctorList);
      return doctorList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Appointment>> fetchAppointment() async {
    try {
      isLoading.value = false;
      final apptList = await _doctorRepository.getApptPatient();
      apptsList.assignAll(apptList);
      return apptList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Appointment>> fetchUnavailable(Doctor doctor,DateTime selectedDate) async {
    try {
      isLoading.value = true;
      unavailableList.clear();
      final apptList = await _doctorRepository.getUnavailableBooking(doctor.id);
      final filteredList = apptList.where((appt) {
      return appt.appointmentDate.year == selectedDate.year &&
             appt.appointmentDate.month == selectedDate.month &&
             appt.appointmentDate.day == selectedDate.day;
    }).toList();

    unavailableList.assignAll(filteredList);

      return unavailableList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  void deletePost(String doctorId) async {
    try {
      isLoading.value = true;
      await _doctorRepository.deleteDoctor(doctorId);
    } catch (err) {
      KLoaders.errorSnackBar(title: err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectImage() async {
    final image = await ImagePickerDialog.showImageSourceDialog(Get.context!);

    if (image != null) {
      selectedImage.value = await image.readAsBytes();
    }
  }

  Future<void> bookAppointment(String doctorId, String doctorName) async {
    try {
      if (selectedIndex.value == -1) {
        Get.snackbar('Error', 'Please select a time slot');
        return;
      }

      isLoading.value = true;

      final appointmentDate = selectedDate.value;
      final appointmentTime =
          '${selectedIndex.value + 9}:00 ${selectedIndex.value + 9 > 11 ? "PM" : "AM"}';
      final user = await userRepository.getUserDetails();
      this.user(user);

      String appointment = const Uuid().v1();

      Appointment appt = Appointment(
        id: appointment,
        patientId: user.id,
        doctorId: doctorId,
        appointmentDate: appointmentDate,
        status: 'scheduled',
        appointmentTime: appointmentTime,
        doctorName: doctorName,
      );

      userRepository.bookAppt(appointment, appt);
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Something went wrong');
    } finally {
      KFullScreenLoaders.stopLoading();
      KLoaders.successSnackBar(
          title: 'Success', message: 'Your post succesfully posted!');
      isLoading.value = false;
    }
  }

  void deleteAppt(String apptId) async {
    try {
      isLoading.value = true;
      await userRepository.deleteAppt(apptId);
    } catch (err) {
      KLoaders.errorSnackBar(title: err.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
