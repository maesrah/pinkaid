import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import 'package:pinkaid/utils/helpers/loaders.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  KLoaders.errorSnackBar(title: 'No Image Selected');
}

class ImagePickerDialog {
  static Future<XFile?> showImageSourceDialog(BuildContext context) async {
    return showDialog<XFile>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select image source'),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(16.0),
              child: const Text('Take a photo'),
              onPressed: () async {
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                  maxHeight: 512,
                  maxWidth: 512,
                );
                Get.back(result: image);
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(16.0),
              child: const Text('Choose from gallery'),
              onPressed: () async {
                final XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                  maxHeight: 512,
                  maxWidth: 512,
                );
                Get.back(result: image);
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(16.0),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
