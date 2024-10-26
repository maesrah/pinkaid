import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinkaid/features/patientsFeatures/controller/trend_controller.dart';

class AddMedication extends StatelessWidget {
  
  final String userId;

  const AddMedication({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
   final controller = Get.put(TrendController());

    return AlertDialog(
      title: const Text('Add Medication'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.medicationNameController,
              decoration: const InputDecoration(
                labelText: 'Medication Name',
                hintText: 'Enter medication name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:controller.dosageController,
              decoration: const InputDecoration(
                labelText: 'Dosage',
                hintText: 'Enter dosage (e.g., 500mg)',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.frequencyController,
              decoration: const InputDecoration(
                labelText: 'Frequency',
                hintText: 'Enter frequency (e.g., once a day)',
              ),
              keyboardType: TextInputType.text,
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
            if (controller.medicationNameController.text.isNotEmpty &&
                controller.dosageController.text.isNotEmpty &&
                controller.frequencyController.text.isNotEmpty) {
            controller.updateMedication(controller.medicationNameController.value.text, controller.frequencyController.value.text, controller.dosageController.value.text);
            controller.medicationNameController.clear();
            controller.dosageController.clear();
            controller.frequencyController.clear();
              Get.back();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
