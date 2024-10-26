import 'package:flutter/material.dart';
import 'package:pinkaid/theme/theme.dart';

class KTextTheme {
  KTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),

    //title
    titleLarge: const TextStyle().copyWith(
        fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),

    //body
    bodyLarge: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),

    //label
    labelLarge: const TextStyle().copyWith(
        fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
  );

  


}
