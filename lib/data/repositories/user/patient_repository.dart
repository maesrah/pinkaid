import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinkaid/features/patientsFeatures/screen/onboarding/first_onboarding_page.dart';
import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/doctors_homepage.dart';
import 'package:pinkaid/features/authentication/screen/login/login.dart';

import 'package:pinkaid/utils/exception/exceptions/firebase_auth_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class PatientRepository extends GetxController {
  static PatientRepository get instance => Get.find();

  
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  User? get authUser => _firebaseAuth.currentUser;

  

  // screenRedirect() async {
  //   final user = _firebaseAuth.currentUser;

  //   if (user != null) {
  //     String? role = await getUserRole(user.uid);

  //     if (role == 'patient') {
  //       Get.offAll(() => const PatientBottomNavigationBar());
  //     } else if (role == 'doctor') {
  //       Get.offAll(() => const DoctorHomeScreen());
  //     }
    
    
  // }}

 
  }