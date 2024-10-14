import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/patientsFeatures/controller/meal_controller.dart';


class WaterIntakeDialog extends StatelessWidget {
  final controller = Get.put(MealController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Fill in Your Water Intake'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (index) {
                return Container(
                  width: 20,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: index < controller.glassesFilled.value
                        ? Colors.blue
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            );
          }),
          SizedBox(height: 20),
          Obx(() => Text('Glasses filled: ${controller.glassesFilled.value}/8')),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (controller.glassesFilled.value > 0) {
                    controller.glassesFilled.value--;
                  }
                },
                icon: Icon(Icons.remove_circle),
                color: Colors.red,
                iconSize: 40,
              ),
              SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  if (controller.glassesFilled.value < 8) {
                    controller.glassesFilled.value++;
                  }
                },
                icon: Icon(Icons.add_circle),
                color: Colors.green,
                iconSize: 40,
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            controller.updateWaterIntake(controller.glassesFilled.value);

            Get.back(); // Close the dialog
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}