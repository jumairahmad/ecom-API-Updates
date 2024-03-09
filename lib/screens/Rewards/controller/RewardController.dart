import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/screens/Rewards/constants/Constants.dart';
import 'package:e_commerce/screens/Rewards/model/RewardModel.dart';
import 'package:e_commerce/screens/Rewards/model/chartmodel.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

class RewardController extends GetxController {
  RewardModel rewardModel = RewardModel();
  final apiController = Get.put(ApiController());
  List<ChartData> chartData = [];
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
    PermissionService.getNotificationService();
    apiController.checkConnectivity().then((value) async {
      if (value) {
        isLoading = true;
        await apiController
            .apiCall('Coupons/GetRewardsByCustomerID')
            .then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));
          String jsonData = jsonEncode(apiResponse.successcode).toString();

          rewardModel = RewardModel.fromJson(jsonDecode(jsonData));
          updateChart(
              rewardModel.balance!, rewardModel.redeemed!, rewardModel.earned!);
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

  void updateChart(double balance, double redeeemed, double earned) {
    chartData = [
      ChartData('Balance', balance, greencolor),
      ChartData('Redeemed', redeeemed, lightPinkcolor),
      ChartData('Earned', earned, yellowcolor),
    ];
  }
}
