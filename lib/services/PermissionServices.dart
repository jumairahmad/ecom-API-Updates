import 'dart:developer';

import 'package:e_commerce/constants.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static getLocationService() async {
    var location = await Permission.location.status;
    print(location);

    // this line will check for permission while using the app
    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      print("detecting true for enabled location");
      //await Permission.location.request();
      await Permission.location.request();
      // Use location.
    }

    if (location.isDenied || location.isLimited || location.isRestricted) {
      print('here in the denied');

      await Permission.location.request();
    }
    if (location.isPermanentlyDenied) {
      Get.defaultDialog(
          title: "Open Settings",
          middleText: "Are you sure to open settings ?",
          radius: 20,
          textConfirm: "Yes",
          textCancel: "No",
          cancelTextColor: kTextColor,
          confirmTextColor: kPrimaryColor,
          onCancel: () {},
          onConfirm: () async {
            openAppSettings();
            await Permission.location.request();
          });
    }
  }

  static getNotificationService() async {
    var notification = await Permission.notification.status;
    log(notification.name);
    if (notification.isDenied ||
        notification.isLimited ||
        notification.isRestricted) {
      await Permission.notification.request();
    }
    if (notification.isPermanentlyDenied) {
      Get.defaultDialog(
          title: "Open Settings",
          middleText: "Are you sure to open settings ?",
          radius: 20,
          textConfirm: "Yes",
          textCancel: "No",
          cancelTextColor: kTextColor,
          confirmTextColor: kPrimaryColor,
          onCancel: () {},
          onConfirm: () async {
            openAppSettings();
            await Permission.notification.request();
          });
    }
  }
}
