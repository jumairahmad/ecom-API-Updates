// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, constant_identifier_names, must_be_immutable

import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class SignLayout extends StatelessWidget {
  String? pageTitle;
  Widget? pageForm;
  Widget? bottomWidget;
  Widget? backgroundImage;
  SignLayout(
      {@required this.pageTitle,
      @required this.pageForm,
      this.bottomWidget,
      this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  height: 45.h,
                  child: Pinned.fromPins(
                    Pin(size: 259.0, end: -6.0),
                    Pin(size: 270.1, start: -21.1),
                    child: SvgPicture.string(
                      _svg_c4p6w,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            backgroundImage!,
            Positioned.fill(
              top: 4.h,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  pageTitle!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 100.w < 500 ? 18.sp : 14.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            // PAGE FORM

            Positioned(
              top: 100.w < 500
                  ? pageTitle == "Sign up"
                      ? 11.h
                      : 14.h
                  : pageTitle == "Sign up"
                      ? 13.h
                      : 17.h,
              left: 4.w,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryLightColor,
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: 92.w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: pageForm,
                ),
              ),
            ),
            bottomWidget! // BOTTOM TEXT
          ],
        ),
      ),
    );
  }
}

const String _svg_c4p6w =
    '<svg viewBox="122.0 -21.1 259.0 270.1" ><path transform="translate(-2768.0, 2115.41)" d="M 2949.1201171875 -2125.83251953125 C 2949.1201171875 -2125.83251953125 2891.016845703125 -2113.84423828125 2890.047119140625 -2083.456787109375 C 2889.077392578125 -2053.06982421875 2945.065185546875 -2051.265380859375 3002.635986328125 -2046.403442382812 C 3060.206787109375 -2041.541381835938 3106.192626953125 -2019.043701171875 3108.869140625 -1959.169067382812 C 3111.545654296875 -1899.294555664062 3118.503662109375 -1875.752075195312 3138.45751953125 -1869.57080078125 C 3158.411376953125 -1863.389404296875 3144.008056640625 -1868.174682617188 3144.008056640625 -1868.174682617188 L 3144.008056640625 -2125.83251953125 C 3144.008056640625 -2125.83251953125 3105.101318359375 -2136.619140625 3100.61669921875 -2136.46630859375 C 3096.132080078125 -2136.313232421875 3013.591064453125 -2136.46630859375 3013.591064453125 -2136.46630859375 L 2949.1201171875 -2125.83251953125 Z" fill="#bd345d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
