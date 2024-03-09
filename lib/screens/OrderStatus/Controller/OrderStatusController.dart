import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/services/PermissionServices.dart';

import 'package:get/get.dart';

import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

import '../../Order/models/CreateOrderModel.dart';
import '../Model/OrderStatusModel.dart';

class OrderStatusController extends GetxController {
  ApiController apiController = Get.put(ApiController());
  String? orderID;
  bool isLoading = true;
  CreateOrder? order;

  List<OrderStatusModel> statusList = [];

  void getOrderStatus(String id) {
    orderID = id;
    try {
      apiController
          .apiCall('Order/GetOrdersStatusByID', {"orderID": id}).then((value) {
        final apiResponse = api_model.Response.fromJson(jsonDecode(value));

        if (apiResponse.success == 'true') {
          print(apiController.authToken);
          String catData = jsonEncode(apiResponse.successcode).toString();
          log(catData);
          List parsedCat = json.decode(catData);

          statusList =
              parsedCat.map((item) => OrderStatusModel.fromJson(item)).toList();

          // log(retrivedOrder.toString());
          isLoading = false;
          update();
        } else {
          print('No Order History Found');
        }
      });
    } catch (exception) {
      print('Exception is Fething Order from server ');
    }
    update();
  }

  void getOrderData(String orderID) {
    isLoading = true;
    try {
      PermissionService.getNotificationService();
      apiController.apiCall(
          'Order/GetOrderDetailsByID_v2', {"orderID": orderID}).then((value) {
        final apiResponse = api_model.Response.fromJson(jsonDecode(value));
        if (apiResponse.success == 'true') {
          String jsonData = jsonEncode(apiResponse.successcode).toString();
          var parsedData = json.decode(jsonData);
          log((jsonData));

          order = CreateOrder.fromJson(parsedData);
          isOrderPickup();
          getOrderStatus(orderID);

          update();
        } else {
          print('Api not responding in get order by id in history');
        }
      });
    } catch (exception) {
      print('exception while retrieving the order from order again ');
    }
    update();
  }

  bool isOrderAccepted() {
    bool accepted = false;

    for (var element in statusList) {
      if (element.orderStatus == "Pending") {
        accepted = true;
      }
    }

    return accepted;
  }

  bool isOrderReceived() {
    bool received = false;

    for (var element in statusList) {
      if (element.orderStatus == "Received") {
        received = true;
      }
    }

    return received;
  }

  bool isOrderProcessing() {
    bool processing = false;

    for (var element in statusList) {
      if (element.orderStatus == "Processing") {
        processing = true;
      }
    }

    return processing;
  }

  bool isOrderReady() {
    bool ready = false;

    for (var element in statusList) {
      if (element.orderStatus == "Ready") {
        ready = true;
      }
    }

    return ready;
  }

  bool isOrderOnRoute() {
    bool onRoute = false;

    for (var element in statusList) {
      if (element.orderStatus == "OnRoute") {
        onRoute = true;
      }
    }

    return onRoute;
  }

  bool isOrderDelivered() {
    bool accepted = false;

    for (var element in statusList) {
      if (element.orderStatus == "Delivered") {
        accepted = true;
      }
    }

    return accepted;
  }

  bool isOrderPickup() {
    bool isOrderPickup = false;

    if (order != null) {
      if (order!.orderType == "Pickup" || order!.orderType == "CurbSide") {
        isOrderPickup = true;
      }
    }
    print(isOrderPickup);
    return isOrderPickup;
  }

  bool isOrderPickedUp() {
    bool accepted = false;

    for (var element in statusList) {
      if (element.orderStatus == "Pickedup") {
        accepted = true;
      }
    }

    return accepted;
  }
}
