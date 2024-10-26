import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';

import 'package:pinkaid/data/repositories/doctor/doctor_repository.dart';

import 'package:pinkaid/data/repositories/user/user_repository.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';

import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';


class DoctorApptController extends GetxController {
  static DoctorApptController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  
 
  final DoctorRepository _doctorRepository = DoctorRepository();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
 var noteText = ''.obs;
 
  final userRepository = Get.put(UserRepository());
  

 

  @override
  void onInit() {
    //fetchDoctor();
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

  RxList<Appointment> doctorApptList = <Appointment>[].obs;
  Future<List<Appointment>> fetchDoctorAppointment() async {
    try {
      isLoading.value = false;
      final apptList = await _doctorRepository.getDoctorPatient();
      
      doctorApptList.assignAll(apptList);
      return apptList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }
 RxList<Appointment> doctorPastList = <Appointment>[].obs;
  Future<List<Appointment>> fetchPastAppointment() async {
    try {
      isLoading.value = false;
      final apptList = await getPastPatient();
      
      doctorPastList.assignAll(apptList);
      return apptList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Appointment>> getPastPatient() async {
  try {
   final querySnapshot = await _firebaseFirestore
        .collection("Appointment")
        .where("doctorId", isEqualTo: AuthRepository.instance.authUser?.uid)
        .where("status", isEqualTo: "completed") // Add this condition to filter by status
        .get();
    return querySnapshot.docs.map((doc) => Appointment.fromSnapshot(doc)).toList();
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }}


Future<void> updateApptPatient(String apptId,String notes) async {
  try {
    String status = "completed";
    Map<String, dynamic> json = {'status': status,
      'notes': notes,};
     await _firebaseFirestore
          .collection("Appointment")
          .doc(apptId)
          .update(json);
   
  } on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on FormatException catch (_) {
    throw const TFormatException();
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }}

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
