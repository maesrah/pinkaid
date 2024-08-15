import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';

class AddMedication extends StatelessWidget {
  final TextEditingController _medicationNameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final String userId;

  AddMedication({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return AlertDialog(
      title: Text('Add Medication'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _medicationNameController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
                hintText: 'Enter medication name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage',
                hintText: 'Enter dosage (e.g., 500mg)',
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _frequencyController,
              decoration: InputDecoration(
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
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_medicationNameController.text.isNotEmpty &&
                _dosageController.text.isNotEmpty &&
                _frequencyController.text.isNotEmpty) {
              // userController.addMedication(
              //   userId,
              //   _medicationNameController.text,
              //   _dosageController.text,
              //   _frequencyController.text,
              // );
              Get.back();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
