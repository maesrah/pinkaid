import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pinkaid/features/authentication/screen/profile/addMedication.dart';
import 'package:pinkaid/features/authentication/screen/profile/updateUserProfile.dart';
import 'package:pinkaid/features/patientsFeatures/controller/trend_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/activity_module/diet_screen.dart';
import 'package:pinkaid/features/patientsFeatures/screen/activity_module/insight_screen.dart';
import 'package:pinkaid/generated/l10n.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/constant/colors.dart';
import 'package:shimmer/shimmer.dart';

class HealthTrendPage extends StatefulWidget {
  const HealthTrendPage({super.key});

  @override
  _HealthTrendPageState createState() => _HealthTrendPageState();
}

class _HealthTrendPageState extends State<HealthTrendPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrendController());
    const List<Color> kColorPrimaryList = [kColorPrimaryOne, kColorDeepPurple];
    List<PieChartSectionData> showingSections() {
      return List.generate(
        2,
        (i) {
          var color0 = kColorPrimaryOne;

          switch (i) {
            case 0:
              return PieChartSectionData(
                  color: color0,
                  value: 33,
                  title: '',
                  radius: 55,
                  titlePositionPercentageOffset: 0.55,
                  badgeWidget: Obx(() {
                    return Text(
                      controller.patient.value.bmi.toStringAsFixed(2),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    );
                  }));
            case 1:
              return PieChartSectionData(
                color: Colors.grey.shade100,
                value: 75,
                title: '',
                radius: 45,
                titlePositionPercentageOffset: 0.55,
              );

            default:
              throw Error();
          }
        },
      );
    }

    final List<String> commonSymptoms = [
      'Breast pain',
      'Lump in breast',
      'Skin irritation',
      'Nipple pain',
      'Redness of skin',
      'Swelling in breast',
      'Change in breast size',
      'Others'
      // Add more common symptoms as needed
    ];

    void openSymptom(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceScreenPaddingLg,
                  vertical: kSpaceScreenPadding),
              child: Column(
                children: [
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  Obx(() {
                    DateTime now = DateTime.now();
                    DateFormat formatter = DateFormat('dd-MM-yy');
                    String formattedDate = formatter.format(now);

                    // Retrieve daily symptoms for the current date
                    List<dynamic> dailySymptoms = controller.patient.value
                            .dailyTracking[formattedDate]?['dailySymptom'] ??
                        [];

                    // If no symptoms are recorded, display a message
                    if (dailySymptoms.isEmpty) {
                      return Text(
                        'No symptoms recorded for today.',
                        style: KTextTheme.lightTextTheme.bodyMedium,
                      );
                    }

                    // Display the list of symptoms with delete buttons
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dailySymptoms.map((symptom) {
                        return Row(
                          children: [
                            // Display symptom name
                            Text(
                              '${symptom['symptom']}',
                              style: KTextTheme.lightTextTheme.bodyMedium,
                            ),
                            // Add a delete button to remove the symptom
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.redAccent),
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Delete Symptom",
                                  middleText:
                                      "Are you sure you want to delete this symptom?",
                                  textCancel: "No",
                                  textConfirm: "Yes",
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    // Trigger the removeSymptom method
                                    controller
                                        .removeSymptom(symptom['symptom']);
                                    Get.back(); // Close the dialog after deletion
                                  },
                                  onCancel: () {
                                    Get.back(); // Close the dialog if canceled
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  }),
                  const SizedBox(
                    height: kSpaceScreenPaddingLg,
                  ),
                  // Dropdown for common symptoms
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select a symptom', // Label text
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      filled: true, // Enable fill color
                      fillColor: Colors.grey[200], // Background color
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12), // Padding inside the field
                      prefixIcon:
                          const Icon(Icons.healing), // Icon before the dropdown
                    ),
                    hint: const Text('Choose a symptom'),
                    value: controller.selectedSymptom.value.isNotEmpty
                        ? controller.selectedSymptom.value
                        : null,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectedSymptom.value = newValue;
                        if (newValue != 'Others') {
                          controller.addSymptom(newValue);
                        }
                      }
                    },
                    items: commonSymptoms
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: kSpaceScreenPadding,
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.selectedSymptom.value == 'Others',
                      child: TextField(
                        controller: controller.symptomTextController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            controller.addSymptom(value); // Add the symptom
                            controller.symptomTextController
                                .clear(); // Clear the text field
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Add a new symptom',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              final symptom =
                                  controller.symptomTextController.text;
                              if (symptom.isNotEmpty) {
                                controller
                                    .addSymptom(symptom); // Add the symptom
                                controller.symptomTextController
                                    .clear(); // Clear the text field
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          controller.percentageIndicator.value ==
                                  1.0 // 1.0 means 100%
                              ? "You have completed all daily tracking!"
                              : "You have not completed all daily tracking.",
                          style: const TextStyle(
                            fontSize: 16.0,
                            // Bold text
                          ),
                          maxLines: 2, // Restrict to two lines
                          softWrap: true, // Enable soft wrap for the text
                          overflow: TextOverflow.visible, // Handle any overflow
                        ),
                      );
                    }),
                    Obx(() {
                      return CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: controller.percentageIndicator.value,
                        center: Text(
                          "${(controller.percentageIndicator.value * 100).toStringAsFixed(1)}%", // Format to 2 decimal places and append %
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey[300]!,
                        circularStrokeCap: CircularStrokeCap.round,
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: kColorPrimaryList),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.075),
                  ),
                  child: Stack(alignment: Alignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "BMI (Body Mass Index)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ],
                          ),
                          AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {},
                                ),
                                startDegreeOffset: 250,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 1,
                                centerSpaceRadius: 0,
                                sections: showingSections(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                const WeightHeightCard(),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                MealSleepCard(controller: controller),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                ExerciseCard(controller: controller),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                        horizontal: kSpaceScreenPadding,
                        vertical: kSpaceScreenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Log your symptom',
                          style: KTextTheme.lightTextTheme.bodyMedium,
                        ),
                        IconButton(
                          onPressed: () {
                            openSymptom(context);
                          },
                          icon: const Icon(Iconsax.add_circle_copy),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSpaceScreenPadding,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                        horizontal: kSpaceScreenPadding,
                        vertical: kSpaceScreenPadding),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Medication?',
                              style: KTextTheme.lightTextTheme.bodyMedium,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.dialog(AddMedication(
                                  userId: '1',
                                ));
                              },
                              icon: const Icon(Iconsax.add_circle_copy),
                            ),
                          ],
                        ),
                        Obx(() {
                          // Retrieve daily exercises for the current date
                          List<Map<String, dynamic>> dailyMedications =
                              controller.patient.value.medication ?? [];

                          // If no exercises are recorded, display a message
                          if (dailyMedications.isEmpty) {
                            return Text(
                              'No medication recorded',
                              style: KTextTheme.lightTextTheme.bodyMedium,
                            );
                          }

                          // Display the list of exercises with delete buttons
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dailyMedications.map((medical) {
                              return Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Display exercise name and duration
                                  Expanded(
                                    child: Text(
                                      '${medical['medical']} - ${medical['frequency']} times a day (${medical['dosage']} pills)',
                                      style:
                                          KTextTheme.lightTextTheme.bodySmall,
                                    ),
                                  ),
                                  // Add a delete button to remove the exercise
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Delete Medication",
                                        middleText:
                                            "Are you sure you want to delete this medication?",
                                        textCancel: "No",
                                        textConfirm: "Yes",
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          // Trigger the removeExercise method
                                          controller.removeMedication(
                                              medical['medical'],
                                              medical['frequency'],
                                              medical['dosage']);
                                          Get.back(); // Close the dialog after deletion
                                        },
                                        onCancel: () {
                                          Get.back(); // Close the dialog if canceled
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Get.to(() => const InsightScreen());
                      },
                      label: const Text('View your insights'),
                      icon: const Icon(Iconsax.arrow_right_copy),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.controller,
  });

  final TrendController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Initialize the ExerciseController using GetX
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      'Update Your Exercise',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Dropdown for exercise selection
                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.selectedExercise.value,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              icon: const Icon(Icons.arrow_drop_down),
                              items: controller.exercises
                                  .map((exercise) => DropdownMenuItem<String>(
                                        value: exercise['name'],
                                        child: Row(
                                          children: [
                                            Icon(exercise['icon'],
                                                color: Colors.blueAccent),
                                            const SizedBox(width: 10),
                                            Text(exercise['name']),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.selectedExercise.value = value!;
                                if (value != 'Others') {
                                  controller.isOtherSelected.value = false;
                                }
                              },
                            )),
                        const SizedBox(height: 15),

                        // Checkbox for selecting "Others" option
                        Obx(() => CheckboxListTile(
                              title: const Text('Other'),
                              value: controller.isOtherSelected.value,
                              onChanged: (bool? value) {
                                controller.isOtherSelected.value = value!;
                                if (!value) {
                                  controller.otherExerciseController.clear();
                                }
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            )),

                        // TextField for custom exercise name, displayed only if "Others" is selected
                        Obx(() {
                          if (controller.isOtherSelected.value) {
                            return _buildExerciseField(
                              controller: controller.otherExerciseController,
                              hintText: 'Enter your exercise name',
                              icon: Icons.edit,
                              inputType: TextInputType.text,
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                        const SizedBox(height: 15),

                        // Duration selection using + and - buttons
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: controller.decrementMinutes,
                                ),
                                Text(
                                  '${controller.exerciseMinutes.value} minutes',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: controller.incrementMinutes,
                                ),
                              ],
                            )),
                      ],
                    ),
                    actions: [
                      // Cancel Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          controller.resetFields();
                          Get.back();
                        },
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ),

                      // Update Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          String selectedExercise =
                              controller.selectedExercise.value;
                          String? customExercise =
                              controller.isOtherSelected.value
                                  ? controller.otherExerciseController.text
                                  : null;
                          int minutes = controller.exerciseMinutes.value;

                          // Validate if exercise data is provided
                          if (!controller.isOtherSelected.value ||
                              (controller.isOtherSelected.value &&
                                  customExercise!.isNotEmpty)) {
                            // Call the Firestore update method
                            controller.updateExercise(
                              customExercise ?? selectedExercise,
                              minutes,
                            );

                            Get.back();
                            controller.resetFields();
                          } else {
                            // Show a snackbar if custom exercise name is empty
                            Get.snackbar(
                              'Error',
                              'Please provide the name of your exercise',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: const Text('Update',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding,
                vertical: kSpaceScreenPaddingLg,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Did you exercise today?',
                        style: KTextTheme.lightTextTheme.titleSmall,
                      ),
                      // Use Obx to reactively display the exercise list
                      Obx(() {
                        DateTime now = DateTime.now();
                        DateFormat formatter = DateFormat('dd-MM-yy');
                        String formattedDate = formatter.format(now);

                        // Retrieve daily exercises for the current date
                        List<dynamic> dailyExercises = controller
                                    .patient.value.dailyTracking[formattedDate]
                                ?['dailyExercises'] ??
                            [];

                        // If no exercises are recorded, display a message
                        if (dailyExercises.isEmpty) {
                          return Text(
                            'No exercises recorded for today.',
                            style: KTextTheme.lightTextTheme.bodyMedium,
                          );
                        }

                        // Display the list of exercises with delete buttons
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dailyExercises.map((exercise) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display exercise name and duration
                                Text(
                                  '${exercise['exercise']} - ${exercise['minutes']} minutes',
                                  style: KTextTheme.lightTextTheme.bodyMedium,
                                ),
                                // Add a delete button to remove the exercise
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Exercise",
                                      middleText:
                                          "Are you sure you want to delete this exercise?",
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        // Trigger the removeExercise method
                                        controller.removeExercise(
                                            exercise['exercise'],
                                            exercise['minutes']);
                                        Get.back(); // Close the dialog after deletion
                                      },
                                      onCancel: () {
                                        Get.back(); // Close the dialog if canceled
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                  const Icon(
                    Icons.fitness_center,
                    size: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MealSleepCard extends StatelessWidget {
  const MealSleepCard({
    super.key,
    required this.controller,
  });

  final TrendController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // Shadow color
                    offset:
                        const Offset(0.1, 0.1), // Position of the shadow (x, y)
                    blurRadius: 0.5, // Blur effect
                    spreadRadius: 2, // Spread radiu
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Update Sleep Hours'),
                          content: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: controller.decrementHours,
                                ),
                                Text(
                                  '${controller.sleepHours.value} hours',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: controller.incrementHours,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                if (controller.sleepHours.value > 0) {
                                  controller.updateSleepHours(
                                      controller.sleepHours.value);
                                  Get.back();
                                } else {
                                  // Show a snackbar if no hours are set
                                  Get.snackbar('Error',
                                      'Please select a valid number of hours',
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'How was your sleep?',
                    style: KTextTheme.lightTextTheme.titleSmall,
                  ),
                ),
                const Icon(Iconsax.moon),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Initialize the MealController using GetX
              Get.to(() => MealPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding,
                vertical: kSpaceScreenPadding,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.5, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Did you eat today?',
                      style: KTextTheme.lightTextTheme.titleSmall,
                    ),
                    const Icon(Iconsax.reserve),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeightHeightCard extends StatelessWidget {
  const WeightHeightCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrendController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpaceScreenPadding, vertical: kSpaceScreenPadding),
            decoration: BoxDecoration(
                color: kColorSecondaryLight,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Update Weight'),
                          content: TextField(
                            controller: controller.weightControl,
                            decoration: const InputDecoration(
                                hintText: 'Enter new weight'),
                            keyboardType: TextInputType.number,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.updateWeight(
                                    controller.weightControl.value.text);
                                Get.back();
                              },
                              child: const Text('Update'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Current Weight:',
                    style: KTextTheme.lightTextTheme.titleSmall,
                  ),
                ),
                Obx(() {
                  return Text(
                    '${controller.patient.value.weight.toString()} kg',
                    style: KTextTheme.lightTextTheme.headlineLarge,
                  );
                })
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Update height'),
                    content: TextField(
                      controller: controller.heightControl,
                      decoration:
                          const InputDecoration(hintText: 'Enter new height'),
                      keyboardType: TextInputType.number,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.updateHeight(
                              controller.heightControl.value.text);
                          Get.back();
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSpaceScreenPadding,
                  vertical: kSpaceScreenPadding),
              decoration: BoxDecoration(
                  color: kColorPrimaryLight,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height:',
                    style: KTextTheme.lightTextTheme.titleSmall,
                  ),
                  Obx(() {
                    return Text(
                      '${controller.patient.value.height.toString()} cm',
                      style: KTextTheme.lightTextTheme.headlineLarge,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SymptomBox extends StatelessWidget {
  const SymptomBox({
    super.key,
    required int? currentIndex,
    required this.nameSymptom,
  }) : _currentIndex = currentIndex;

  final int? _currentIndex;
  final String nameSymptom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: cro,
        children: [
          Text(
            nameSymptom,
            style: KTextTheme.lightTextTheme.bodySmall,
            maxLines: 2,
          ),
          SizedBox(
            width: 200,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1.0,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: _currentIndex == index ? kColorPrimary : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    keyboardType: inputType,
  );
}

Widget _buildExerciseField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    ),
    keyboardType: inputType,
  );
}
