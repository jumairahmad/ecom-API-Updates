import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/screens/CurbSide/CurbSideOrder/model/CurbSideOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/routes.dart' as route;

class CurbSideOrderController extends GetxController {
  CurbSideOrderModel curbSide = CurbSideOrderModel();
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

  void onParkingSelected(BuildContext context, String parkingID) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        curbSide.curbSideParkingID = parkingID;
        try {
          apiController
              .apiCall('Order/SendCurbsidePickupLocation', (curbSide.toJson()))
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == "true") {
              updateOrderStatus(context);
            } else {
              log('Api Exception: ' + apiResponse.failreason!);
              update();
              Get.toNamed(route.orderFailurePage);
            }
          });
        } catch (exception) {
          Get.toNamed(route.orderFailurePage);

          print('Server Exception in in Order Create');
        }
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }

  void updateOrderStatus(BuildContext context) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('Order/ChangeStatus', {
            "Status": "ArrivedAtCurbSide",
            "orderID": curbSide.orderID
          }).then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == "true") {
              apiController.apiCall('Order/ChangeStatus',
                  {"Status": "Pickedup", "orderID": curbSide.orderID});
              curbSide = CurbSideOrderModel();
              update();
              Navigator.pushNamedAndRemoveUntil(
                  context, route.orderSuccessPage, (route) => false);
            } else {
              log('Api Exception: ' + apiResponse.failreason!);
              update();
              Get.toNamed(route.orderFailurePage);
            }
          });
        } catch (exception) {
          Get.toNamed(route.orderFailurePage);

          print('Server Exception in in Order Create');
        }
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
