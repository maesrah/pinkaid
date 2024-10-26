import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/game_keyboard.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/question_page.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/quiz_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/star.dart';
import 'package:pinkaid/features/patientsFeatures/screen/gamemodule/wordle_controller.dart';
import 'package:pinkaid/patients_nav_bar.dart';

import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameController());
    //final quizController = Get.put(QuizController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.off(() => const PatientBottomNavigationBar());
            },
            icon: const Icon(Iconsax.arrow_circle_left_copy)),
        title: const Text('Game'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                      color: kColorPrimaryLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Shadow color
                          offset: const Offset(
                              0.1, 0.1), // Position of the shadow (x, y)
                          blurRadius: 0.5, // Blur effect
                          spreadRadius: 2, // Spread radiu
                        ),
                      ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kSpaceScreenPadding),
                  child: Column(
                    children: [
                      Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                                    Icons.star_purple500_sharp,
                                    size: 60,
                                    color: Colors.purple,
                                    
                                  ),
                                  SizedBox(width: 10,),
                                 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //SizedBox(width: 10,),
                              Obx(() {
                                return Text(controller.score.value.toString(),
                                    style: KTextTheme.lightTextTheme.bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24));
                              }),

                              Text(
                                "Points",
                                style: KTextTheme.lightTextTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: kSpaceScreenPadding,
                          ),
                          const SizedBox(
                              height: 60,
                              child: VerticalDivider(
                                width: 5,
                              )),
                              SizedBox(width: 10,),
                           const Icon(
                                        Iconsax.medal_star_copy,
                                        size: 55,
                                        color: Colors.indigo,
                                      ),
                                 SizedBox(width: 10,),     
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: kSpaceScreenPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return Text(
                                      controller.badges.length.toString(),
                                      style: KTextTheme
                                          .lightTextTheme.bodySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                    );
                                  }),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Badges",
                                    style: KTextTheme.lightTextTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 20,
                        //background: Color(0xFFfaf7fa),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const RewardsMeterStars(
                            starCount: 50,
                            starMinRadius: 5,
                            starMaxRadius: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Quiz Game',
                  style: KTextTheme.lightTextTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: kSpaceScreenPadding,
              ),
              Center(child: Obx(() {
                return Wrap(
                  spacing: 10.0, // Space between items horizontally
                  runSpacing: 10.0, // Space between items vertically
                  children:
                      controller.quizCategory.asMap().entries.map((entry) {
                    int index = entry.key; // Get the index
                    var item = entry.value; // Get the actual item

                    return SizedBox(
                      height: 150,
                      child: QuizCategoryCard(
                        title: item.quizCategoryName.toString(),
                        index: index,
                        id: item.id,
                        image: item.image,
                      ),
                    );
                  }).toList(),
                );
              })),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Wordle Game',
                  style: KTextTheme.lightTextTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height:5
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: kColorPrimaryLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), // Shadow color
                          offset: const Offset(
                              0.1, 0.1), // Position of the shadow (x, y)
                          blurRadius: 0.5, // Blur effect
                          spreadRadius: 2, // Spread radiu
                        ),
                      ]),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guess, Learn, and Beat It!",
                          style: KTextTheme.lightTextTheme.titleMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  final WordleController wordle =
                                      Get.put(WordleController());
                                  wordle.initGame("wordle");
                                  Get.to(() => GameKeyboard());
                                },
                                child: Text(
                                  'Play Now!',
                                  style: KTextTheme.lightTextTheme.bodySmall,
                                )),

                           Row(
                             children: [
                               Image.asset(
                                    'assets/icons/book.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                   Transform.rotate(
                              angle:
                                  0.25, // Rotate by 0.25 radians (~14.3 degrees)
                              child: Image.asset(
                                'assets/icons/alphabet.png',
                                height: 80,
                                width: 80,
                              ),
                            ),
                             ],
                           ),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QuizCategoryCard extends StatelessWidget {
  const QuizCategoryCard(
      {super.key,
      required this.image,
      required this.id,
      required this.index,
      required this.title});
  final String image;
  final String title;
  final int index;
  final String id;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuizController());
    // final List<Color> colors = [
    //   kColorSecondary,
    //   kColorSecondaryDark,
    //   kColorPrimary
    // ];
    return GestureDetector(
      onTap: () async {
        await controller.fetchQuiz(id);
        controller.startTimer();
        Get.to(() => QuestionPage());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.pink[100],
            // colors[index % colors.length],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                offset: const Offset(0.1, 0.1), // Position of the shadow (x, y)
                blurRadius: 0.5, // Blur effect
                spreadRadius: 2, // Spread radiu
              ),
            ]),
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20), // Add padding around the image
              decoration: BoxDecoration(
                color: Colors.pink[200], // A lighter shade of pink
                borderRadius: BorderRadius.circular(10), // Circle shape
              ),
              child: Image.network(
                image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
