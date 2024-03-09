// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/screens/SignScreen/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiController extends GetxController {
  ApiHeaders apiHeaders = ApiHeaders();
  BrandAuth brandAuth = BrandAuth();

  String brandid = "1";
  String apptoken = "A02X0129Z1002020X4";
  String LocationID = '1';
  String userId = '';
  String UserPhoneNo = '';
  String UserName = '';
  String authToken = '';
  bool isDeviceConnected = false;
  Map<String, String> headers = {};
  User user = User();
  BuildContext? pageBuildContext;

  @override
  void onInit() {
    authBrand();
    super.onInit();
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        //.timeout(Duration(seconds: 15), onTimeout: onTimeOut());
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print(' active internet connection');
          isDeviceConnected = true;
        }
      } on SocketException catch (_) {
        print('no active internet connection');
        isDeviceConnected = false;
      }
    } else {
      print('not connected');
      isDeviceConnected = false;
    }
    return isDeviceConnected;
  }

  void authBrand() async {
    checkConnectivity().then((value) async {
      isDeviceConnected = value;
      if (value) {
        await apiCall('Stores/GetListByID').then((value) {
          updateAuthDataObject(value);
        });
      }
    });
  }

  void updateAuthDataObject(result) {
    final apiResponse = api_model.Response.fromJson(jsonDecode(result));
    if (apiResponse.success == "true") {
      brandAuth = BrandAuth.fromJson(apiResponse.successcode!);
      LocationID = brandAuth.locations!.first.locationid.toString();
      UserName = "guest";

      update();
    } else {
      print('Api Error : ' + apiResponse.failreason!);
    }
  }

  Map<String, String> getHeader() {
    headers = {
      'Content-Type': 'application/json',
      'AppToken': apptoken,
      'BrandId': brandid,
      'Locationid': LocationID,
      'UserPhoneNo': UserPhoneNo,
      'Authorization': 'Bearer $authToken',
    };

    print('here in Headers $UserPhoneNo');
    return headers;
  }

  Future<dynamic> apiCall(String url, [var body]) async {
    var client = http.Client();
    if (body != null) {
      try {
        //log("body in api controller $body");
        var uriResponse = await client.post(
            Uri.parse('https://cronyapi.azurewebsites.net/api/Customer/' + url),
            headers: getHeader(),
            body: jsonEncode(body));

        //print(uriResponse.body);
        log(" in Api Body Call ${jsonEncode(body)}");
        return uriResponse.body;
      } catch (e) {
        print("Api Error $e");
        return e;
      }
    } else {
      try {
        var uriResponse = await client.get(
          Uri.parse('https://cronyapi.azurewebsites.net/api/Customer/' + url),
          headers: getHeader(),
        );

        // print(uriResponse.body);
        return uriResponse.body;
      } catch (e) {
        print("Api Error $e");
        return e;
      }
    }
  }
}
