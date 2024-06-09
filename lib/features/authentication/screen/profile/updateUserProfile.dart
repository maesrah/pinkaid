import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinkaid/features/authentication/controller/user_controller.dart';

class UpdateUserDialog extends StatelessWidget {
  final String field;
  final String initialValue;
  final String userId;
  final TextEditingController _controller = TextEditingController();

  UpdateUserDialog(
      {required this.field, required this.initialValue, required this.userId}) {
    _controller.text = initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return AlertDialog(
      title:
          Text('Update ${field == 'fullName' ? 'Full Name' : 'Phone Number'}'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText:
              'Enter new ${field == 'fullName' ? 'full name' : 'phone number'}',
        ),
        keyboardType:
            field == 'phoneNumber' ? TextInputType.phone : TextInputType.text,
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
            if (_controller.text.isNotEmpty) {
              userController.updateUserData(field, _controller.text, userId);
              Get.back();
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
