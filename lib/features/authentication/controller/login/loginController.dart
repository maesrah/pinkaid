import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/authentication/screen/home/Doctor/doctors_homepage.dart';
import 'package:pinkaid/features/authentication/screen/login/verifyOTP.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/network_manager.dart';
import 'package:pinkaid/utils/utils.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();
  final phoneNumber = TextEditingController();
  final verifyNo = TextEditingController();
  final rememberMe = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var statusString = "Welcome".obs;
  var codeSent = "no".obs;
  var verify_no = "1".obs;
  final _authRepository = AuthRepository.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> logInWithPhoneNumber({required String phoneNo}) async {
    if (!loginFormKey.currentState!.validate()) return;

    await _authRepository.verifyPhoneNumber(
      phoneNo: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _authRepository.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        statusString.value =
            "Error verifying your phone number: ${exception.message}";
      },
      codeSent: (String verificationId, int? resendToken) async {
        codeSent.value = 'yes';
        verify_no.value = verificationId;
        Get.to(VerifyOTP(verificationId: verify_no.value));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        KLoaders.errorSnackBar(
            title: 'Code Timeout',
            message:
                "Code auto-retrieval timeout for verification ID $verificationId");
      },
    );
  }

  Future<void> verifyCodeandLogin({
    required String verID,
    required String userInput,
  }) async {
    try {
      // Start load
      KFullScreenLoaders.openLoadingDialog(
          'We are processing your information...', KImages.bufferAnimation);

      // Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.errorSnackBar(
            title: 'No Internet',
            message: 'Please check your internet connection and try again.');
        return;
      }

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: userInput,
      );

      // Sign in the user with the credential
      UserCredential userCredential =
          await _authRepository.signInWithCredential(credential);

      // Get the user ID from the UserCredential
      final String userId = userCredential.user?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User ID is null or empty');
      }

      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc = await _authRepository.getUserDocument(userId);

      if (userDoc.exists) {
        UserModel user =
            UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

        firebaseAuth.signInWithCredential(credential).then((UserCredential) {
          if (user.role == UserRole.doctor) {
            Get.to(() => const DoctorHomeScreen());
          } else {
            Get.to(() => const PatientBottomNavigationBar());
          }
          // Get.to(() => const PatientsHomePage());
        });
      } else {
        KLoaders.errorSnackBar(
          title: 'User Not Found',
          message: 'No account found with this phone number.',
        );
      }

      AuthRepository.instance.screenRedirect();
    } catch (e) {
      KFullScreenLoaders.stopLoading();
      KLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      KFullScreenLoaders.stopLoading();
    }
  }
}
