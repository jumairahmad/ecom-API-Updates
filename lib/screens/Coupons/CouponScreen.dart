// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/Coupons/model/CouponModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import 'controller/couponController.dart';

class CouponScreen extends StatelessWidget {
  CouponScreen({Key? key}) : super(key: key);
  final couponController = Get.put(CouponController());
  final orderController = Get.put(OrderController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    const bodyColor = Color(0xfffaf1f1);

    // Figma Flutter Generator LoyaltyscreenWidget - FRAME
    return GetBuilder<CouponController>(builder: (controller) {
      return Scaffold(
        backgroundColor: bodyColor,
        //resizeToAvoidBottomInset: true,
        appBar: getPageAppBar(context, 'Current Coupons', () {
          Navigator.of(context).pop();
        }, () {
          Navigator.of(context).pop();
        }, bodyColor),
        body: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: controller.isDeviceConnected
                          ? ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.couponList.length,
                              itemBuilder: (BuildContext ctx, int index) {
                                return CouponCard(
                                    couponModel: controller.couponList[index]);
                              })
                          : NoInternetWiget(
                              btnController, controller.btnReload_onClick),
                    ),
                  ],
                ),
              ),
        //bottomNavigationBar: CustomBottomNav(),
      );
    });
  }
}

class CouponCard extends StatelessWidget {
  CouponModel? couponModel;

  CouponCard({this.couponModel});

  @override
  Widget build(BuildContext context) {
    final couponController = Get.put(CouponController());
    const bodyColor = Color(0xfffaf1f1);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: SizedBox(
        height: 16.5.h,
        width: 95.w,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: Colors.white,
                height: 16.5.h,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                backgroundColor: bodyColor,
                radius: 2.5.w,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                backgroundColor: bodyColor,
                radius: 2.5.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: SizedBox(
                width: 58.w,
                height: 20.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(couponModel!.storeName!,
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(couponModel!.couponCode!,
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(
                      height: 5.5.h,
                      width: 56.w,
                      child: Text(couponModel!.couponMessage!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    Text(couponModel!.couponDate!,
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 7.w),
                child: Container(
                  height: 9.5.h,
                  width: 25.w,
                  color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 23.w,
                        height: 100.w < 500 ? 2.h : 3.h,
                        color: Colors.white,
                        child: Text(
                          "DISCOUNT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffd20c0c),
                            fontSize: 100.w < 500 ? 7.sp : 8.sp,
                            //fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3.33,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        couponModel!.couponAmount!.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 100.w < 500 ? 25.83 : 10.sp,
                          //fontFamily: "Roboto",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(right: 7.w),
                child: SizedBox(
                  height: 4.h,
                  width: 25.w,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        couponController.btnUseNow_onPressed(
                            context, couponModel!);
                      },
                      child: Text(
                        "Use now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffbd345d),
                          fontSize: 100.w < 500 ? 16 : 8.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
