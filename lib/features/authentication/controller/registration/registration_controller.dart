import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/data/repositories/user/user_repository.dart';

import 'package:pinkaid/features/authentication/screen/home/Doctor/doctors_homepage.dart';
import 'package:pinkaid/features/authentication/screen/home/Patient/patients_home_page.dart';
import 'package:pinkaid/features/authentication/model/userModel.dart';
import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

import 'package:pinkaid/utils/helpers/loaders.dart';
import 'package:pinkaid/utils/helpers/network_manager.dart';
import 'package:pinkaid/utils/utils.dart';

class RegistrationController extends GetxController {
  static RegistrationController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmationPassword = TextEditingController();
  final medicalId = TextEditingController();
  final verifyNo = TextEditingController();
  // final role = useState<UserRole>
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  String get result => statusString.value;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  var statusString = "Welcome".obs;
  var codeSent = "no".obs;
  var verify_no = "1".obs;
  String? _uid;
  String get uid => _uid!;

  String get statusResult => statusString.value;
  String get codeSentResult => codeSent.value;
  String get verificationResult => verify_no.value;
  final _authRepository = AuthRepository.instance;
  final _userRepository = Get.put(UserRepository());

  //register user in firebase and save user data in firebase
  signInWithPhoneNumber({
    required String phoneNo,
  }) async {
    if (!registerFormKey.currentState!.validate()) return;
    await _authRepository.verifyPhoneNumber(
      phoneNo: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _authRepository.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException exception) {
        statusString.value = "Error verifying your phone number";
      },
      codeSent: (String verificationId, int? resendToken) async {
        codeSent.value = 'yes';
        verify_no.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // KLoaders.errorSnackBar(
        //     title: 'Error',
        //     message:
        //         "Code auto-retrieval timeout for verification ID $verificationId");
      },
    );
  }

  Future<void> myCredentials({
    required String name,
    required String verID,
    required String userInput,
    required UserRole userRole,
    required String phoneNumber,
    String? medicalId,
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

      // Form validation
      if (!registerFormKey.currentState!.validate()) {
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        KLoaders.warningSnackBar(
          title: 'Accept Term and Condition',
          message:
              'In order to create an account, you must accept the Terms and Conditions.',
        );
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

      // Check if the user already exists in Firestore
      DocumentSnapshot userDoc = await _authRepository.getUserDocument(userId);

      if (userDoc.exists) {
        // User already exists, handle accordingly
        KLoaders.warningSnackBar(
          title: 'User Exists',
          message: 'An account with this phone number already exists.',
        );
        return;
      } else {
        // User does not exist, proceed to save user record
        final user = UserModel(
            id: userId,
            fullName: name,
            phoneNumber: phoneNumber,
            role: userRole,
            medicalId: medicalId,
            profilePicture: '');

        firebaseAuth.signInWithCredential(credential).then((UserCredential) {
          if (userRole == UserRole.doctor) {
            Get.to(() => const DoctorHomeScreen());
          } else {
            Get.to(() => const PatientBottomNavigationBar());
          }
        });

        _userRepository.saveUserRecord(user);
      }
    } catch (e) {
      KLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      KFullScreenLoaders.stopLoading();
    }
  }
}
