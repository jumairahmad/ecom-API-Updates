import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SplashController extends GetxController {
  int page = 0;
  LiquidController liquidController = LiquidController();
  final apiController = Get.put(ApiController());
  final homeController = Get.put(HomeController());
  BuildContext? context;

  @override
  void onInit() {
    apiController.checkConnectivity().then((value) {
      homeController.isDeviceConnected = value;
      update();
      if (value) {
        homeController.authBrand();
      }
    });

    super.onInit();
  }

  pageChangeCallback(int lpage) {
    page = lpage;
  }
}
