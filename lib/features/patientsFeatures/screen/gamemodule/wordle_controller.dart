import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:pinkaid/data/repositories/authentication/authrepository.dart';
import 'package:pinkaid/features/patientsFeatures/model/quiz_model.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';
import 'package:pinkaid/utils/exception/exceptions/firebase_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/format_exceptions.dart';
import 'package:pinkaid/utils/exception/exceptions/platform_exceptions.dart';
import 'package:pinkaid/utils/helpers/loaders.dart';

class WordleController extends GetxController {
  // Game variables
  RxInt rowId = 0.obs;
  RxInt letterId = 0.obs;
  RxString gameMessage = "".obs;
  RxString gameGuess = "".obs; // The correct word fetched from Firebase
  RxBool gameOver = false.obs;
  RxInt score = 30.obs;
  RxString quizQuestion =''.obs;

  // This will store the quiz fetched from Firebase
  RxList<Quiz> wordleList = <Quiz>[].obs;
   var badges = <String>{}.obs;

  // Game Board
  RxList<List<Letter>> wordleBoard = List.generate(
    5,
    (index) => List.generate(
      5,
      (index) => Letter("", 0),
    ),
  ).obs;

  // Initialize the game with a random word from Firebase
  Future<void> initGame(String categoryId) async {
    await fetchQuiz('wordle'); // Fetch quiz data from Firebase

    if (wordleList.isNotEmpty) {
      final random = Random();
      int index = random.nextInt(wordleList.length);

      // Fetch the correct answer (letters or correctAnswer) from the quiz
      gameGuess.value = wordleList[index].letters!.join().toUpperCase();
      quizQuestion.value=wordleList[index].question;
      gameMessage.value = "";
      rowId.value = 0;
      letterId.value = 0;
      gameOver.value = false;

      // Reset the board
      wordleBoard.value = List.generate(
        5,
        (index) => List.generate(5, (index) => Letter("", 0)),
      );
    } else {
      gameMessage.value = "No quiz data found!";
    }
  }

  var isLoading = false.obs;

  // Fetch quiz questions from Firebase
  Future<List<Quiz>> fetchQuiz(String categoryId) async {
    try {
      isLoading.value = false;
      final quizList = await getQuiz(categoryId);

      wordleList.assignAll(quizList);
      wordleList.shuffle();
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

  void checkGuess(String guess, WordleController game) {
    bool isCorrect = true; // Track if any letter is correct
    for (int i = 0; i < guess.length; i++) {
      String char = guess[i].toUpperCase();
      if (game.gameGuess.value.contains(char)) {
        if (game.gameGuess.value[i] == char) {
          game.wordleBoard[game.rowId.value][i].code = 1; // Correct position
        } else {
          game.wordleBoard[game.rowId.value][i].code = 2; // Wrong position
          isCorrect = false; // Mark that the guess was not entirely correct
        }
      }
    }

    if (!isCorrect) {
      game.deductPoints(); // Deduct points for incorrect guesses
    }

    game.wordleBoard.refresh();
  }

  void deductPoints() {
    score.value = (score.value - 5)
        .clamp(0, 30); // Deduct 5 points, clamp to a minimum of 0
  }

   void resetScore() {
    
    score.value = 30; // Reset score when starting a new game
  }

  void resetGame() {
    rowId.value = 0;
    letterId.value = 0;
    gameOver.value = false;
    score.value = 30;
    badges = <String>{}.obs;


    // Reset the board
    wordleBoard.value = List.generate(
      5,
      (index) => List.generate(5, (index) => Letter("", 0)),
    );
    initGame('categoryId');
  }

  // Move to the next row
  void passTry() {
    if (rowId.value < 5) {
      rowId.value++;
      letterId.value = 0;
    } 
  }

  // Insert a letter into the game board
  void insertWord(int index, Letter word) {
    wordleBoard[rowId.value][index] = word;
    wordleBoard.refresh(); // Manually refresh the board to trigger updates
  }

  // Check if the guessed word matches the correct answer
  bool checkWordExist(String word) {
    return word.toUpperCase() == gameGuess.value;
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



class Letter {
  String? letter;
  int code = 0; // 0: no match, 1: correct, 2: wrong position

  Letter(this.letter, this.code);
}
