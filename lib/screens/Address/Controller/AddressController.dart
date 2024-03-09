// ignore_for_file: non_constant_identifier_names, deprecated_member_use, prefer_conditional_assignment

import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Address/Model/AddressModel.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

import '../SaveAddress.dart';

class AddressListController extends GetxController {
  ApiController apiController = Get.put(ApiController());
  List<AddressModel>? addressList = [];
  final newAddressController = Get.put(NewAddressController());
  final homeController = Get.put(HomeController());
  bool isLoading = true;
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getAddressList(val);
    }
  }

  @override
  void onInit() async {
    getAddressList(true);
    update();
    super.onInit();
  }

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    //if failed,use refreshFailed()
    isLoading = true;

    apiController.checkConnectivity().then((value) {
      getAddressList(value);
    });

    update();
  }

  void getAddressList(bool isConnected) {
    isLoading = true;

    PermissionService.getLocationService();

    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('CustomerAddresses/GetList').then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              String catData = jsonEncode(apiResponse.successcode).toString();

              List parsedCat = json.decode(catData);

              addressList =
                  parsedCat.map((item) => AddressModel.fromJson(item)).toList();

              isLoading = false;

              update();
            } else {
              print('No Order History Found');
            }
          });
        } catch (exception) {
          print('Exception in Order Histroy In Server');
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

  void btnEdit_onPressed(AddressModel addressModel) {
    if (addressModel.locationLat == "" || addressModel.locationLong == "") {
      newAddressController.initialPos = homeController.userCurrentLoc;
    } else {
      newAddressController.initialPos = LatLng(
          double.parse(addressModel.locationLat!),
          double.parse(addressModel.locationLong!));
    }

    newAddressController.addressModel = addressModel;
    newAddressController.txtSearchController.text = addressModel.address!;

    newAddressController.update();
  }

  void btnAddNew_onPressed() {
    newAddressController.initialPos = homeController.userCurrentLoc;
    newAddressController.addressModel = null;
    newAddressController.update();
  }

  void btnSetAsDefault_onPressed(bool isConnected, int ID) {
    final orderControll = Get.put(OrderController());
    final signInController = Get.put(SignInController());
    for (var element in addressList!) {
      element.isDefault = false;
    }
    addressList!.firstWhere((element) => element.id == ID).isDefault = true;
    signInController.addressList = addressList;
    signInController.update();
    if (isConnected) {
      try {
        apiController.apiCall(
            'CustomerAddresses/SetToDefault', {"ID": ID}).then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));

          if (apiResponse.success == 'true') {
          } else {
            snackBar('Error', apiResponse.failreason!);
          }
        });
      } catch (exception) {
        snackBar('Contact admin', 'Exception in Order Histroy In Server');
      }
    }
    update();
    orderControll.update();
  }
}

class NewAddressController extends GetxController {
  Set<Marker> markers = {};
  Map<MarkerId, Marker> markersPickup = {};

  late GoogleMapController mapController;

  late GooglePlace googlePlace;
  late CameraPosition camPos;

  final txtSearchController = TextEditingController();
  final homeController = Get.put(HomeController());
  final widgetController = Get.put(WidgetController());
  final saveAddressController = Get.put(SaveAddressController());
  AddressModel? addressModel = AddressModel();
  LatLng initialPos = LatLng(0, 0);
  List<GoogleAddress> googleAddressList = [];
  bool cameraMoved = false;
  List<dynamic> placeList = [];
  late DetailsResult detailsResult;
  @override
  void onInit() async {
    PermissionService.getLocationService();
    googlePlace = GooglePlace('AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps');
    camPos = CameraPosition(tilt: 10, target: initialPos, zoom: 13, bearing: 0);
    update();
    super.onInit();
  }

