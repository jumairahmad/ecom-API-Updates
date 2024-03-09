// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce/screens/OrderStatus/Controller/OrderStatusController.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:e_commerce/screens/OrderHistory/models/OrderHistoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/routes.dart' as route;

class OrderHistoryController extends GetxController {
  ApiController apiController = Get.put(ApiController());
  final orderController = Get.put(OrderController());
  OrderModel orderModel = OrderModel();
  List<OrderHistoryModel>? orderHistoryList;
  List<OrderHistoryModel> deliveredOrders = [];
  List<OrderHistoryModel> notDelivered = [];

  bool isLoading = true;
  bool isDeviceConnected = true;
  final orderStatusController = Get.put(OrderStatusController());
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getOrderHistoryData(isDeviceConnected);
    }
  }

  @override
  void onInit() {
    apiController.checkConnectivity().then((value) {
      if (value) {
        getOrderHistoryData(value);
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

    super.onInit();
  }

  void onRefresh() async {
    isLoading = true;
    await Future.delayed(Duration(milliseconds: 100));
    apiController.checkConnectivity().then((value) {
      getOrderHistoryData(value);
    });

    update();
  }

  void getOrderHistoryData(bool isConnected) {
    isLoading = true;
    isDeviceConnected = isConnected;

    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('Order/GetOrders').then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              String catData = jsonEncode(apiResponse.successcode).toString();

              List parsedCat = json.decode(catData);

              orderHistoryList = parsedCat
                  .map((item) => OrderHistoryModel.fromJson(item))
                  .toList();
              orderHistoryList!
                  .sort((a, b) => b.orderID!.compareTo(a.orderID!));

              deliveredOrders = parsedCat
                  .map((item) => OrderHistoryModel.fromJson(item))
                  .toList();
              deliveredOrders
                  .removeWhere((element) => element.orderStatus != "Delivered");
              isLoading = false;

              update();
            } else {
              print('No Order History Found');
            }
          });
        } catch (exception) {
          print('Exception in Order Histroy In Server');
        }
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

    update();
  }

  void btnTrackOrder_onPressed(BuildContext context, String orderID) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        orderStatusController.getOrderData(orderID);

        Get.toNamed(route.orderStatusPage);
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }

  void orderAgainPressed(BuildContext context, String orderID) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('Order/GetOrderDetailsByID_v2',
              {"orderID": orderID}).then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));
            if (apiResponse.success == 'true') {
              String jsonData = jsonEncode(apiResponse.successcode).toString();
              var parsedData = json.decode(jsonData);
              log((jsonData));

              orderModel = OrderModel.fromJson(parsedData);

              update();
            } else {
              print('Api not responding in get order by id in history');
            }
          });
        } catch (exception) {
          print('exception while retrieving the order from order again ');
        }
        update();
        for (var element in orderModel.receipt!.entries!) {
          orderController.addOrder(element);
        }
        orderController.update();
        Navigator.of(context).pop();
        Get.toNamed(route.homePage);
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
