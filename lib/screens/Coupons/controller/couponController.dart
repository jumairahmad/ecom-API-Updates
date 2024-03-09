// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Coupons/model/CouponModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

class CouponController extends GetxController {
  List<CouponModel> couponList = [];
  final orderController = Get.put(OrderController());
  final apiController = Get.put(ApiController());
  bool isLoading = true;
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getData();
    }
  }

  void getData() async {
    PermissionService.getNotificationService();
    apiController.checkConnectivity().then((value) async {
      if (value) {
        isLoading = true;
        await apiController
            .apiCall('Coupons/GetCurrentCouponsByCustomer')
            .then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));
          String jsonData = jsonEncode(apiResponse.successcode).toString();
          final list = json.decode(jsonData) as List<dynamic>;

          couponList = list.map((e) => CouponModel.fromJson(e)).toList();
          isLoading = false;
          update();
        });
      } else {
        isDeviceConnected = false;
        isLoading = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      isLoading = false;
      update();
    });
  }

  void updateCoupon(CouponModel couponModel) {
    // couponList.firstWhere((element) => element == couponModel).isEnabled ==
    //     "false";
    update();
  }

  void addCoupon(double discount) {
//    couponList.sort((a, b) => a.id!.compareTo(b.id!));
    CouponModel couponModel = CouponModel();
    couponModel.couponIssuedID = couponList.last.couponIssuedID! + 1;

    couponModel.storeName =
        apiController.brandAuth.locations!.first.locationname;
    couponModel.couponAmount = discount;
    couponModel.couponDate = couponList.last.couponDate;
    couponModel.couponCode = couponList.last.couponCode! + '_1';
    couponModel.couponMessage = couponList.last.couponMessage;
    // couponModel.isEnabled = "true";
    couponList.add(couponModel);
    update();
  }

  void btnUseNow_onPressed(BuildContext context, CouponModel couponModel) {
    if (orderController.order.receipt!.entries!.isEmpty) {
      snackBar('Empty cart', 'Please add items to your cart to get voucher');
    } else if (orderController.order.receipt!.entries!.isNotEmpty) {
      if (orderController.getOrderSubTotal() >= (couponModel.couponAmount!)) {
        orderController.applyCoupon(couponModel);
        Navigator.popAndPushNamed(context, route.orderPage);
      } else {
        snackBar('Add more items in cart',
            'Voucher amount can not exceed Order Sub Total amount ');
      }
    }
  }
}