  void getSuggestion(String input) async {
    PermissionService.getLocationService();
    String googleMapApi = "AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps";
    String _host =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$_host?input=$input&key=$googleMapApi';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      placeList = json.decode(response.body)['predictions'];

      update();
    }
  }

  updateDestination(String placeId, String loc) async {
    PermissionService.getLocationService();
    var result1 = await googlePlace.details.get(placeId);

    if (result1 != null && result1.result != null) {
      print('object');
      detailsResult = result1.result!;

      initialPos = LatLng(detailsResult.geometry!.location!.lat!,
          detailsResult.geometry!.location!.lng!);

      update();
      log('loc: ' + loc);
      txtSearchController.text = loc;
      update();
      updateMapCamera_1();
    }
  }

  void btnConfirm_onPressed(BuildContext context) {
    Get.toNamed(route.saveAddressPage);
    saveAddressController.addressModel = AddressModel();
    if (addressModel != null) {
      saveAddressController.addressModel = addressModel!;
      saveAddressController.update();
      saveAddressController.addressModel.address = txtSearchController.text;
    }

    saveAddressController.udpateValues(txtSearchController.text);

    saveAddressController.addLabelValues();
    saveAddressController.update();
  }

  void btnSearch_onPressed(BuildContext context) {
    Get.toNamed(route.customGooglePlacesPage);
  }

  void btnMyLocation_onPressed() {
    PermissionService.getLocationService();
    camPos = CameraPosition(
      tilt: 10,
      target: homeController.userCurrentLoc,
      zoom: 15,
    );
    mapController.moveCamera(CameraUpdate.newCameraPosition(camPos));
    update();
  }

  updateMapCamera_1() {
    addMarker(initialPos);
    if (addressModel == null) {
      getAddressFromLatLng(initialPos.latitude, initialPos.longitude);
    }

    camPos = CameraPosition(
      tilt: 20,
      target: initialPos,
      zoom: 16,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(camPos));
    CameraUpdate.newCameraPosition(camPos);

    update();
  }

  updatePosition(CameraPosition position) async {
    if (addressModel == null) {
      {
        getAddressFromLatLng(
                position.target.latitude, position.target.longitude)
            .toString();
      }
    }
    if (addressModel != null && cameraMoved) {
      getAddressFromLatLng(position.target.latitude, position.target.longitude)
          .toString();
      update();
    }

    addMarker(LatLng(position.target.latitude, position.target.longitude));
    saveAddressController.initialPos =
        LatLng(position.target.latitude, position.target.longitude);
    saveAddressController.update();
  }

  void onCameraMoveStarted() {
    cameraMoved = true;
  }

  addMarker(LatLng pos) {
    Marker _marker = Marker(
      markerId: MarkerId('1'),
      position: pos,
      //icon: BitmapDescriptor.defaultMarker,
      anchor: ui.Offset(0.5, 0.9),
      infoWindow: InfoWindow(title: '1', snippet: "this is restaurent"),
    );
    markers = {};
    markers.add(_marker);

    update();
  }

  onMapPickupCreated(GoogleMapController controller) async {
    cameraMoved = false;
    mapController = controller;
    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapController.setMapStyle(mapStyle);
    });
    updateMapCamera_1();
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String googleMapApi = "AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu-ps";
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?latlng=$lat,$lng&key=$googleMapApi';
    String formattedAddress = '';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);

      formattedAddress = data["results"][0]["formatted_address"];

      String catData =
          jsonEncode(data["results"][0]["address_components"]).toString();

      List parsedCat = json.decode(catData);

      googleAddressList =
          parsedCat.map((item) => GoogleAddress.fromJson(item)).toList();

      update();

      txtSearchController.text = formattedAddress;
      saveAddressController.update();
    }
    return formattedAddress;
  }
}

class SaveAddressController extends GetxController {
  Set<Marker> markers = {};
  Map<MarkerId, Marker> markersPickup = {};

  late GoogleMapController mapControllerCustom;
  final apiController = Get.put(ApiController());

  late GooglePlace googlePlace;
  late CameraPosition camPos;
  TextEditingController txtAddressController = TextEditingController();

  TextEditingController txtPhoneNoController = TextEditingController();
  TextEditingController txtCityController = TextEditingController();
  TextEditingController txtStateController = TextEditingController();
  TextEditingController txtOtherController = TextEditingController();
  String address = '';
  LatLng initialPos = LatLng(0, 0);
  AddressModel addressModel = AddressModel();

  List<CustomLabelModel> labelList = [];
  bool infoTextVisible = false;
  bool istxtFieldVisible = false;
  String selectedLabel = '';
  List<AddressModel>? addressList = [];
  bool isEditable = false;

  @override
  void onInit() {
    PermissionService.getLocationService();
    googlePlace = GooglePlace("AIzaSyDYxVAdT5ZHoD60AXMjJil114wooszu");
    camPos = CameraPosition(tilt: 10, target: initialPos, zoom: 13, bearing: 0);
    update();

    getAddressList(true);

    super.onInit();
  }

