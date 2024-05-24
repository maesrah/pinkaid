import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pinkaid/theme/theme.dart';
import 'package:pinkaid/utils/animation_loader.dart';

class KFullScreenLoaders {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
              color: Colors.white, // Adjust the color as needed
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kSpaceScreenPaddingLg),
                    KAnimationLoaderWidget(
                      text: text,
                      animation: animation,
                    ), // Adjust text style as needed
                  ])),
        );
      },
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
