import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/screens/LoyaltyHistory/model/LoyaltyHistorymodel.dart';
import 'package:get/get.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

class LoyaltyHistoryController extends GetxController {
  LoyaltyHistoryModel1 loyaltyHistoryModel = LoyaltyHistoryModel1();
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
      getRewardDetails();
    }
  }

  void getRewardDetails() async {
    apiController.checkConnectivity().then((value) async {
      if (value) {
        isLoading = true;
        await apiController
            .apiCall('Coupons/GetHistoryByCustomer')
            .then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));
          String jsonData = jsonEncode(apiResponse.successcode).toString();

          loyaltyHistoryModel =
              LoyaltyHistoryModel1.fromJson(jsonDecode(jsonData));
          isLoading = false;
          update();
        });
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
