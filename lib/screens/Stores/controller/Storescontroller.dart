//import 'dart:async';
import 'dart:collection';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreController extends GetxController {
  GoogleMapController? controllerMap;
  final apiController = Get.put(ApiController());
  List<Locations>? brandLocation;
  BitmapDescriptor? customIcon;

  late CameraPosition? initialPosition;
  Set<Circle> circlePointsOfStores = HashSet<Circle>();

  final Set<Marker>? markerList = HashSet<Marker>();
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      setBrandLocations();
    }
  }

  @override
  void onInit() {
    PermissionService.getLocationService();
    apiController.checkConnectivity().then((value) {
      if (value) {
        setBrandLocations();
        update();
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });

    super.onInit();
  }

  void setBrandLocations() {
    PermissionService.getLocationService();
    apiController.checkConnectivity().then((value) {
      if (value) {
        brandLocation = apiController.brandAuth.locations!;

        LatLng point = LatLng(
            double.parse(brandLocation!.first.locationaddress!.locationlat!),
            double.parse(brandLocation!.first.locationaddress!.locationlong!));
        initialPosition = CameraPosition(
          target: point,
          zoom: 14,
        );

        for (var e in brandLocation!) {
          LatLng point = LatLng(double.parse(e.locationaddress!.locationlat!),
              double.parse(e.locationaddress!.locationlong!));

          markerList!.add(Marker(
            markerId: MarkerId('markerId_${e.locationid}'),
            icon: BitmapDescriptor.defaultMarker,
            position: point,
            infoWindow: InfoWindow(title: e.locationname),
          ));
          circlePointsOfStores.add(
            Circle(
              circleId: CircleId("circle_${e.locationid}"),
              center: point,
              radius: 45.0,
              fillColor: kPrimaryColor,
              strokeColor: kPrimaryColor,
              strokeWidth: 5,
            ),
          );
        }
        update();
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });

    //getStoresAddressesToCreateCircles();
  }

  onSetMap(GoogleMapController controller) async {
    // if (!controllerMap.isCompleted) {
    //   controllerMap.complete(controller);
    // }
  }
  onMapCreated(GoogleMapController controller) {
    controllerMap = controller;
  }

  void moveCameraToStoreLocation(double latti, double longt) {
    controllerMap!
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(latti, longt), 14));
    update();
  }
}
