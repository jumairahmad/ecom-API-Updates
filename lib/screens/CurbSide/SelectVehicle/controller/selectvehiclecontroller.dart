// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/screens/CurbSide/SelectVehicle/model/selectvehiclemodel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:e_commerce/WebHook/Controller/ApiController.dart';

class SelectVehicleController extends GetxController {
  String detail = '';
  List<SelectVehicleModel> select_vehicles = [];
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
        detail =
            'defined as a 4-door passenger car with a \n trunk that is separate from the passengers \nwith a three-box body: the engine,'
            '\n the area for passengers,\n and the trunk.';

        select_vehicles = [
          SelectVehicleModel(
              vehicleName: 'Sedan',
              imageName: 'veisal.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'Van',
              imageName: 'pickuptruck.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'Truck',
              imageName: 'fourbfour.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'Convertible',
              imageName: 'car.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'MotorBike',
              imageName: 'bike.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'SUV', imageName: 'tz.png', vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'Crossover',
              imageName: 'veisal.png',
              vehicleDetail: detail),
          SelectVehicleModel(
              vehicleName: 'I dont have \n Vehicle',
              imageName: 'veisal.png',
              vehicleDetail: detail),
          //SelectVehicleModel(vehicleName: 'Sedan', imageName: 'veisal', vehicleDetail:detail ),
          //SelectVehicleModel(vehicleName: 'Sedan', imageName: 'veisal', vehicleDetail:detail ),
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
