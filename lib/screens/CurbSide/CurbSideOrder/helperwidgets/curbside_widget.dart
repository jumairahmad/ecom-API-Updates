// ignore_for_file: must_be_immutable

import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class CurbSideOrderButtonWidget extends StatelessWidget {
  int buttonid;
  VoidCallback onpressed;
  final btnController = RoundedLoadingButtonController();
  CurbSideOrderButtonWidget(
      {Key? key, required this.buttonid, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: btnController,
      animateOnTap: true,
      height: 7.h,
      width: 15.w,
      resetDuration: Duration(seconds: 3),
      resetAfterDuration: true,
      errorColor: kPrimaryColor,
      successColor: kTextColor,
      onPressed: onpressed,
      color: kPrimaryColor,
      child: Text(
        buttonid.toString(),
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: buttonid >= 10 ? 10.sp : 12.sp,
          color: const Color(0xffffffff),
          letterSpacing: 1.353,
          fontWeight: FontWeight.w800,
          height: 1.121212121212121,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.left,
      ),

      // child: ElevatedButton(
      //   style: ButtonStyle(
      //       backgroundColor: MaterialStateProperty.all(const Color(0xffb72957)),
      //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //           RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(18.0),
      //               side: BorderSide(color: const Color(0xffb72957))))),
      //   onPressed: onpressed,
      //   child: Text(
      //     buttonid.toString(),
      //     style: TextStyle(
      //       fontFamily: 'Montserrat',
      //       fontSize: buttonid >= 10 ? 20 : 33,
      //       color: const Color(0xffffffff),
      //       letterSpacing: 1.353,
      //       fontWeight: FontWeight.w800,
      //       height: 1.121212121212121,
      //     ),
      //     textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
      //     textAlign: TextAlign.left,
      //   ),
      // ),
    );
  }
}
