// import 'package:flutter/material.dart';
// import 'package:riverpod/riverpod.dart';

// const kDefaultLocale = Locale('en');

// final languageStateProvider = StateNotifierProvider<LanguageStateNotifier,Locale>((ref)){
//   return LanguageStateNotifier(
//     locale:kDefaultLocale,
//   )
// }

// class LanguageStateNotifier extends StateNotifier<Locale> {
//   LanguageStateNotifier({
//     required Locale locale,
//     // required this.easigoldAPIService,
//     // required this.localStorageService,
//   }) : super(locale);

  
//   // void updateToLastLocale() async {
//   //   final previousLocale = localStorageService.locale;

//   //   if (previousLocale != null) {
//   //     changeLanguage(
//   //       Locale(previousLocale.languageCode, previousLocale.countryCode),
//   //     );
//   //   }
//   // }

//   void changeLanguage(Locale locale) async {
//     if (state.toString() == locale.toString()) return;

//     state = locale;

//     S.load(state);

//     localStorageService.locale = intl.Locale.parse(locale.toString());
//   }
// }