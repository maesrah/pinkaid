import 'package:flutter/material.dart';
import 'package:pinkaid/theme/theme.dart';

class KElevatedButtonTheme {
  KElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: kColorSecondary,
    disabledBackgroundColor: Colors.grey,
    disabledForegroundColor: Colors.grey,
    padding: const EdgeInsets.symmetric(vertical: 18),
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
  ));
}
