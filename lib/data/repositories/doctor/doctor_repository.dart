import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/patientsFeatures/model/appointment_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';
import 'package:pinkaid/utils/helpers/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DoctorRepository extends GetxController {
  static DoctorRepository get instance => Get.find();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> uploadDoctor(String doctorId, Doctor doctor) async {
    try {
      await _firebaseFirestore
          .collection("Doctors")
          .doc(doctorId)
          .set(doctor.toJson());
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

  Future<List<Doctor>> getDoctor() async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("Doctors")
          .get();
      return querySnapshot.docs.map((doc) => Doctor.fromSnapshot(doc)).toList();
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
  Future<List<Appointment>> getApptPatient() async {
  try {
    final querySnapshot = await _firebaseFirestore
        .collection("Appointment")
        .where("patientId", isEqualTo:AuthRepository.instance.authUser?.uid )
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
  }
}

Future<List<Appointment>> getUnavailableBooking(String doctorId) async {
  try {
    final querySnapshot = await _firebaseFirestore
        .collection("Appointment")
        .where("doctorId", isEqualTo:doctorId)
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
  }
}

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final querySnapshot =
          await _firebaseFirestore.collection("Doctors").limit(4).get();
      return querySnapshot.docs.map((doc) => Doctor.fromSnapshot(doc)).toList();
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

  // Delete Post
  Future<String> deleteDoctor(String doctorId) async {
    String res = "Some error occurred";
    try {
      await _firebaseFirestore.collection('Doctors').doc(doctorId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

   
}
