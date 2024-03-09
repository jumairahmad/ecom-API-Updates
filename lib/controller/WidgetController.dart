import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';

import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class WidgetController extends GetxController {
  final apiController = Get.put(ApiController());
  final homeController = Get.put(HomeController());

  int selectedNav = 0;
  int cartItemCount = 0;
  int itemQuantity = 1;
  int dotCount = 1;
  double position = 0;
  int currentNav = 0;

  String address = '';
  String orderType = 'Delivery';

  @override
  void onInit() {
    PermissionService.getLocationService();
    apiController.checkConnectivity().then((value) => setDefault(value));
    super.onInit();
  }

  void setDefault(bool val) {
    homeController.isDeviceConnected = val;
    homeController.update();
    if (val) {
      getUserLocation();
      update();
    }
  }

  void getUserLocation() {
    PermissionService.getLocationService();
    Future<Position> pos = determinePosition();
    (pos.then((value) {
      getAddressFromLatLng(value.latitude, value.longitude);
    }).onError((error, stackTrace) {
      log(' Location error Widget Controller' + error.toString());
    }));
  }

  void getAddressFromLatLng(double lat, double lng) async {
    String googleMapApi = "AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=$googleMapApi&language=en&latlng=$lat,$lng';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      //print(jsonDecode(response.body));
      String formattedAddress = data["results"][0]["formatted_address"];
      // double lat = data["results"][0]["geometry"]["location"]["lat"];
      // double lng = data["results"][0]["geometry"]["location"]["lng"];
      address = formattedAddress;

      homeController.userCurrentLoc = LatLng(lat, lng);
      homeController.update();
      update();
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void updateorderType(String val) {
    orderType = val;
    update();
  }

  void updateCartCount(int val) {
    if (cartItemCount > 0) {
      cartItemCount + val;
      print("running increase");
    } else {
      cartItemCount = val;
      print("runnin change");
    }

    update();
  }

  void updateItemQuantity(int val) {
    itemQuantity = val;
    update();
  }

  void updateSelectedNav(int val) {
    selectedNav = val;
    update();
  }
}
