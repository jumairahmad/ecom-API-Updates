// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

const kPrimaryColor = Color(0xFFB72957);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kTxtColor = Color(0xFF284A6E);
const kTxtLightColor = Color(0xFFE9EDF0);
const kSecondaryColor = Color(0xFF284A6E);
const kTextColor = Color(0xFF757575);
const kTextGreyColor = Color(0xFFBDBDBD);
const kIconColor = Color(0xFF565656);
const kLightBlue = Color(0xFFE1E6FF);
const kAnimationDuration = Duration(milliseconds: 200);
const kBodyColor = Color(0xfffaf1f1);

final darkTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  fontFamily: GoogleFonts.poppins().fontFamily,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.amber,
    disabledColor: Colors.grey,
  ),
);

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.poppins().fontFamily,
  primarySwatch: Colors.blue,
  //scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    disabledColor: Colors.grey,
  ),
);
Map<int, Color> colorConversion = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

double borderRaius = 2.w;
final enabledBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: kTxtColor, width: 0.4),
);
final focusedBorder = UnderlineInputBorder(
  borderSide: const BorderSide(color: kTxtColor, width: 2),
);
final labelStyle = TextStyle(color: kTxtColor, fontSize: 12.sp);

final titleStyle = TextStyle(
  fontSize: 100.w < 500 ? 13.sp : 11.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w700,
);
final subTitleStyle = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 9.sp,
  color: kTextColor,
  fontWeight: FontWeight.w300,
);
final searchStyle = InputDecoration(
  filled: true,
  fillColor: kTxtLightColor,
  hintText: "Search here..",
  contentPadding: 100.w < 500 ? EdgeInsets.zero : EdgeInsets.all(12),
  hintStyle: TextStyle(
      fontSize: 100.w < 500 ? 14.sp : 10.sp,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w300,
      letterSpacing: 1),
  prefixIcon: Icon(
    Icons.search,
    color: kIconColor,
    size: 100.w < 500 ? 6.w : 4.w,
  ),
  prefixIconColor: kPrimaryColor,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(borderRaius),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(borderRaius),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  ),
);
final txtRoundStyle = InputDecoration(
  filled: true,
  fillColor: kTxtColor.withOpacity(0.08),
  labelText: "Enter Amount",
  labelStyle: TextStyle(
      fontSize: 14.sp,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w300,
      letterSpacing: 1),
  prefixIcon: Icon(
    Icons.search,
    color: kIconColor,
    size: 35,
  ),
  prefixIconColor: kPrimaryColor,
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100.h < 750 ? 5 : borderRaius),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(100.h < 750 ? 5 : borderRaius),
    ),
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
  ),
);

final titleLarge = TextStyle(
  fontSize: 100.w < 500 ? 13.sp : 9.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w700,
);
final titleMedium = TextStyle(
  fontSize: 100.w < 500 ? 10.sp : 6.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w700,
);
final titleSmall = TextStyle(
  fontSize: 100.w < 500 ? 10.sp : 6.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w300,
);

final headlineLarge = TextStyle(
    fontSize: 100.w < 500 ? 13.sp : 8.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white);
final headlineMedium = TextStyle(
  fontSize: 100.w < 500 ? 10.sp : 6.sp,
  color: kTextColor,
  fontWeight: FontWeight.w300,
);
final headlineSmall = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 8.sp,
  color: Colors.white,
  fontWeight: FontWeight.w300,
);

final labelLarge = TextStyle(
  fontSize: 100.w < 500 ? 12.sp : 8.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w300,
);
final labelMedium = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 7.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w300,
);
final bodyMedium = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 7.sp,
  color: kTxtColor,
  fontWeight: FontWeight.w300,
);
final labelSmall = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 8.sp,
  color: kTextColor,
  fontWeight: FontWeight.w300,
);
final displayLarge = TextStyle(
  fontSize: 100.w < 500 ? 11.sp : 8.sp,
  color: kTextColor,
  fontWeight: FontWeight.w300,
);

final txtBodySmall =
    TextStyle(fontSize: 100.w < 500 ? 10.sp : 8.sp, color: kTxtColor);
final defaultTheme = ThemeData(
  textTheme: TextTheme(
      displayLarge: displayLarge,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodySmall: txtBodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
      bodyMedium: bodyMedium),
  fontFamily: GoogleFonts.poppins().fontFamily,
  primarySwatch: MaterialColor(0xFFB72957, colorConversion),
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
