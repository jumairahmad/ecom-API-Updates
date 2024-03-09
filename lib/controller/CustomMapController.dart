// ignore_for_file: prefer_collection_literals, non_constant_identifier_names

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SignScreen/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../constants.dart';

class CustomMapController extends GetxController {
  late Set<Marker> marker;
  late DetailsResult detailsResult;
  late GoogleMapController mapController;
  late GoogleMapController mapPickupController;
  late LatLng origin;
  late LatLng destination;
  late String googleMapApi;
  late GooglePlace googlePlace;
  late BitmapDescriptor originCustomMarker;
  late BitmapDescriptor destinationCustomMarker;
  late Map<MarkerId, Marker> markers;
  late Map<MarkerId, Marker> markersPickup;
  late Map<PolylineId, Polyline> polylines;
  late List<LatLng> polylineCoordinates;
  late PolylinePoints polylinePoints;
  late Uint8List markerIcon;
  late Uint8List markerDestinationIcon;
  late TabController tabController;

  late Set<Circle> circles;
  late CameraPosition camPos;
  late CameraPosition camPosPickup;

  final txtSearchController = TextEditingController();
  final txtCityController = TextEditingController();
  final txtHomeAddressController = TextEditingController();
  final txtPhoneController = TextEditingController();
  final txtZipController = TextEditingController();

  late Map<String, dynamic> data;
  List<Locations> stores = [];
  final homeController = Get.put(HomeController());
  final widgetController = Get.put(WidgetController());
  final apiController = Get.put(ApiController());
  late LatLng userCurrentLoc;
  User user = User();
  bool deliveryVisible = true;
  bool pickupVisible = false;
  bool curbSide = false;

  @override
  void onInit() {
    initDefaultValues();
    addMapCircle(origin, destination);
    addMapPolyLine();
    addMapMarker();
    addMapMarkerPickup();
    updateUserInfo();
    super.onInit();
  }

  void updateUserInfo() {
    final signInController = Get.put(SignInController());
    if (signInController.user.billingaddress != null) {
      txtCityController.text = signInController.user.billingaddress!.city!;
      txtHomeAddressController.text =
          signInController.user.billingaddress!.address!;
      txtPhoneController.text = signInController.user.userPhone!;
      txtZipController.text = signInController.user.billingaddress!.zip!;
    } else {
      txtCityController.text = '';
      txtHomeAddressController.text = '';
      txtPhoneController.text = '';
      txtZipController.text = '';
    }
    update();
  }

  onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    addMapStyle();
  }

  onMapPickupCreated(GoogleMapController controller) async {
    mapPickupController = controller;
    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapPickupController.setMapStyle(mapStyle);
    });
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        geodesic: true,
        width: 4,
        polylineId: id,
        color: kPrimaryColor,
        points: polylineCoordinates);

    polylines[id] = polyline;
  }

  getPolyline(String loc, String placeId) async {
    if (placeId.isNotEmpty) {
      var result1 = await googlePlace.details.get(placeId);

      if (result1 != null && result1.result != null) {
        detailsResult = result1.result!;
        destination = LatLng(detailsResult.geometry!.location!.lat!,
            detailsResult.geometry!.location!.lng!);
      }
    }
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApi,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: loc)]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      addPolyLine();
    }
    update();
  }

  initDefaultValues() {
    stores = apiController.brandAuth.locations!;

    txtSearchController.text = widgetController.address;
    marker = {};
    origin = LatLng(25.4148, 68.3385);
    destination = LatLng(25.4245, 68.3427);
    googleMapApi = "AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps";
    googlePlace = GooglePlace(googleMapApi);
    markers = {};
    markersPickup = {};
    polylines = {};
    polylineCoordinates = [];
    polylinePoints = PolylinePoints();

    camPos = CameraPosition(
      tilt: 60,
      target: LatLng((origin.latitude + destination.latitude) / 2,
          (origin.longitude + destination.longitude) / 2),
      zoom: 14,
    );
    camPosPickup = CameraPosition(
      tilt: 60,
      target: LatLng((origin.latitude + destination.latitude) / 2,
          (origin.longitude + destination.longitude) / 2),
      zoom: 14,
    );
    update();
  }

  addMapStyle() {
    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapController.setMapStyle(mapStyle);
    });
  }

  addMapMarkerPickup() {
    update();
    homeController.userCurrentLoc;

    for (var element in stores) {
      stores
              .where((item) => item.locationid == element.locationid)
              .first
              .distance =
          getDistance(
              homeController.userCurrentLoc,
              LatLng(double.parse(element.locationaddress!.locationlat!),
                  double.parse(element.locationaddress!.locationlong!)));

      marker.add(getMarker(element));
    }
    camPosPickup = CameraPosition(
      tilt: 10,
      target: LatLng(double.parse(stores[0].locationaddress!.locationlat!),
          double.parse(stores[0].locationaddress!.locationlong!)),
      zoom: 15,
    );

    update();
    stores.sort((a, b) {
      return a.distance!.compareTo(b.distance!);
    });
    update();
    stores
        .firstWhere((element) => element.locationname == "Crony Demo")
        .locationaddress!
        .address = "W Davis ,Montgomery, AL 36104, USA";

    stores
        .firstWhere((element) => element.locationfeatures!.pickup == "true")
        .selected = true;

    update();
  }

  Marker getMarker(Locations loc) {
    MarkerId id = MarkerId(loc.locationname!);
    Marker customMarker = Marker(
      markerId: id,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(double.parse(loc.locationaddress!.locationlat!),
          double.parse(loc.locationaddress!.locationlong!)),
      anchor: ui.Offset(0.5, 0.9),
      infoWindow:
          InfoWindow(title: loc.locationname!, snippet: "this is restaurent"),
    );
    return customMarker;
  }

  addMapCircle(LatLng origin, LatLng destination) {
    circles = Set.from([
      Circle(
          circleId: CircleId("Origin"),
          center: origin,
          radius: 100,
          fillColor: kTxtColor,
          strokeColor: kTxtColor.withOpacity(0.2),
          strokeWidth: 20),
      Circle(
          circleId: CircleId("Destination"),
          center: destination,
          radius: 100,
          fillColor: kPrimaryColor,
          strokeColor: kPrimaryColor.withOpacity(0.2),
          strokeWidth: 20)
    ]);
  }

  addMapMarker() async {
    markerDestinationIcon =
        await getBytesFromAsset('assets/icons/mapDestinationMarker.png', 150);
    markerIcon =
        await getBytesFromAsset('assets/icons/mapOriginMarker.png', 60);

    MarkerId originMarkerID = MarkerId("Origin");
    Marker originMarker = Marker(
      markerId: originMarkerID,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: origin,
      anchor: ui.Offset(0.5, 0.9),
      infoWindow: InfoWindow(title: "Origin", snippet: "this is restaurent"),
    );
    MarkerId destinationMarkerID = MarkerId("Destination");
    Marker destinationMarker = Marker(
      markerId: destinationMarkerID,
      icon: BitmapDescriptor.fromBytes(markerDestinationIcon),
      position: destination,
      anchor: ui.Offset(0.5, 0.5),
      infoWindow: InfoWindow(title: "Destinaion", snippet: "this is customer"),
    );
    markers[originMarkerID] = originMarker;
    markers[destinationMarkerID] = destinationMarker;

    update();
  }

  addMapPolyLine() {
    getPolyline("Wadhu Wah Gate, Qasimabad, Hyderabad", "");
  }

  updateMarker(MarkerId id, LatLng pos) {
    Marker marker =
        markers.values.toList().firstWhere((item) => item.markerId == id);
    Marker _marker = Marker(
      markerId: marker.markerId,
      position: pos,
      icon: marker.icon,
      anchor: marker.anchor,
      infoWindow: marker.infoWindow,
    );

    markers[id] = _marker;

    update();
  }

  updateCircle(CircleId id, LatLng pos) {
    Circle circle = circles.toList().firstWhere((item) => item.circleId == id);

    Circle newCircle = Circle(
        circleId: circle.circleId,
        center: pos,
        radius: 100,
        fillColor: circle.fillColor,
        strokeColor: circle.strokeColor,
        strokeWidth: circle.strokeWidth);

    circles.remove(circle);
    circles.add(newCircle);

    update();
  }

  updatePolyLine(loc) async {
    polylineCoordinates.clear();
    polylines.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApi,
        PointLatLng(origin.latitude, origin.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: loc)]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      addPolyLine();
    }
    update();
  }

  updateDestination(String placeId, String loc) async {
    var result1 = await googlePlace.details.get(placeId);

    if (result1 != null && result1.result != null) {
      detailsResult = result1.result!;

      destination = LatLng(detailsResult.geometry!.location!.lat!,
          detailsResult.geometry!.location!.lng!);
      update();

      updateMarker(MarkerId("Destination"), destination);
      updatePolyLine(loc);
      updateCircle(CircleId("Destination"), destination);
      updateMapView();
      updateTxtSearch(loc);
    }
  }

  updateMapView() {
    camPos = CameraPosition(
      tilt: 60,
      target: LatLng((origin.latitude + destination.latitude) / 2,
          (origin.longitude + destination.longitude) / 2),
      zoom: 14,
    );
    mapController.moveCamera(CameraUpdate.newCameraPosition(camPos));
    update();
  }

  updateTxtSearch(String val) {
    txtSearchController.text = val;
    widgetController.address = val;
    widgetController.update();
    update();
  }

  void btnDelivery_onPressed() {
    if (!deliveryVisible) {
      pickupVisible = false;
      deliveryVisible = true;
    }
    update();
  }

  void btnPickup_onPressed() {
    if (!pickupVisible) {
      pickupVisible = true;
      deliveryVisible = false;
    }
    update();
  }

  void btnSave_OnPressed(BuildContext context) {
    final signInController = Get.put(SignInController());
    final orderController = Get.put(OrderController());
    if (deliveryVisible) {
      widgetController.updateorderType("Delivery");
      widgetController.address = txtSearchController.text;
    }
    if (pickupVisible) {
      widgetController.updateorderType("Pickup");
      for (var element in stores) {
        if (element.selected == true) {
          widgetController.address = element.locationaddress!.address!;
        }
      }
      for (var element in stores) {
        if (element.locationfeatures!.curbSideEnabled == true) {
          widgetController.updateorderType("Pickup - Curbside");
          widgetController.address = element.locationaddress!.address!;
        }
      }
    }
    widgetController.update();
    orderController.update();
    String address = txtSearchController.text;
    // address = address.substring(0, address.indexOf(','));

    homeController.address = address;
    homeController.update();
    if (txtCityController.text != '') {
      txtCityController.text = signInController.user.billingaddress!.city!;
      txtHomeAddressController.text =
          signInController.user.billingaddress!.address!;
      txtPhoneController.text = signInController.user.userPhone!;
      txtZipController.text = signInController.user.billingaddress!.zip!;

      apiController.apiCall('Account/UpdateProfile', {
        "userPhone": txtPhoneController.text,
        "userEmail": signInController.user.userEmail,
        "firstName": signInController.user.userEmail,
        "lastName": signInController.user.userEmail,
        "address": txtHomeAddressController.text,
        "state": signInController.user.billingaddress!.stateName,
        "city": txtCityController.text,
        "zipCode": txtZipController.text
      }).then((value) {});
    }
    Navigator.pop(context);
  }

  void enableCurbSide(String id, bool isEnabled) {
    for (var element in stores) {
      element.locationfeatures!.curbSideEnabled = false;
    }

    stores
        .firstWhere(
            (element) => element.locationid == id && element.selected == true)
        .locationfeatures!
        .curbSideEnabled = isEnabled;
    update();
  }

  double getDistance(LatLng userLoc, LatLng storeLoc) {
    double distanceInMeters = Geolocator.distanceBetween(userLoc.latitude,
        userLoc.longitude, storeLoc.latitude, storeLoc.longitude);
    return distanceInMeters / 1609;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
