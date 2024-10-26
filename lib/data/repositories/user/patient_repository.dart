
import 'package:firebase_auth/firebase_auth.dart';


import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import 'package:get/get_state_manager/get_state_manager.dart';


class PatientRepository extends GetxController {
  static PatientRepository get instance => Get.find();

  
  final _firebaseAuth = FirebaseAuth.instance;
  

  User? get authUser => _firebaseAuth.currentUser;

  

  

 
  }