import 'package:flutter/material.dart';
// import 'package:pinkaid/theme/textheme.dart';

///
/// Initial Variable
///
const kColorDarkOrange900 = Color(0xFF593909);
const kColorLightBlue = Color(0xFFdbeeff);
const kColorGold = Color(0xFFFDE363);
const kColorIvory = Color(0xFFFFF8EF);
const kColorWhiteSmoke = Color(0xFFF4F3F2);
const kColorMidnightBlue = Color(0xFF0A1F30);
const kColorDarkBlue = Color(0xFF012070);
const kColorMediumBlue = Color(0xFF1564AF);
const kColorLightGrey = Color(0xFFD5D5D5);
const kColorMediumGold = Color(0xFFFDB515);
const kColorDarkGold = Color(0xFFDCB13E);
const kColorLightGold = Color(0xFFFDCF2C);
const kColorStandardRed = Color(0xFFff4444);
const kColorStandardOrange = Color(0xFFffbb33);
const kColorStandardGreen = Color(0xFF00C851);
const kColorStandardBlue = Color(0xFF33b5e5);

const kPrimaryFont = 'Poppins';
// String get kMonospaceFont => Platform.isIOS ? 'Courier' : 'monospace';
const Color kColorPrimaryOne = Color(0xffFF5580);
const Color kColorDeepPurple = Color(0xff982176);
const Color kColorPrimaryDark = kColorDarkOrange900;
const Color kColorPrimary = Color(0xFFF12B6B);
const Color kColorPrime = Color(0xfffFFDBA);
const Color kColorPrimaryLight = Color(0xFFFFB1B1);
const Color kColorSecondaryDark = Color(0xFFFF467E);
const Color kColorSecondary = Color(0xFFFFB1B1);
const Color kColorSecondaryLight = Color(0xFFFFE3CA);
const Color kColorErrorDark = Color(0xFFBF2600);
const Color kColorError = Color(0xFFFF5630);
const Color kColorWarningDark = Color(0xFFFF8B00);
const Color kColorWarning = Color(0xFFFFAB00);
const Color kColorWarningLight = Color(0xFFFFFAE6);
const Color kColorSuccessDark = Color(0xFF006644);
const Color kColorSuccess = Color(0xFF36B37E);
const Color kColorSuccessLight = Color(0xFFE3FCEF);
const Color kColorInfoDark = Color(0xFF0747A6);
const Color kColorInfo = Color(0xFFF6F5F5);
const Color kColorInfoLight = Color(0xFFDEEBFF);
const Color kColorOnDark = Colors.white;
const Color kColorOnDarkLow = Colors.white70;
const Color kColorOnDarkDisabled = Colors.white54;
const Color kColorOnLight = Colors.black;
const Color kColorOnLightLow = Colors.black87;
const Color kColorOnLightDisabled = Colors.black54;
const Color kColorSurfaceCanvas = Color(0xFFFCFCFC);
const Color kColorSurfaceCard = Colors.white;
const Color kColorSurfaceBorder = Color(0xFFf3f3f4);
const Color kColorSurfaceInput = Colors.white; //F3F3F4
const Color kColorSurfaceInputBorder = Color.fromARGB(255, 219, 219, 219);
const Color kColorSurfaceInputFocus = kColorPrimary;
const Color kColorFacebook = Color(0xff1778F2);
const Color kColorGreyedScaffold = Color(0xFFF6F6F6);

const Color kColorBodyText = Color(0xFF272928);
const Color kColorDisplayText = Color(0xFF272928);

const double kButtonHeight = 42.0;
const double kButtonHeightSm = 32.0;

const double kSpaceScreenPadding = 10.0;
const double kSpaceScreenPaddingLg = 22.0;

const double kSpaceSectionSm = 8.0;
const double kSpaceSectionMd = 14.0;
const double kSpaceSectionLg = 20.0;
const double kSpaceInput = 14.0;
const double kRadiusTextInput = 10.0;
const double kRadiusButton = 9999999;
const double kRadiusDialog = 16.0;
const double kRadiusCard = 16.0;
const double kRadiusBottomSheet = 16.0;
const double kSpaceProductGrid = 0.0;
const double kRatioProductCard = 0.8;
const double kProductImageWidth = 4;
const double kProductImageHeight = 3;
const double kRatioProductImage = kProductImageWidth / kProductImageHeight;
Color get kColorDialog => const Color(0xFFf3f3f3).withOpacity(0.99);

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: kColorSecondary,
    scaffoldBackgroundColor: Colors.white,
  );
}
