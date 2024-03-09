// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'controller/NotificationController.dart';
import 'package:e_commerce/routes.dart' as route;

class NotificationScreen extends StatelessWidget {
  final notificationController = Get.put(NotificationController());
  final btnController = RoundedLoadingButtonController();
  NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void btnClose_onPressed() {
      Get.toNamed(route.homePage);
    }

    return Scaffold(
      appBar: getPageAppBar(context, "Notifications", btnClose_onPressed, () {
        Navigator.pop(context);
      }),
      body: GetBuilder<NotificationController>(builder: (controller) {
        return controller.notificationList == null &&
                    controller.failReason == 'no' ||
                controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                height: 100.h,
                width: 100.w,
                child: controller.isDeviceConnected
                    ? Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Flexible(
                            flex: 3,
                            child: controller.failReason != 'no'
                                ? Center(
                                    child: Text(controller.failReason),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        controller.notificationList!.length,
                                    itemBuilder: (context, index) {
                                      return Notifications(
                                        controller
                                            .notificationList![index].message!,
                                        // notificationController.notificationList[index].detail!,
                                        '',
                                        controller.notificationList![index]
                                            .notificationTime!,
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: BorderSide(color: Colors.red)))),
                            child: SizedBox(
                                width: 35.w,
                                height: 100.w < 500 ? 4.5.h : 4.h,
                                child: Center(
                                    child: Text(
                                  "Clear",
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.fontSize,
                                      fontWeight: FontWeight.w600),
                                ))),
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      )
                    : NoInternetWiget(
                        btnController, controller.btnReload_onClick),
              );
      }),
    );
  }
}
