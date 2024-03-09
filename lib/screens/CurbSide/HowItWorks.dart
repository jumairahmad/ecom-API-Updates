// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../constants.dart';

class CurbLayout extends StatelessWidget {
  const CurbLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: 100.h,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  top: 5.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 48.w,
                      child: Text(
                        'CURBSIDE PICKUP',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 100.w < 500 ? 24.sp : 16.sp,
                            color: kPrimaryColor,
                            letterSpacing: 1.435,
                            fontWeight: FontWeight.w800,
                            height: 0.8571428571428571,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 13.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'How it works',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 100.w < 500 ? 14.sp : 10.sp,
                          color: kPrimaryColor,
                          letterSpacing: 1.435,
                          fontWeight: FontWeight.w800,
                          height: 0.8571428571428571,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 18.h,
                  left: 7.5.w,
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    width: 85.w,
                    height: 70.h,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 20,
                          child: Column(
                            children: [
                              CardWidget(
                                'assets/icons/Group1.png',
                                'Select Your Vehicle Type',
                              ),
                              CardWidget(
                                'assets/icons/Group2.png',
                                'Pull Into The Designated\nCurbside Parking Spot',
                              ),
                              CardWidget(
                                'assets/icons/Group3.png',
                                'Tell Us When You Arrive',
                              ),
                              CardWidget(
                                'assets/icons/Group4.png',
                                'We’ll Start Your Order\n And Bring It Right Out',
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: SizedBox(
                                  height: 6.h,
                                  width: 75.w,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    onPressed: () => {
                                      Navigator.pushNamed(
                                          context, route.curbSideSelectVehicle)
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // Replace with a Row for horizontal icon + text
                                      children: <Widget>[
                                        Text(
                                          'CHOOSE YOUR VEHICLE',
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize:
                                                  100.w < 500 ? 9.5.sp : 7.sp,
                                              color: kPrimaryColor,
                                              letterSpacing: 1.435,
                                              fontWeight: FontWeight.w800,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        CircleAvatar(
                                          radius: 3.w,
                                          backgroundColor: kPrimaryColor,
                                          child: Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white,
                                            size: 100.w < 500 ? 6.w : 4.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // PAGE FORM
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final icon;
  final title;
  CardWidget(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 10.h,
        width: 85.w,
        child: Stack(
          children: [
            Positioned(
              top: 1.2.h,
              left: 4.w,
              child: Container(
                height: 6.h,
                width: 75.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 100.w < 500 ? 9.5.sp : 7.sp,
                          color: kPrimaryColor,
                          letterSpacing: 1.435,
                          fontWeight: FontWeight.w800,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 3.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 5)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 100.w < 500 ? 8.5.w : 6.w,
                    backgroundColor: kPrimaryColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100.w < 500 ? 7.5.w : 5.w,
                      child: Image.asset(
                        icon,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
