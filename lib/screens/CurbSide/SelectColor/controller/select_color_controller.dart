// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/screens/CurbSide/SelectColor/model/select_color_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:e_commerce/WebHook/Controller/ApiController.dart';

class SelectColorController extends GetxController {
  List<SelectColorModel> select_colors = [];
  final apiController = Get.put(ApiController());
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {}
  }

  @override
  void onInit() {
    initValues();
    super.onInit();
  }

  void initValues() {
    apiController.checkConnectivity().then((value) {
      if (value) {
        select_colors = [
          SelectColorModel('White', Colors.white),
          SelectColorModel('Silver', Colors.amber),
          SelectColorModel('Grey', Colors.grey),
          SelectColorModel('Black', Colors.black),
          SelectColorModel('Gold', Colors.blueGrey),
          SelectColorModel('Red', Colors.red),
          SelectColorModel('Blue', Colors.blueAccent),
          SelectColorModel('Green', Colors.green),
          // SelectColorModel('White', Colors.white),
        ];
        update();
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }
}
