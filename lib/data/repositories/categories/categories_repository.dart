import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/model/category_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/doctor_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/post_model.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';
import 'package:pinkaid/utils/helpers/firebase_storage.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _firebaseFirestore.collection('Categories').get();
      final list =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return list;
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

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      ///final storage = Get.put(KFirebaseStorageService());

      for (var category in categories) {
        await _firebaseFirestore
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
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

  Future<void> uploadPostData(List<Post> posts) async {
    try {
      final storage = Get.put(KFirebaseStorageService());

      for (var post in posts) {
        final thumbnail = await storage.getImageDataFromNetwork(post.postUrl);

        final url = await storage.uploadImageData(
            'Posts/Images', thumbnail, post.postUrl.toString());
        post.postUrl = url;
        await _firebaseFirestore
            .collection('Posts')
            .doc(post.id)
            .set(post.toJson());
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

   Future<void> uploadDoctorData(List<Doctor> doctors) async {
    try {
      final storage = Get.put(KFirebaseStorageService());

      for (var doctor in doctors) {
        final thumbnail = await storage.getImageDataFromNetwork(doctor.profImage);

        final url = await storage.uploadImageData(
            'Doctors/Images', thumbnail, doctor.profImage.toString());
        doctor.profImage = url;
        await _firebaseFirestore
            .collection('Doctors')
            .doc()
            .set(doctor.toJson());
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
}
