// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Pink Aid`
  String get appName {
    return Intl.message(
      'Pink Aid',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPass {
    return Intl.message(
      'Confirm password',
      name: 'confirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registration {
    return Intl.message(
      'Registration',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameLabel {
    return Intl.message(
      'Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select User Type`
  String get userRoles {
    return Intl.message(
      'Select User Type',
      name: 'userRoles',
      desc: '',
      args: [],
    );
  }

  /// `Doctor`
  String get doctorLabel {
    return Intl.message(
      'Doctor',
      name: 'doctorLabel',
      desc: '',
      args: [],
    );
  }

  /// `Can organise and approve teleconsultations`
  String get doctorLabelDesc {
    return Intl.message(
      'Can organise and approve teleconsultations',
      name: 'doctorLabelDesc',
      desc: '',
      args: [],
    );
  }

  /// `Breast Cancer Patient`
  String get patientLabel {
    return Intl.message(
      'Breast Cancer Patient',
      name: 'patientLabel',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get publicLabel {
    return Intl.message(
      'Public',
      name: 'publicLabel',
      desc: '',
      args: [],
    );
  }

  /// `Can access health information and book teleconsultations`
  String get publicLabelDesc {
    return Intl.message(
      'Can access health information and book teleconsultations',
      name: 'publicLabelDesc',
      desc: '',
      args: [],
    );
  }

  /// `NSR number`
  String get medicalIdlabel {
    return Intl.message(
      'NSR number',
      name: 'medicalIdlabel',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInfoLabel {
    return Intl.message(
      'Personal information',
      name: 'personalInfoLabel',
      desc: '',
      args: [],
    );
  }

  /// `By signing in,I am agree with `
  String get agreeLabel {
    return Intl.message(
      'By signing in,I am agree with ',
      name: 'agreeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Term and Condition`
  String get termAndCondition {
    return Intl.message(
      'Term and Condition',
      name: 'termAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Verify your email address`
  String get verifyEmailLabel {
    return Intl.message(
      'Verify your email address',
      name: 'verifyEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `We have sent email to your current email address`
  String get sentEmailLabel {
    return Intl.message(
      'We have sent email to your current email address',
      name: 'sentEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Resend Email`
  String get resendLabel {
    return Intl.message(
      'Resend Email',
      name: 'resendLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'MY'),
      Locale.fromSubtags(languageCode: 'ms', countryCode: 'MY'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