  void addLabelValues() {
    infoTextVisible = false;
    istxtFieldVisible = false;
    labelList = [];
    CustomLabelModel defaultLabel =
        CustomLabelModel('Default', Icons.info_outline, false);
    CustomLabelModel homeLabel =
        CustomLabelModel('Home', Icons.home_outlined, false);
    CustomLabelModel workLabel =
        CustomLabelModel('Work', Icons.business_center_outlined, false);
    CustomLabelModel partnerLabel =
        CustomLabelModel('Partner', Icons.favorite_border_outlined, false);
    CustomLabelModel otherLabel =
        CustomLabelModel('Other', Icons.add_outlined, false);
    labelList.add(defaultLabel);
    labelList.add(homeLabel);
    labelList.add(workLabel);
    labelList.add(partnerLabel);
    labelList.add(otherLabel);

    update();
  }

  void btnEditAddress_onPressed() {
    isEditable = true;
    update();
  }

  bool checkIfAddressExist(String label) {
    bool eXist = false;
    for (var element in addressList!) {
      if (element.label == label) {
        eXist = true;
      }
    }
    return eXist;
  }

  void updateLabel(CustomLabelModel labelModel) {
    for (var element in labelList) {
      element.isSelected = false;
    }
    labelList
        .firstWhere((element) => element.label == labelModel.label)
        .isSelected = true;
    checkIfLabelExist(labelModel.label!);

    update();
  }

  void udpateValues(String add) {
    if (addressModel.address != null) {
      txtCityController.text = addressModel.city!;
      txtStateController.text = addressModel.state!;
      txtPhoneNoController.text = addressModel.contactNo!;
      address = addressModel.address!;
      txtAddressController.text = addressModel.address!;
    } else {
      address = add;
      txtAddressController.text = add;
      txtCityController.text = '';
      txtOtherController.text = '';
      txtPhoneNoController.text = '';
      txtStateController.text = '';
    }
  }

  updateMapCamera() {
    addMarker(initialPos);
    camPos = CameraPosition(
        tilt: 10, target: initialPos, zoom: 13, bearing: camPos.bearing + 90);
    mapControllerCustom.animateCamera(CameraUpdate.newCameraPosition(camPos));
    CameraUpdate.newCameraPosition(camPos);

    update();
  }

  addMarker(LatLng pos) {
    Marker _marker = Marker(
      markerId: MarkerId("1"),
      position: pos,
      //icon: BitmapDescriptor.defaultMarker,
      anchor: ui.Offset(0.5, 0.9),
      infoWindow: InfoWindow(title: '1', snippet: "this is restaurent"),
    );
    markers = {};
    markers.add(_marker);

    update();
  }

