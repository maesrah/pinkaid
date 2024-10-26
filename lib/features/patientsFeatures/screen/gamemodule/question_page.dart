import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/quiz_controller.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({super.key});

  final controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorPrimaryOne.withOpacity(0.7),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              controller.resetQuiz();
              Get.to(() => const GamePage());
            },
            icon: const Icon(Iconsax.arrow_circle_left_copy)),
        title: const Text('Quiz 1'),
      ),
      body: Obx(() {
        if (controller.quizQuestion.isEmpty) {
          return const Center(child: Text("No questions available"));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kSpaceScreenPadding,),
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.all(10),
                      child: Obx(() =>
                          Text("Time left: ${controller.timeLeft.value}")))),
              if (controller
                      .quizQuestion[controller.currentIndex.value].imageUrl !=
                  null) // Check if imageUrl is not null
                Center(
                  child: Image.network(
                    controller
                        .quizQuestion[controller.currentIndex.value].imageUrl!,
                    height: 100, // Adjust height as needed
                    width: 100, // Adjust width as needed
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  controller
                      .quizQuestion[controller.currentIndex.value].question,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              for (var option in controller
                      .quizQuestion[controller.currentIndex.value].options ??
                  [])
                AnswerOption(
                  text: option,
                  isSelected: controller.selectedAnswer.value == option,
                  isCorrect: option ==
                      controller.quizQuestion[controller.currentIndex.value]
                          .correctAnswer,
                  controller: controller,
                ),
            ],
          );
        }
      }),
      floatingActionButton: Obx(() {
              return IconButton(
                color: kColorPrimaryOne,
                  onPressed: controller.isAnswered.value
                      ? controller.nextQuestion
                      : null,
                  icon: const Icon(
                    Iconsax.arrow_circle_right_copy,
                    size: 40,
                  ));
            }) ,
     
    );
  }
}

class AnswerOption extends StatelessWidget {
  final String text;
  final QuizController controller;

  final bool isSelected;
  final bool isCorrect;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isAnswered.value) {
          controller.checkAnswer(text); // Handle tap and check answer here
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPaddingLg),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: controller.isAnswered.value
                ? isCorrect
                    ? Colors.green // Show green for the correct answer
                    : controller.selectedAnswer.value == text
                        ? Colors.red // Show red for the wrong selected answer
                        : Colors.grey[200] // Show grey for others
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
