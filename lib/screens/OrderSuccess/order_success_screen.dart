import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Image.asset(
                  'assets/images/successicon.png',
                  width: 60.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Order Successfull !',
                  style: TextStyle(
                    //fontFamily: 'Roboto',
                    fontSize: 100.w < 500 ? 18.sp : 14.sp,
                    color: kTxtColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Thank you for your order ',
                  style: TextStyle(
                    //fontFamily: 'Roboto',
                    fontSize: 100.w < 500 ? 14.sp : 10.sp,
                    color: kTextColor,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                  //textScaleFactor: 1.0,
                ),
                SizedBox(
                  height: 10.h,
                ),
                // SizedBox(
                //     height: 6.h,
                //     width: 80.w,
                //     child: PrimaryButton(
                //         title: 'Track the Driver',
                //         height: 4.h,
                //         width: 70.w,
                //         callback: () {
                //           Get.toNamed(route.orderTrackPage);
                //         },
                //         fontSize: 16.sp)),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                    height: 6.h,
                    width: 80.w,
                    child: PrimaryLightButton(
                      'Back To Home',
                      4.h,
                      70.w,
                      () {
                        Get.offAllNamed(route.homePage);
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