  onMapPickupCreated(GoogleMapController controller) async {
    mapControllerCustom = controller;

    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapControllerCustom.setMapStyle(mapStyle);
    });

    updateMapCamera();
  }

  void getAddressList(bool isConnected) {
    ApiController apiController = Get.put(ApiController());
    if (isConnected) {
      try {
        apiController.apiCall('CustomerAddresses/GetList').then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));

          if (apiResponse.success == 'true') {
            String catData = jsonEncode(apiResponse.successcode).toString();

            List parsedCat = json.decode(catData);

            addressList =
                parsedCat.map((item) => AddressModel.fromJson(item)).toList();

            update();
          } else {
            print('No Order History Found');
          }
        });
      } catch (exception) {
        print('Exception in Order Histroy In Server');
      }
    }

    update();
  }

  void checkIfLabelExist(String label) {
    istxtFieldVisible = false;
    infoTextVisible = false;
    if (addressList != null) {
      for (var element in addressList!) {
        if (element.label == label) {
          if (label == "Other") {
            istxtFieldVisible = true;
            infoTextVisible = false;
          } else {
            infoTextVisible = true;
            istxtFieldVisible = false;
          }
          selectedLabel = label;
        }
      }
    }
    update();
  }

  void saveAddress() {
    String label = '';
    bool isLabelSelected = false;
    for (var element in labelList) {
      if (element.isSelected == true) {
        isLabelSelected = true;
        label = element.label!;
      }
    }
    addressModel.locationLat = initialPos.latitude.toString();
    addressModel.locationLong = initialPos.longitude.toString();

    if (addressModel.address != null && isLabelSelected == false) {
      addressModel.address = txtAddressController.text;
      addressModel.city = txtCityController.text;
      addressModel.state = txtStateController.text;
      addressModel.contactNo = txtPhoneNoController.text;

      jsonEncode(addressModel.toJson());
      ApiController apiController = Get.put(ApiController());
      if (true) {
        try {
          apiController
              .apiCall('CustomerAddresses/Save', (addressModel.toJson()))
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              snackBar('Success', 'Address updated');

              getAddressList(true);
              update();
            } else {
              snackBar('Update failed', apiResponse.failreason!);
            }
          });
        } catch (exception) {
          snackBar('Update failed', 'Exception in Order Histroy In Server');
        }
      }

      update();
    }
    if (addressModel.address != null && isLabelSelected == true) {
      addressModel.address = txtAddressController.text;
      addressModel.city = txtCityController.text;
      addressModel.state = txtStateController.text;
      addressModel.contactNo = txtPhoneNoController.text;
      if (label == "Other") {
        addressModel.id =
            txtOtherController.text.isNotEmpty ? 0 : getAddressID(label);
        addressModel.label = txtOtherController.text.isNotEmpty
            ? txtOtherController.text
            : "Other";
      }
      if (label != "Other") {
        addressModel.id = getAddressID(label);
        addressModel.label = label;
      }

      addressModel.isDefault = getIsDefault(label);

      jsonEncode(addressModel.toJson());
      ApiController apiController = Get.put(ApiController());
      if (true) {
        try {
          apiController
              .apiCall('CustomerAddresses/Save', (addressModel.toJson()))
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              snackBar('Success', 'Address updated');

              getAddressList(true);
              update();
            } else {
              snackBar('Error', apiResponse.failreason!);
            }
          });
        } catch (exception) {
          snackBar('Update Failed', 'Contact admin');
        }
      }

      update();
    }
    if (addressModel.address == null && isLabelSelected == false) {
      addressModel.id = getAddressID('Default');
      addressModel.label = 'Default';
      addressModel.address = txtAddressController.text;
      addressModel.city = txtCityController.text;
      addressModel.state = txtStateController.text;
      addressModel.zip = '1234';
      addressModel.contactNo = txtPhoneNoController.text;
      addressModel.isDefault = false;
      addressModel.locationLat = initialPos.latitude.toString();
      addressModel.locationLong = initialPos.longitude.toString();
      //addressModel.id = getAddressID(label);

      addressModel.isDefault = false;
      jsonEncode(addressModel.toJsonCreate());
      ApiController apiController = Get.put(ApiController());
      if (true) {
        try {
          apiController
              .apiCall('CustomerAddresses/Save', (addressModel.toJson()))
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              snackBar('Success', 'Address created');

              getAddressList(true);
              update();
            } else {
              snackBar('Error', apiResponse.failreason!);
            }
          });
        } catch (exception) {
          snackBar('Address not created', 'Contact admin');

          print('Exception in Order Histroy In Server');
        }
      }
    }
    if (addressModel.address == null && isLabelSelected == true) {
      addressModel.address = txtAddressController.text;
      addressModel.city = txtCityController.text;
      addressModel.state = txtStateController.text;
      addressModel.contactNo = txtPhoneNoController.text;

      if (label == "Other") {
        addressModel.id =
            txtOtherController.text.isNotEmpty ? 0 : getAddressID(label);
        addressModel.label = txtOtherController.text.isNotEmpty
            ? txtOtherController.text
            : "Other";
      }
      if (label != "Other") {
        addressModel.id = getAddressID(label);
        addressModel.label = label;
      }

      addressModel.zip = getZip(label);
      addressModel.isDefault = getIsDefault(label);

      jsonEncode(addressModel.toJson());
      ApiController apiController = Get.put(ApiController());
      if (true) {
        try {
          apiController
              .apiCall('CustomerAddresses/Save', (addressModel.toJson()))
              .then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              snackBar('Success', 'Address updated');

              getAddressList(true);

              update();
            } else {
              snackBar('Update failed', apiResponse.failreason!);
            }
          });
        } catch (exception) {
          snackBar('Update failed', 'Contact admin');
        }
      }

      update();
    }
  }

  int getAddressID(String lbl) {
    int id = 0;
    if (lbl != '') {
      for (var element in addressList!) {
        if (element.label == lbl) {
          id = element.id!;
        }
      }
    }

    return id;
  }

  String getZip(String lbl) {
    String zip = '1234';
    if (lbl != '') {
      for (var element in addressList!) {
        if (element.label == lbl) {
          zip = element.zip!;
        }
      }
    }

    return zip;
  }

  bool getIsDefault(String lbl) {
    bool isDefault = false;
    if (lbl != '') {
      for (var element in addressList!) {
        if (element.isDefault == true) {
          isDefault = true;
        }
        if (element.isDefault == false) {
          isDefault = false;
        }
      }
    }

    return isDefault;
  }
}

class GoogleAddress {
  String? longName;
  String? shortName;
  List<String>? types;

  GoogleAddress({this.longName, this.shortName, this.types});

  GoogleAddress.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}
