// ignore_for_file: must_be_immutable

import 'package:e_commerce/screens/CurbSide/CurbSideOrder/controller/CurbSideOrderController.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VehicleWidget extends StatelessWidget {
  final curbSideOrderController = Get.put(CurbSideOrderController());
  String vehiclename;
  String vehicleimage;
  String details;

  VehicleWidget(
      {Key? key,
      required this.vehiclename,
      required this.vehicleimage,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        curbSideOrderController.curbSide.vehicleType = vehiclename;
        curbSideOrderController.update();
        Get.toNamed(route.curbSideSelectColor);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color(0xffb72957),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 12,
              left: 6,
              child: Text(
                vehiclename,
                style: TextStyle(
                  fontSize: 100.w < 500 ? 12.sp : 9.sp,
                  color: const Color(0xffffffff),
                  letterSpacing: 0.738,
                  fontWeight: FontWeight.w800,
                  height: 0.8888888888888888,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 6.h,
              left: -35,
              child: Image.asset(
                'assets/images/Curbside/$vehicleimage',
                height: 11.h,
                width: 34.w,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
