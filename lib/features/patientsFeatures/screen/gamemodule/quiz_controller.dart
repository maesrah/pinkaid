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

class QuizController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static QuizController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  var isLoading = false.obs;
  RxList<Quiz> quizQuestion = <Quiz>[].obs;
  RxList<QuizCategoryModel> quizCategory = <QuizCategoryModel>[].obs;
  final _categoryId = ''.obs;
  var selectedOptionIndex = (-1).obs;

  String get categoryId => _categoryId.value;
  set categoryId(String value) => _categoryId.value = value;


  Future<List<Quiz>> fetchQuiz(String categoryId) async {
    try {
      isLoading.value = false;
      final quizList = await getQuiz(categoryId);
      quizStartTime = DateTime.now();

      quizQuestion.assignAll(quizList);
      quizQuestion.shuffle();
      return quizList;
    } catch (e) {
      KLoaders.errorSnackBar(
          title: 'Something went wrong!', message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Quiz>> getQuiz(String categoryId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection("Quizzes")
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return querySnapshot.docs.map((doc) => Quiz.fromSnapshot(doc)).toList();
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

  

  // CONTROLLER

  var currentIndex = 0.obs;
  var score = 0.obs;
  var isAnswered = false.obs;
  var selectedAnswer = ''.obs;
  var timeLeft = 30.obs;
  var streak = 0.obs;

  Timer? _timer;
  var badges = <String>{}.obs;
  DateTime quizStartTime = DateTime.now();

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        showAnswer();
      }
    });
  }

  void checkAnswer(String userAnswer) {
    selectedAnswer.value = userAnswer;
    isAnswered.value = true;
    if (userAnswer == quizQuestion[currentIndex.value].correctAnswer) {
      score.value += timeLeft.value;
      streak.value++;
      Get.dialog(Dialog(
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Spacing to position content below the animation
              Lottie.asset(
                KImages.correct,
              ),
              const SizedBox(height: kSpaceScreenPadding),
              Text(
                'Correct!',
                style: KTextTheme.lightTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'You earned ${timeLeft.value} points!',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ));
    } else {
      streak.value = 0;
      Get.dialog(Dialog(
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: kSpaceScreenPadding,),
              CircleAvatar(
                radius: 40, // Set your desired radius
                child: ClipOval(
                  child: Lottie.asset(
                    KImages.wrong,
                    width: 100, // Customize width
                    height: 100, // Customize height
                    fit: BoxFit
                        .cover, // Ensures the animation covers the CircleAvatar
                  ),
                ),
              ),
              const SizedBox(height: kSpaceScreenPadding),
              Text(
                'Incorrect',
                style: KTextTheme.lightTextTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Correct answer is: ${quizQuestion[currentIndex.value].correctAnswer}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ));
    }
    _timer?.cancel();
    //showAnswer();
  }

  void showAnswer() {
    isAnswered.value = true;
    // Display correct answer
    selectedAnswer.value = quizQuestion[currentIndex.value].correctAnswer;
  }

  void nextQuestion() {
    if (currentIndex.value < quizQuestion.length - 1) {
      currentIndex.value++;
      resetForNextQuestion();
    } else {
      calculateBadges();
      updateLeaderboard();
      // Show result when the quiz ends
    }
  }

  void resetForNextQuestion() {
    isAnswered.value = false;
    selectedAnswer.value = '';
    timeLeft.value = 30;
    startTimer();
  }

  void resetQuiz() {
    score.value = 0;
    currentIndex.value = 0;
    streak.value = 0;
     _timer?.cancel();
    badges.clear();
     isAnswered.value = false;
    selectedAnswer.value = '';
    timeLeft.value = 30;
  }

  void showResultDialog() {
    //animationController.forward(); // Start animation when dialog is shown
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment:
                Alignment.center, // Align content to the center of the Stack
            children: [
              // Lottie background in a Container
              Lottie.asset(
                KImages.starCelebration,
              ),
              // Dialog content layered on top of the Lottie background
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Spacing to position content below the animation
                  const SizedBox(height: 100),
                  Text(
                    'Congratulations!',
                    style: KTextTheme.lightTextTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You scored ${score.value} points!',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 100),
                  if (badges.isNotEmpty)
                    Wrap(
                      spacing: 10,
                      children: badges
                          .map((badge) =>
                              Center(child: Chip(label: Text(badge))))
                          .toList(),
                    ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      resetQuiz(); // Reset the quiz
                      Get.off(() =>
                          const GamePage()); // Go back to homepage (or any other screen)
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent dismissing dialog by tapping outside
    );
  }

  void calculateBadges() {
    // "Faster Badge" if the entire quiz is completed in under 5 seconds per question
    Duration quizDuration = DateTime.now().difference(quizStartTime);
    int totalQuestions = quizQuestion.length;
    if (quizDuration.inSeconds <= totalQuestions * 5) {
      badges.add("Speedster Badge");
    }

    // "Completion Badge" for completing the quiz
    badges.add("Quiz Master Badge");

    // "Smart Badge" if all answers are correct
    if (streak.value == totalQuestions) {
      badges.add("Brainiac Badge");
    }

    showResultDialog();

    //Get.dialog(ResultDialog(points: score.value, badges: badges));
  }

  Future<void> updateLeaderboard() async {
  try {
    final userId = AuthRepository.instance.authUser?.uid;

    // Fetch the existing leaderboard entry
    DocumentSnapshot<Map<String, dynamic>> leaderboardDoc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(userId)
        .get();

    if (leaderboardDoc.exists) {
      // Document exists, so update the badges and score
      Map<String, dynamic> data = leaderboardDoc.data()!;

      // Retrieve existing score and badges from the database
      int existingScore = data['score'] ?? 0;
      List<dynamic> existingBadges = data['badges'] ?? [];

      // Update the score by adding the new score
      int updatedScore = existingScore + score.value.toInt();

      // Combine badges and remove duplicates
       List<String> updatedBadges = List<String>.from(existingBadges)
        ..addAll(badges);  

      // Update the leaderboard entry with the new data
      await FirebaseFirestore.instance.collection('Leaderboard').doc(userId).update({
        'score': updatedScore,
        'badges': updatedBadges,
      });
    } else {
      // Document does not exist, create a new one
      await FirebaseFirestore.instance.collection('Leaderboard').doc(userId).set({
        'userId': userId,
        'score': score.value.toInt(),
        'badges': badges.toList(),
      });
    }

    print('Updated leaderboard');
    onInit();
  } catch (e) {
    print('Error updating leaderboard: $e');
  }
}

}
