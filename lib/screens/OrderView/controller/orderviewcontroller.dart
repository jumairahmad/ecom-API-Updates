// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/CreateOrderModel.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';

import 'package:e_commerce/screens/OrderView/models/orderview_model.dart';
import 'package:e_commerce/screens/OrderView/controller/orderlistcontroller.dart';
import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'dart:ui' as ui;
import 'package:e_commerce/routes.dart' as route;

import 'package:sizer/sizer.dart';

OrderView_model orderView_controller = OrderView_model(
    '1342 Washington ave \n street brokylyn 13324',
    'paypal.png',
    'Credit Card',
    '0122 *******434',
    orderlist,
    21.0,
    2.0,
    23.0);

class OrderViewController extends GetxController {
  ApiController apiController = Get.put(ApiController());
  final homeController = Get.put(HomeController());
  final orderController = Get.put(OrderController());
  CreateOrder orderModel = CreateOrder();

  late CameraPosition camPosPickup;
  late GoogleMapController mapPickupController;
  late LatLng origin;
  late LatLng destination;
  late String googleMapApi;
  late GooglePlace googlePlace;
  late Set<Marker> markers;
  late Map<MarkerId, Marker> markersPickup;

  bool isLoading = true;
  bool isDeviceConnected = true;
  List<String> nameList = [];
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {}
  }

  onMapPickupCreated(GoogleMapController controller) async {
    mapPickupController = controller;
    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapPickupController.setMapStyle(mapStyle);
    });
  }

  addMapMarkerPickup() async {
    // await PermissionService.getLocationService();
    markers = {};
    markersPickup = {};
    origin = LatLng(25.4148, 68.3385);
    destination = LatLng(25.4245, 68.3427);
    googleMapApi = "AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps";
    googlePlace = GooglePlace(googleMapApi);

    markers.add(getMarker('1'));
    camPosPickup = CameraPosition(
      tilt: 10,
      target: LatLng(double.parse(orderModel.deliveryAddress!.locationlat!),
          double.parse(orderModel.deliveryAddress!.locationlong!)),
      zoom: 14,
    );

    update();
  }

  Marker getMarker(String markerID) {
    MarkerId id = MarkerId(markerID);
    Marker customMarker = Marker(
      draggable: false,
      markerId: id,
      //icon: BitmapDescriptor.defaultMarker,
      position: LatLng(double.parse(orderModel.deliveryAddress!.locationlat!),
          double.parse(orderModel.deliveryAddress!.locationlong!)),
      anchor: ui.Offset(0.5, 0.9),
      infoWindow: InfoWindow(title: markerID, snippet: "this is restaurent"),
    );
    return customMarker;
  }

  void btnOrderAgain_OnClick(BuildContext context, String order_id) {
    print("Order Again pressed ");

    // dialog to conform the order again here
    print(apiController.authToken);
    Get.defaultDialog(
      title: 'Add products to cart ?',
      middleText: 'Press cancel Or continue',
      backgroundColor: Colors.white,
      radius: 3.h,
      textCancel: 'Cancel',
      cancelTextColor: Colors.black,
      textConfirm: 'Continue',
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        orderAgainPressed(context, order_id);
      },
      buttonColor: kPrimaryColor,
    );
  }

  void orderAgainPressed(BuildContext context, String orderID) {
    for (var element in orderModel.receipt!.entries!) {
      orderController.addOrder(element);
    }
    orderController.update();
    Navigator.of(context).pop();
    Get.toNamed(route.homePage);
  }

  void viewOrder(String orderID) async {
    isLoading = true;

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

              orderModel = CreateOrder.fromJson(parsedData);
              orderModel.deliveryAddress!.locationlat == ""
                  ? orderModel.deliveryAddress!.locationlat =
                      homeController.userCurrentLoc.latitude.toString()
                  : orderModel.deliveryAddress!.locationlat;
              orderModel.deliveryAddress!.locationlong == ""
                  ? orderModel.deliveryAddress!.locationlong =
                      homeController.userCurrentLoc.longitude.toString()
                  : orderModel.deliveryAddress!.locationlong;
              update();
              addMapMarkerPickup();
              isLoading = false;
            } else {
              print('Api not responding in get order by id in history');
            }
          });
        } catch (exception) {
          print('exception while retrieving the order from order again ');
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

  String getTip() {
    String tip = '0';

    if (orderModel.receipt!.tip != null) {
      if (orderModel.receipt!.tip != "0.00") {
        tip = orderModel.receipt!.tip!;
      }
    }
    return tip;
  }

  int getIngrLength(Entry entry) {
    nameList = [];
    for (var element in entry.ingredients!) {
      List<int> list = [];
      list = getIngIncludedItems(element.id!, entry);
      for (var elementSub in list) {
        nameList.add(getIngName(elementSub.toString(), element.items!));
      }
    }
    return nameList.length;
  }

  List<String> getIngrNames(Entry entry) {
    nameList = [];
    for (var element in entry.ingredients!) {
      List<int> list = [];
      list = getIngIncludedItems(element.id!, entry);
      for (var elementSub in list) {
        nameList.add(getIngName(elementSub.toString(), element.items!));
      }
    }
    return nameList;
  }

  List<int> getIngIncludedItems(String ingID, Entry entry) {
    return entry.ingredients!
        .firstWhere((element) => element.id == ingID)
        .includedItems!;
  }

  String getIngName(String id, List<IngredientItem> items) {
    String name = '';

    name = items.firstWhere((element) => element.id == id).name!;
    return name;
  }
}
