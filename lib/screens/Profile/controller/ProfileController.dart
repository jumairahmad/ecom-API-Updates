// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;

import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SignScreen/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class ProfileController extends GetxController {
  final txtPhoneController = TextEditingController();
  final txtPasswordController = TextEditingController();
  final txtNameController = TextEditingController();
  final txtFNameController = TextEditingController();
  final txtLNameController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtAddressController = TextEditingController();
  final txtZipController = TextEditingController();

  final userController = Get.put(SignInController());
  final apiController = Get.put(ApiController());
  final btnController = RoundedLoadingButtonController();
  User? user;
  bool obscureText = true;

  FToast fToast = FToast();
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getUser();
    }
  }

  @override
  void onInit() {
    apiController.checkConnectivity().then((value) {
      if (value) {
        getUser();
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

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  Future<void> getUser() async {
    await apiController.checkConnectivity().then((value) {
      if (value) {
        user = userController.user;
        //user.deliveryaddress?.stateName = 'Arizona';
        // user.deliveryaddress?.c ity = 'Alhambra';
        update();
        txtPhoneController.text = user!.userPhone!;
        txtNameController.text = user!.userfullName!;
        txtAddressController.text = user!.billingaddress!.address!;
        txtZipController.text = user!.deliveryaddress!.zip!;
        txtFNameController.text = user!.firstName!;
        txtLNameController.text = user!.lastName!;

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

  void btnLogout_onClick() async {
    apiController.apiCall('Account/logout').then((value) {
      final apiResponse = api_model.Response.fromJson(jsonDecode(value));
      if (apiResponse.success == "true") {
        userController.user = User();
        userController.logged = false;
        userController.update();
        apiController.UserPhoneNo = '';
        apiController.authToken = '';
        apiController.update();
        final box = GetStorage();
        box.remove('phone');
        box.remove('pass');
        box.remove('logged');
        Get.offAllNamed(route.homePage);
      } else {
        print(apiResponse.failreason);
        print('There was an error');
      }
    });
  }

  void btnSave_onClick(
    BuildContext context,
  ) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        apiController.apiCall('Account/UpdateProfile', {
          "userPhone": txtPhoneController.text,
          "userEmail": txtEmailController.text,
          "firstName": txtFNameController.text,
          "lastName": txtLNameController.text,
          "address": txtAddressController.text,
          "state": user!.billingaddress!.stateName,
          "city": user!.billingaddress!.city,
          "zipCode": txtZipController.text
        }).then((value) {
          //print(value);
          updateUser(context, value);
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

  void updateUser(BuildContext context, dynamic result) {
    final apiResponse = api_model.Response.fromJson(jsonDecode(result));
    if (apiResponse.success == "true") {
      // user = User.fromJson(apiResponse.successcode!);
      user!.userPhone = txtPhoneController.text;
      user!.userEmail = txtEmailController.text;
      user!.firstName = txtFNameController.text;
      user!.lastName = txtLNameController.text;
      user!.userfullName = "${user!.firstName} ${user!.lastName}";
      user!.billingaddress!.address = txtAddressController.text;
      user!.billingaddress!.zip = txtZipController.text;

      update();
      apiController.UserPhoneNo = txtPhoneController.text;
      //userController.update();
      apiController.update();
      showToastCancel(context, 'User updated');
      // Navigator.pushNamedAndRemoveUntil(context, route.homePage, (r) => false);
    } else {
      showToastCancel(context, apiResponse.failreason!);
      //btnController.error();
    }
  }

  showToastCancel(BuildContext context, String errorMsg) {
    fToast.init(context);

    update();
    Widget toastWithButton = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMsg,
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              wordSpacing: 2),
        ),
        // IconButton(
        //   icon: Icon(
        //     Icons.close,
        //   ),
        //   color: kPrimaryColor,
        //   onPressed: () {
        //     fToast.removeCustomToast();
        //   },
        // )
      ],
    );

    fToast.showToast(
      child: toastWithButton,
      gravity: ToastGravity.BOTTOM,
      fadeDuration: 700,
      toastDuration: Duration(milliseconds: 3200),
    );
  }
}
