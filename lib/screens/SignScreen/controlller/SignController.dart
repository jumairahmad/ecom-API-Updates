// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Address/Model/AddressModel.dart';

import 'package:e_commerce/screens/Coupons/controller/couponController.dart';
import 'package:e_commerce/screens/LoyaltyHistory/controller/LoyaltyHistorycontroller.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Rewards/controller/RewardController.dart';
import 'package:e_commerce/screens/SignScreen/models/OtpModel.dart';
import 'package:e_commerce/screens/SignScreen/models/UserModel.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../Address/Controller/AddressController.dart';
import '../../Home/controller/HomeController.dart';

class SignInController extends GetxController {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final apiController = Get.put(ApiController());
  final btnController = RoundedLoadingButtonController();
  final rewardController = Get.put(RewardController());
  final loyaltyHistoryController = Get.put(LoyaltyHistoryController());
  final couponController = Get.put(CouponController());
  final orderController = Get.put(OrderController());

  //final orderController = Get.put(OrderController());
  final widgetController = Get.put(WidgetController());
  FlipCardController flipCardController = FlipCardController();
  bool obscureText = true;
  bool logged = false;
  User user = User();
  FToast fToast = FToast();
  List<AddressModel>? addressList = [];

  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void doStuff() {
    // Flip the card a bit and back to indicate that it can be flipped (for example on page load)
    flipCardController.hint(
      duration: Duration(seconds: 3),
      total: Duration(seconds: 3),
    );

    // Tilt the card a bit (for example when hovering)
    flipCardController.hint(
      duration: Duration(seconds: 3),
      total: Duration(seconds: 3),
    );

    // Flip the card programmatically
    flipCardController.toggleCard();
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      // getRewardDetails();
    }
  }

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  void userLogin() async {
    apiController.checkConnectivity().then((value) {
      if (value) {
        apiController.UserPhoneNo = userNameController.text;
        apiController.update();
        apiController.apiCall('Account/Authenticate', {
          "PhoneNo": userNameController.text,
          "Password": passwordController.text
        }).then((value) {
          updateUser(value);
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

  Future<bool> userLogin_saved(String phone, String pass) async {
    bool hasDetails = false;
    apiController.UserPhoneNo = pass;
    apiController.UserPhoneNo = phone;
    apiController.update();
    await apiController.apiCall('Account/Authenticate',
        {"PhoneNo": phone, "Password": pass}).then((value) {
      final apiResponse = api_model.Response.fromJson(jsonDecode(value));
      if (apiResponse.success == "true") {
        final homeController = Get.put(HomeController());
        logged = true;
        user = User.fromJson(apiResponse.successcode!);
        if (user.firstName == "" || user.lastName == "") {
          hasDetails = false;
        } else {
          hasDetails = true;
          apiController.UserPhoneNo = phone;
          apiController.authToken = user.token!;
          apiController.userId = user.userID!;
          apiController.update();
          rewardController.getRewardDetails();
          rewardController.update();
          loyaltyHistoryController.getRewardDetails();
          loyaltyHistoryController.update();
          couponController.getData();
          couponController.update();
          orderController.update();
          homeController.authBrand();
          homeController.isDeviceConnected = true;
          homeController.update();
          getAddressList(true);
          update();
        }
      } else {
        hasDetails = false;
      }
    });

    return hasDetails;
  }

  void getAddressList(bool isConnected) {
    if (isConnected) {
      try {
        PermissionService.getLocationService();
        apiController.apiCall('CustomerAddresses/GetList').then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));

          if (apiResponse.success == 'true') {
            String catData = jsonEncode(apiResponse.successcode).toString();

            List parsedCat = json.decode(catData);
            final addressListController = Get.put(AddressListController());
            addressListController.getAddressList(true);
            addressListController.update();
            addressList =
                parsedCat.map((item) => AddressModel.fromJson(item)).toList();
            widgetController.address = addressList!.first.address!;
            widgetController.update();
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

  void updateUser(dynamic result) {
    final apiResponse = api_model.Response.fromJson(jsonDecode(result));
    if (apiResponse.success == "true") {
      logged = true;
      user = User.fromJson(apiResponse.successcode!);
      apiController.UserPhoneNo = userNameController.text;
      apiController.authToken = user.token!;
      apiController.userId = user.userID!;
      print(user.token!);
      apiController.update();
      rewardController.getRewardDetails();
      rewardController.update();
      loyaltyHistoryController.getRewardDetails();
      loyaltyHistoryController.update();
      couponController.getData();
      couponController.update();
      orderController.update();
      getAddressList(true);
      final box = GetStorage();
      box.write('logged', true);
      box.write('phone', userNameController.text);
      box.write('pass', passwordController.text);
      update();
      Get.offAllNamed(route.homePage);
    } else {
      snackBar('Error', apiResponse.failreason!);
      //btnController.error();
    }
  }
}

class SignUpController extends GetxController {
  bool signup_formValidation = false;
  FToast fToast = FToast();
  final txtPhoneController = TextEditingController();
  final txtPasswordController = TextEditingController();
  final txtNameController = TextEditingController();
  final txtFNameController = TextEditingController();
  final txtLNameController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtAddressController = TextEditingController();
  final txtZipController = TextEditingController();
  final txtState = TextEditingController();
  final txtCity = TextEditingController();
  final otpController = Get.put(OtpController());
  final apiController = Get.put(ApiController());
  final btnController = RoundedLoadingButtonController();
  OTPModel otpModel = OTPModel();
  bool obscureText = true;
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {}
  }

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  void btnSignUp_onClick() {
    apiController.checkConnectivity().then((value) {
      if (value) {
        apiController.apiCall('Account/SignUp', {
          "userPhone": txtPhoneController.text.trim(),
          "userEmail": txtEmailController.text.trim(),
          "firstName": txtFNameController.text.trim(),
          "lastName": txtLNameController.text.trim(),
          "address": txtAddressController.text,
          "state": txtState.text,
          "city": txtCity.text,
          "zipCode": txtZipController.text,
          "password": txtPasswordController.text
        }).then((value) {
          createUser(value);
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

  void createUser(dynamic result) {
    final apiResponse = api_model.Response.fromJson(jsonDecode(result));
    if (apiResponse.success == "true") {
      // if user is successfully created then this will go to optp

      apiController.checkConnectivity().then((value) async {
        if (value) {
          apiController.UserPhoneNo = txtPhoneController.text;
          apiController.update();
          await apiController.apiCall('OTP/CreateByPhone').then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));
            if (apiResponse.success == "true") {
              snackBar('Success', 'User Created');
              otpModel = OTPModel.fromJson(apiResponse.successcode!);

              update();
              otpController.otpModel = otpModel;
              otpController.codeEnabled = true;
              otpController.updateTimer(otpModel.activeUntil!);

              otpController.signupcase = true;
              otpController.update;

              Get.toNamed(route.otpPage);
            } else {
              snackBar('Error', apiResponse.failreason!);
            }
          });
        } else {
          isDeviceConnected = false;
          update();
        }
      }).catchError((val) {
        isDeviceConnected = false;
        update();
      });

      // Navigator.pushNamedAndRemoveUntil(context, route.homePage, (r) => false);
    } else {
      snackBar('Error', apiResponse.failreason!);
    }
  }
}

class ForgotPasswordController extends GetxController {
  final txtForgotPassController = TextEditingController();
  final btnController = RoundedLoadingButtonController();
  final apiController = Get.put(ApiController());
  final otpController = Get.put(OtpController());
  final confirmPasswordController = Get.put(ConfirmPasswordController());
  OTPModel otpModel = OTPModel();
  FToast fToast = FToast();
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {}
  }

  void btnSubmit() async {
    apiController.checkConnectivity().then((value) async {
      if (value) {
        apiController.UserPhoneNo = txtForgotPassController.text;
        apiController.update();
        await apiController.apiCall('OTP/CreateByPhone').then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));
          if (apiResponse.success == "true") {
            otpModel = OTPModel.fromJson(apiResponse.successcode!);

            update();
            otpController.otpModel = otpModel;
            otpController.codeEnabled = true;
            otpController.updateTimer(otpModel.activeUntil!);

            confirmPasswordController.updateTimer(otpModel.activeUntil!);
            confirmPasswordController.otpModel = otpModel;
            confirmPasswordController.codeEnabled = true;

            confirmPasswordController.update();
            otpController.signupcase = false;
            otpController.update;

            Get.toNamed(route.otpPage);
          } else {
            snackBar('Error', apiResponse.failreason!);
            //btnController.error();
          }
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

class OtpController extends GetxController {
  final apiController = Get.put(ApiController());

  OTPModel otpModel = OTPModel();
  TextEditingController txtFirst = TextEditingController();
  TextEditingController txtSecond = TextEditingController();
  TextEditingController txtThird = TextEditingController();
  TextEditingController txtFourth = TextEditingController();
  CountdownTimerController countdownController =
      CountdownTimerController(endTime: 0);
  bool codeEnabled = true;
  bool signupcase = false;
  FToast fToast = FToast();
  final btnController = RoundedLoadingButtonController();

  void updateTimer(int time) {
    txtFirst.text = '';
    txtSecond.text = '';
    txtThird.text = '';
    txtFourth.text = '';
    countdownController = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 1000 * time * 60,
        onEnd: () {
          codeEnabled = false;

          update();
        });
    update();
  }

  void btnVerify_onClick() async {
    if (txtFirst.text == '' ||
        txtFirst.text.isEmpty ||
        txtSecond.text == '' ||
        txtSecond.text.isEmpty ||
        txtThird.text == '' ||
        txtThird.text.isEmpty ||
        txtFourth.text == '' ||
        txtFourth.text.isEmpty) {
      update();
      await Future.delayed(Duration(milliseconds: 250)).then((value) {
        update();
      });
    } else {
      String otpCode =
          txtFirst.text + txtSecond.text + txtThird.text + txtFourth.text;

      verifyOTP(otpCode);
    }
  }

  void verifyOTP(String otp) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (otp == otpModel.otp) {
      if (signupcase == false) {
        Get.toNamed(route.changePasswordPage);
      } else if (signupcase == true) {
        await apiController
            .apiCall('OTP/VerifyByPhone', {"OTP": otp}).then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));

          if (apiResponse.success == "true") {
            Get.toNamed(route.loginPage);
          } else {
            snackBar('Error', apiResponse.failreason!);
          }
        });
      }
    } else {
      snackBar('Error', 'Invalid OTP');
    }
  }
}

class ConfirmPasswordController extends GetxController {
  final txtPassController = TextEditingController();
  final txtConfirmPassController = TextEditingController();
  bool obscureText = true;
  bool obscureTextConfirm = true;

  final apiController = Get.put(ApiController());
  // final forgotPasswordController = Get.put(ForgotPasswordController());

  OTPModel otpModel = OTPModel();

  CountdownTimerController countdownController =
      CountdownTimerController(endTime: 0);
  bool codeEnabled = true;
  FToast fToast = FToast();
  final btnController = RoundedLoadingButtonController();

  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {}
  }

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  void toggleConfirm() {
    obscureTextConfirm = !obscureTextConfirm;
    update();
  }

  void updateTimer(int time) {
    countdownController = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 1000 * time * 60,
        onEnd: () {
          codeEnabled = false;

          update();
        });
    update();
  }

  void btnUpdate_onClick() async {
    if (txtPassController.text != txtConfirmPassController.text) {
      update();
      await Future.delayed(Duration(milliseconds: 250)).then((value) {
        snackBar('Error', 'Passwords do not match');
        update();
      });
    } else {
      updatePassword();
    }
  }

  void updatePassword() async {
    apiController.checkConnectivity().then((value) async {
      if (value) {
        FocusManager.instance.primaryFocus?.unfocus();
        await apiController.apiCall('Account/ChangePassword', {
          "otpCode": otpModel.otp,
          "newPassword": txtPassController.text
        }).then((value) {
          final apiResponse = api_model.Response.fromJson(jsonDecode(value));
          if (apiResponse.success == "true") {
            Get.toNamed(route.loginPage);
          } else {
            snackBar('Error', apiResponse.failreason!);
          }
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
