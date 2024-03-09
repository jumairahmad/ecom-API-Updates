import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Color mainColor = const Color(0xffBD345D);

Color yellowcolor = const Color(0xffF1A501);
Color greencolor = const Color(0xffA8DF64);
Color lightPinkcolor = const Color(0xffDF7475);

TextStyle detailsTitlesTextStyle = TextStyle(
    color: const Color.fromRGBO(105, 109, 118, 1),
    //fontFamily: 'Nunito',
    fontSize: 12.sp,
    letterSpacing: 0.1 /*percentages not used in flutter. defaulting to zero*/,
    fontWeight: FontWeight.w400,
    height: 1);

TextStyle detailsValuesTextStyle = TextStyle(
    color: const Color(0xff454953),
    //fontFamily: 'Nunito',
    fontSize: 14.sp,
    letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
    fontWeight: FontWeight.w700,
    height: 1);

TextStyle rewardstitleTextStyle = TextStyle(
    color: const Color.fromRGBO(4, 3, 3, 1),
    //fontFamily: 'Nunito',
    fontSize: 25.sp,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w600,
    height: 0.72);

TextStyle yourbalanceTitleTextStyle = TextStyle(
    color: Color.fromRGBO(189, 52, 93, 1),
    //fontFamily: 'Nunito',
    fontSize: 100.w < 500 ? 12.sp : 9.sp,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w400,
    height: 1.125);

TextStyle balancevalueTextStyle = TextStyle(
    color: Color.fromRGBO(189, 52, 93, 1),
    //fontFamily: 'Nunito',
    fontSize: 100.w < 500 ? 26.sp : 15.sp,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w700,
    height: 0.4);
