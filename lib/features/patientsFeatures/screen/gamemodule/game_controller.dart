import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';

import 'package:pinkaid/features/authentication/model/userModel.dart';

import 'package:pinkaid/features/patientsFeatures/model/quiz_category_model.dart';
import 'package:pinkaid/features/patientsFeatures/model/quiz_model.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_page.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';

class GameController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static GameController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  RxList<Quiz> quizQuestion = <Quiz>[].obs;
  RxList<QuizCategoryModel> quizCategory = <QuizCategoryModel>[].obs;
  final _categoryId = ''.obs;
  var selectedOptionIndex = (-1).obs;

  String get categoryId => _categoryId.value;
  set categoryId(String value) => _categoryId.value = value;
  var score = 0.obs;
  var badges = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllQuizCategory();
    fetchLeaderboardData();
    
  }

 Future<List<QuizCategoryModel>> fetchAllQuizCategory() async {
    try {
      isLoading.value = true;
      final quizCategoryList = await getAllQuizCategory();
      quizCategory.assignAll(quizCategoryList);
      return quizCategoryList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<QuizCategoryModel>> getAllQuizCategory() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection("QuizCategory").get();
      return querySnapshot.docs
          .map((doc) => QuizCategoryModel.fromSnapshot(doc))
          .toList();
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

  Future<List<QuizCategoryModel>> fetchLeaderboard() async {
    try {
      isLoading.value = true;
      final quizCategoryList = await getAllQuizCategory();
      quizCategory.assignAll(quizCategoryList);
      return quizCategoryList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchLeaderboardData() async {
    try {
      final userId = AuthRepository.instance.authUser?.uid;

      DocumentSnapshot<Map<String, dynamic>> leaderboardDoc = await FirebaseFirestore.instance
          .collection('Leaderboard')
          .doc(userId)
          .get();

      if (leaderboardDoc.exists) {
        Map<String, dynamic> data = leaderboardDoc.data()!;
        
        // Retrieve score and badges
        int fetchedScore = data['score'] ?? 0;
        List<dynamic> fetchedBadges = data['badges'] ?? [];

        // Update GetX state
        score.value = fetchedScore;
        badges.assignAll(List<String>.from(fetchedBadges));
      } else {
        print('No leaderboard data found for user');
      }
    } catch (e) {
      print('Error fetching leaderboard data: $e');
    }
  }
}


  

