import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_board.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/wordle_controller.dart';
import 'package:pinkaid/patients_nav_bar.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/images_string.dart';

class GameKeyboard extends StatelessWidget {
  final List<String> row1 = "QWERTYUIOP".split("");
  final List<String> row2 = "ASDFGHJKL".split("");
  final List<String> row3 = [
    "DEL",
    "Z",
    "X",
    "C",
    "V",
    "B",
    "N",
    "M",
    "SUBMIT"
  ];

  Widget build(BuildContext context) {
    final WordleController game = Get.put(WordleController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Iconsax.arrow_circle_left_copy)),
        title: const Text('Quiz Game'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kSpaceScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hint!',
                style: KTextTheme.lightTextTheme.titleSmall,
              ),
              Obx(() {
                return Text(
                  game.quizQuestion.value,
                  style: KTextTheme.lightTextTheme.bodySmall,
                );
              }),
              GameBoard(),
              const SizedBox(height: 5.0),
              buildKeyboardRow(game, row1),
              const SizedBox(height: 5.0),
              buildKeyboardRow(game, row2),
              const SizedBox(height: 5.0),
              buildKeyboardRow(game, row3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyboardRow(WordleController game, List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: keys.map((e) {
        return InkWell(
          onTap: () {
            handleKeyPress(e, game);
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey.shade300,
            ),
            child: Text(
              "$e",
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }

  void handleKeyPress(String key, WordleController game) {
    if (key == "DEL") {
      if (game.letterId.value > 0) {
        game.insertWord(game.letterId.value - 1, Letter("", 0));
        game.letterId.value--;
      }
    } else if (key == "SUBMIT") {
      if (game.letterId.value >= 5) {
        String guess =
            game.wordleBoard[game.rowId.value].map((e) => e.letter).join();

        if (game.checkWordExist(guess)) {
          // Check if guessed correctly
          if (guess == game.gameGuess.value) {
            game.gameMessage.value = "Congratulations 🎉";
            for (var element in game.wordleBoard[game.rowId.value]) {
              element.code = 1;
            }
            game.wordleBoard.refresh();
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
                      'You earned ${game.score.value} points!',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: kSpaceScreenPadding,
                    ),
                    TextButton(
                      onPressed: () {
                        
                        game.badges.add("Wordle Master Badge");
                        game.updateLeaderboard();

                        game.resetGame();
                        Get.back();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ));
          } else {
            game.checkGuess(guess, game);
            game.passTry();
          }
        } else {
          game.checkGuess(guess, game);
          game.gameMessage.value = "The word does not exist. Try again.";
          game.deductPoints();
          if (game.rowId.value >= 4) {
            Get.dialog(Dialog(
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
                      'Sorry',
                      style: KTextTheme.lightTextTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Please try again',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
            game.resetGame();
          } else {
            game.passTry();
          }
        }
      }
    } else {
      if (game.letterId.value < 5) {
        game.insertWord(game.letterId.value, Letter(key, 0));
        game.letterId.value++;
      }
    }
  }

  void checkGuess(String guess, WordleController game) {
    List<bool> checked = List.generate(guess.length, (index) => false);

    // First pass: Check for correct letters in the correct position (green)
    for (int i = 0; i < guess.length; i++) {
      String char = guess[i].toUpperCase();
      if (game.gameGuess.value[i] == char) {
        game.wordleBoard[game.rowId.value][i].code = 1; // Set to green
        checked[i] = true; // Mark this letter as checked
      }
    }

    // Second pass: Check for correct letters in the wrong position (yellow)
    for (int i = 0; i < guess.length; i++) {
      if (!checked[i]) {
        String char = guess[i].toUpperCase();
        if (game.gameGuess.value.contains(char)) {
          // Check if the letter exists in the correct answer but is in the wrong position
          int indexInAnswer = game.gameGuess.value.indexOf(char);
          if (indexInAnswer != -1 &&
              game.wordleBoard[game.rowId.value][indexInAnswer].code != 1) {
            game.wordleBoard[game.rowId.value][i].code = 2; // Set to yellow
          }
        }
      }
    }

    // Refresh the board to reflect changes
    game.wordleBoard.refresh();
  }
}
