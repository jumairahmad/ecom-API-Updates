import 'dart:async';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/screens/Notification/model/NotificationModel.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

class NotificationController extends GetxController {
  //late String jsonData;
  List<NotificationModel>? notificationList;
  //List<NotificationModelb>? notificationListb;
  String failReason = 'no';
  final apiController = Get.put(ApiController());
  bool isLoading = true;
  Timer? timer;

  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getNotifications();
    }
  }

  @override
  void onInit() {
    getNotifications();

    super.onInit();
    // timer =
    //     Timer.periodic(Duration(seconds: 5), (Timer t) => getNotifications());
  }

  void getNotifications() {
    isLoading = true;
    PermissionService.getNotificationService();
    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController
              .apiCall('CustomerNotifications/GetUnreadList')
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              String notData = jsonEncode(apiResponse.successcode).toString();
              List parsedNoti = jsonDecode(notData);

              notificationList ??= parsedNoti
                  .map((item) => NotificationModel.fromJson(item))
                  .toList();
              isLoading = false;
              update();
            } else {
              failReason = apiResponse.failreason!;
              print('falied In Getting Notification response');
              update();
              isLoading = false;
            }
          });
        } catch (exception) {
          print('Exception in Notification Server');
        }
        update();
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
}


// created modifiend

// pages used in

//General details about

// orignal reference JSon file Name

//model references
