import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pinkaid/features/patientsFeatures/controller/meal_controller.dart';
import 'package:pinkaid/features/patientsFeatures/screen/activity_module/meal_widget.dart';
import 'package:pinkaid/features/patientsFeatures/screen/activity_module/water_widget.dart';
import 'package:pinkaid/theme/textheme.dart';
import 'package:pinkaid/theme/theme.dart';

class MealPage extends StatelessWidget {
  
  MealPage({super.key});
  //final DietController dietController = Get.put(DietController());
  final controller =Get.put(MealController());

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(appBar:AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_circle_left_copy),
        ),
        title: Text(
          'Diet',
          style: KTextTheme.lightTextTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ) ,
      body:  Padding(
        padding: const EdgeInsets.all(kSpaceScreenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: [
                  // Display selected date
                  Obx(() {
                    return Container(
                      
                      decoration: BoxDecoration(color: kColorInfo,borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('dd/MM/yy').format(controller.selectedDate.value),
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                  ElevatedButton(
                    onPressed: () {
                      controller.pickDate(context);
                    },
                    child: const Text("Select Date"),
                  ),
                ],
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Container(
                padding: const EdgeInsets.all(kSpaceInput),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kColorSecondary,borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Breakfast',style: KTextTheme.lightTextTheme.titleSmall,),
                    Obx(() {
                        DateTime now = controller.selectedDate.value;
                        DateFormat formatter = DateFormat('dd-MM-yy');
                        String formattedDate = formatter.format(now);

                       

                            List<dynamic> dailyMeals = controller
                                    .patient.value.dailyTracking[formattedDate]
                                ?['dailyMeals']?['Breakfast']??
                            [];

                        // If no exercises are recorded, display a message
                        if (dailyMeals.isEmpty) {
                          return Text(
                            'No meals recorded for today.',
                            style: KTextTheme.lightTextTheme.bodyMedium,
                          );
                        }

                        // Display the list of exercises with delete buttons
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dailyMeals.map((meal) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display exercise name and duration
                                Text(
                                  '${meal['meal']??''}',
                                  style: KTextTheme.lightTextTheme.bodyMedium,
                                ),
                                // Add a delete button to remove the exercise
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Meal",
                                      middleText:
                                          "Are you sure you want to delete this meal?",
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        // Trigger the removeExercise method
                                        controller.removeMeal(
                                          'Breakfast',
                                            meal['meal'],
                                            meal['calories']
                                            );
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
                     Align(alignment: Alignment.bottomRight,child: ElevatedButton(onPressed: (){
                      showMealBottomSheet(Get.context!,'Breakfast');
                     }, child: const Text('Add Breakfast')),)

                  ],
                ),
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Container(
                padding: const EdgeInsets.all(kSpaceInput),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kColorSecondary,borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lunch',style: KTextTheme.lightTextTheme.titleSmall,),
                    Obx(() {
                        DateTime now = controller.selectedDate.value;
                        DateFormat formatter = DateFormat('dd-MM-yy');
                        String formattedDate = formatter.format(now);

                        // Retrieve daily exercises for the current date
                       // List<dynamic> dailyMeals = controller
                        //             .patient.value.dailyTracking[formattedDate]
                        //         ?['Dinner'] ??
                        //     [];

                            List<dynamic> dailyMeals = controller
                                    .patient.value.dailyTracking[formattedDate]
                                ?['dailyMeals']?['Lunch']??
                            [];

                        // If no exercises are recorded, display a message
                        if (dailyMeals.isEmpty) {
                          return Text(
                            'No meals recorded for today.',
                            style: KTextTheme.lightTextTheme.bodyMedium,
                          );
                        }

                        // Display the list of exercises with delete buttons
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dailyMeals.map((meal) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display exercise name and duration
                                Text(
                                  '${meal['meal']??''}',
                                  style: KTextTheme.lightTextTheme.bodyMedium,
                                ),
                                // Add a delete button to remove the exercise
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Meal",
                                      middleText:
                                          "Are you sure you want to delete this meal?",
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                       controller.removeMeal(
                                          'Lunch',
                                            meal['meal'],
                                            meal['calories']
                                            );
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
                    Align(alignment: Alignment.bottomRight,child: ElevatedButton(onPressed: (){
                      showMealBottomSheet(Get.context!,'Lunch');
                    }, child: const Text('Add Lunch')),)

                  ],
                ),
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Container(
                padding: const EdgeInsets.all(kSpaceInput),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kColorSecondary,borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dinner',style: KTextTheme.lightTextTheme.titleSmall,),
                    Obx(() {
                        DateTime now =  controller.selectedDate.value;
                        DateFormat formatter = DateFormat('dd-MM-yy');
                        String formattedDate = formatter.format(now);

                        // Retrieve daily exercises for the current date
                        // List<dynamic> dailyMeals = controller
                        //             .patient.value.dailyTracking[formattedDate]
                        //         ?['Dinner'] ??
                        //     [];

                            List<dynamic> dailyMeals = controller
                                    .patient.value.dailyTracking[formattedDate]
                                ?['dailyMeals']?['Dinner']??
                            [];

                        // If no exercises are recorded, display a message
                        if (dailyMeals.isEmpty) {
                          return Text(
                            'No meals recorded for today.',
                            style: KTextTheme.lightTextTheme.bodyMedium,
                          );
                        }

                        // Display the list of exercises with delete buttons
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dailyMeals.map((meal) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display exercise name and duration
                                Text(
                                  '${meal['meal']??''}',
                                  style: KTextTheme.lightTextTheme.bodyMedium,
                                ),
                                // Add a delete button to remove the exercise
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Meal",
                                      middleText:
                                          "Are you sure you want to delete this meal?",
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                       controller.removeMeal(
                                            'Dinner',
                                            meal['meal'],
                                            meal['calories'],
                                            );
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
                     Align(alignment: Alignment.bottomRight,child: ElevatedButton(onPressed: (){
                      showMealBottomSheet(Get.context!,'Dinner');
                     }, child: const Text('Add Dinner')),)

                  ],
                ),
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Container(
                padding: const EdgeInsets.all(kSpaceInput),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kColorSecondary,borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Snack',style: KTextTheme.lightTextTheme.titleSmall,),
                    Obx(() {
                        DateTime now =  controller.selectedDate.value;
                        DateFormat formatter = DateFormat('dd-MM-yy');
                        String formattedDate = formatter.format(now);

                        // Retrieve daily exercises for the current date
                        // List<dynamic> dailyMeals = controller
                        //             .patient.value.dailyTracking[formattedDate]
                        //         ?['Dinner'] ??
                        //     [];

                            List<dynamic> dailyMeals = controller
                                    .patient.value.dailyTracking[formattedDate]
                                ?['dailyMeals']?['Snack']??
                            [];
                        if (dailyMeals.isEmpty) {
                          return Text(
                            'No meals recorded for today.',
                            style: KTextTheme.lightTextTheme.bodyMedium,
                          );
                        }

                        // Display the list of exercises with delete buttons
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dailyMeals.map((meal) {
                            return Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Display exercise name and duration
                                Text(
                                  '${meal['meal']??''}',
                                  style: KTextTheme.lightTextTheme.bodyMedium,
                                ),
                                // Add a delete button to remove the exercise
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Delete Meal",
                                      middleText:
                                          "Are you sure you want to delete this meal?",
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        controller.removeMeal(
                                          'Snack',
                                            meal['meal'],
                                            meal['calories']
                                            );
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
                     Align(alignment: Alignment.bottomRight,child: ElevatedButton(onPressed: (){
                      showMealBottomSheet(Get.context!,'Snack');
                     }, child: const Text('Add Snack')),)

                  ],
                ),
              ),
              const SizedBox(height: kSpaceScreenPadding,),
              Container(
                padding: const EdgeInsets.all(kSpaceInput),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: kColorSecondaryLight,borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Water',style: KTextTheme.lightTextTheme.titleSmall,),
                    
                    IconButton(onPressed: (){
                      Get.dialog(WaterIntakeDialog());
                    }, icon: const Icon(Iconsax.add_circle_copy))
                    

                  ],
                ),
              )
            ],
          ),
        ),
      ),);
  }
}