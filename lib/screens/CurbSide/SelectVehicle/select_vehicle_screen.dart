import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/Widgets.dart';
import 'controller/selectvehiclecontroller.dart';
import 'helperwidgets/vehiclewidgets.dart';

class SelectVehicleScreen extends StatelessWidget {
  SelectVehicleScreen({Key? key}) : super(key: key);
  final selecVehicleController = Get.put(SelectVehicleController());

  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Positioned(
            left: 4,
            top: 3.h,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Color(0xffa81947),
              iconSize: 100.w < 500 ? 8.w : 5.w,
            ),
          ),
          Positioned(
            top: 100.w < 500 ? 8.h : 7.h,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 100.w < 500 ? 9.w : 3.w),
              child: Text(
                'Select Vehicle Type',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 100.w < 500 ? 18.sp : 13.sp,
                  color: Color(0xffb72957),
                  letterSpacing: 1.435,
                  fontWeight: FontWeight.w800,
                  height: 1.1428571428571428,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          GetBuilder<SelectVehicleController>(builder: (controller) {
            return controller.isDeviceConnected
                ? Positioned(
                    top: 100.w < 500 ? 15.h : 12.h,
                    bottom: 0,
                    child: SizedBox(
                      height: 100.h,
                      width: 100.w,
                      //margin: EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,

                          //physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(25.0),
                          crossAxisSpacing: 30.0,
                          mainAxisSpacing: 30.0,
                          crossAxisCount: 2,
                          children: controller.select_vehicles
                              .map(
                                (e) => VehicleWidget(
                                  vehiclename: e.vehicleName,
                                  vehicleimage: e.imageName,
                                  details: e.vehicleDetail,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  )
                : NoInternetWiget(btnController, controller.btnReload_onClick);
          }),
        ],
      ),
    );
  }
}
