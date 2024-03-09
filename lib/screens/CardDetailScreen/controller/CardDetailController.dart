// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/PaymentModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CardDetailController extends GetxController {
  OrderController orderController = Get.put(OrderController());
  ApiController apiController = Get.put(ApiController());
  bool isSaved = false;
  late PaymentModel paymentModel;
  final roundedButtonController = RoundedLoadingButtonController();

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
    btnReload_onClick();
    super.onInit();
  }

  void SendPayment(BuildContext context, CreditCardModel? creaditCardDetails) {
    apiController.checkConnectivity().then((value) {
      print(value);
      if (value) {
        for (var element in orderController.paymentModel) {
          element.isDefault = "false";
        }
        orderController.update();

        paymentModel = PaymentModel();
        paymentModel.cardNumber = creaditCardDetails!.cardNumber;
        paymentModel.expiryDate = creaditCardDetails.expiryDate;
        paymentModel.cVV = creaditCardDetails.cvvCode;
        paymentModel.cardHolder = creaditCardDetails.cardHolderName;
        if (creaditCardDetails.cardNumber[0] == "4") {
          paymentModel.cardType = "Visa";
        }
        if (creaditCardDetails.cardNumber[0] == "5") {
          paymentModel.cardType = "Mastercard";
        } else {
          paymentModel.cardType = "Visa";
        }

        paymentModel.isDefault = isSaved ? "true" : "false";
        update();
        orderController.paymentModel.add(paymentModel);
        var jsonSendPaymentDetails = paymentModel.toJson();

        print('Json in Payment $jsonSendPaymentDetails');
        orderController.btnPlaceOrder_onClick(context);
      } else {
        // isDeviceConnected = value;
        // update();
      }
    }).catchError((val) {
      //isDeviceConnected = false;
      update();
    });
  }

  void saveCheckBoxClicked(bool check) {
    isSaved = check;
    update();
  }
}
