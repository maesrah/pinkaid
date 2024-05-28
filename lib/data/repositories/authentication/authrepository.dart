import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/doctors_homepage.dart';
import 'package:pinkaid/features/authentication/screen/login/login.dart';

import 'package:pinkaid/utils/exception/exceptions/firebase_auth_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  User? get authUser => _firebaseAuth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      String? role = await getUserRole(user.uid);

      if (role == 'patient') {
        Get.offAll(() => const PatientBottomNavigationBar());
      } else if (role == 'doctor') {
        Get.offAll(() => const DoctorHomeScreen());
      }
    } else {
      deviceStorage.writeIfNull("isFirstTime", true);

      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const LoginScreen());
    }
  }

  Future<void> verifyPhoneNumber({
    required String phoneNo,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<UserCredential> signInWithCredential(PhoneAuthCredential credential) {
    try {
      return _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut().then((_) {
        Get.offAll(const LoginScreen());
      });
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<DocumentSnapshot> getUserDocument(String userId) {
    return _firebaseFirestore.collection('Users').doc(userId).get();
  }

  Future<String?> getUserRole(String userId) async {
    try {
      DocumentSnapshot userDoc = await getUserDocument(userId);
      if (userDoc.exists) {
        return userDoc['role'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
