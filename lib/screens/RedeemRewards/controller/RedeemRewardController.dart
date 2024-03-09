// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:e_commerce/screens/Coupons/controller/couponController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/WebHook/Controller/ApiController.dart';

class ReedemRewardController extends GetxController {
  double rewardBalance = 5.40;
  List<BtnAmountModel> btnAmountList = [];
  GlobalKey<FabCircularMenuState> fabKey = GlobalKey<FabCircularMenuState>();
  TextEditingController txtAmountController = TextEditingController();
  final couponController = Get.put(CouponController());
  final apiController = Get.put(ApiController());
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getPaymentMethods();
    }
  }

  @override
  void onInit() {
    // to check for permissions

    PermissionService.getNotificationService();

    apiController.checkConnectivity().then((value) {
      if (value) {
        txtAmountController.text = '1';
        getPaymentMethods();
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });

    super.onInit();
  }

  void btnVoucher_onPressed(BuildContext context) {
    PermissionService.getNotificationService();
    double amount = double.parse(txtAmountController.text);

    couponController.addCoupon(amount);
    couponController.update();
  }

  void getPaymentMethods() {
    String jsonData = '['
        '{"amount": "1","isSelected":"true"},'
        '{"amount": "2","isSelected":"false"},'
        '{"amount": "3","isSelected":"false"},'
        '{"amount": "4","isSelected":"false"},'
        '{"amount": "5","isSelected":"false"}'
        ']';

    final List parsedJson = jsonDecode(jsonData);
    btnAmountList =
        parsedJson.map((item) => BtnAmountModel.fromJson(item)).toList();
  }
}

class BtnAmountModel {
  String? amount;
  String? isSelected;

  BtnAmountModel({this.amount, this.isSelected});

  factory BtnAmountModel.fromJson(Map<String, dynamic> json) {
    final amount = json['amount'];

    final isSelected = json['isSelected'];

    return BtnAmountModel(
      amount: amount,
      isSelected: isSelected,
    );
  }
}
