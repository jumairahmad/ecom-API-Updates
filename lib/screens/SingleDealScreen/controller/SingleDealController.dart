// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, library_prefixes

import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as ApiModel;
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Home/models/DealsModel.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:sizer/sizer.dart';

class SingleDealController extends GetxController {
  final apiController = Get.put(ApiController());
  final widgetController = Get.put(WidgetController());
  final orderController = Get.put(OrderController());
  DealsModel dealsModel = DealsModel();
  List<ItemModel> itemList = [];
  bool isItemsLoaded = false;
  ItemsResult itemsResult = ItemsResult();
  bool isDealConditionTrue = false;
  bool isEditTrue = false;
  String dealidcheck = '';
  String entryID = '';
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      update();
      getDealDetails(dealidcheck);
    }
  }

  void getDealDetails(String dealid) async {
    dealidcheck = dealid;
    update();

    apiController.checkConnectivity().then((value) async {
      if (value) {
        isDealConditionTrue = false;
        isEditTrue = false;
        entryID = '';
        itemList = [];
        await apiController
            .apiCall('Deals/GetByID', {"ID": dealid}).then((value) {
          updateItemsList(value);
        });
      } else {
        isDeviceConnected = false;
        isItemsLoaded = true;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      isItemsLoaded = true;
      update();
    });
  }

  void editGetDealDetails(String dealid, List<ItemModel> list) async {
    isDealConditionTrue = false;
    itemList = [];
    await apiController.apiCall('Deals/GetByID', {"ID": dealid}).then((value) {
      updateItemsList(value);
    });
    for (var element in list) {
      replaceItem(element.id!, element);
    }
    update();
  }

  void replaceItem(String id, ItemModel model) {
    itemList.firstWhere((element) => element.id == id).quantity =
        model.quantity!;
    isDealConditionTrue = true;
    update();
  }

  void updateItemsList(dynamic result) {
    final apiResponse = ApiModel.Response.fromJson(jsonDecode(result));

    String productData = jsonEncode(apiResponse.successcode).toString();
    itemsResult = ItemsResult.fromJson(jsonDecode(productData));
    print('data loaded');
    itemList = [];
    itemList.addAll(itemsResult.items!);
    if (itemList.length <= 1 && itemList.isNotEmpty) {
      itemList.first.quantity = dealsModel.dealrules!.first.qty!;
    }
    for (var element in itemList) {
      element.quantity = "0";
    }
    isItemsLoaded = true;

    update();
  }

  void btnIncreaseProduct(ItemModel item) {
    if (getItemsQtyInDeal() >= dealRuleQty()) {
      snackBar(
        'DEAL RULES',
        'You can add only ' + dealRuleQty().toStringAsFixed(0) + " items",
      );
    }
    if (getItemsQtyInDeal() < dealRuleQty()) {
      int qty = int.parse(
          itemList.firstWhere((element) => element.id == item.id).quantity!);

      itemList.firstWhere((element) => element.id == item.id).quantity =
          (qty + 1).toString();
    }

    if (getItemsQtyInDeal() == dealRuleQty()) {
      isDealConditionTrue = true;
    }
    update();
  }

  int getItemsQtyInDeal() {
    int dealItemsQty = 0;
    for (var element in itemList) {
      dealItemsQty += int.parse(element.quantity!);
    }
    return dealItemsQty;
  }

  int dealRuleQty() {
    int dealRuleQty = 0;
    dealRuleQty = int.parse(dealsModel.dealrules!.first.qty!);
    return dealRuleQty;
  }

  void btnDecreaseProduct(ItemModel item, BuildContext context) {
    if (int.parse(item.quantity!) > 0) {
      int qty = int.parse(
          itemList.where((element) => element.id == item.id).first.quantity!);
      itemList.where((element) => element.id == item.id).first.quantity =
          (qty - 1).toString();
    }

    if (getItemsQtyInDeal() < dealRuleQty()) {
      if (isDealConditionTrue) {}
      isDealConditionTrue = false;
    }
    update();
  }

  void btnAddToCart_onClick(BuildContext context) {
    int dealRuleQty = int.parse(dealsModel.dealrules!.first.qty!);

    if (isDealConditionTrue && isEditTrue == false) {
      Entry entry = Entry();
      var orderDeal = OrderDeal();

      var json = jsonEncode(itemList
          .where((element) => int.parse(element.quantity!) > 0)
          .map((e) => e.toJson())
          .toList());

      List<dynamic> parsedListJson = jsonDecode(json);
      List<ItemModel> newList = List<ItemModel>.from(
          parsedListJson.map((i) => ItemModel.fromJson(i)));

      orderDeal.deal = dealsModel;

      orderDeal.itemList = newList;

      entry.deal = orderDeal;
      entry.ingredients = [];
      entry.entryId = dealsModel.dealid;
      entry.qty = "1";
      entry.name = dealsModel.dealname;
      entry.linetotal = getPriceAfterDiscount();
      entry.special = "false";
      entry.regularprice = "0";
      entry.finalprice = getPriceAfterDiscount();
      entry.itemEntryDate = DateTime.now().toString();

      orderController.addOrder(entry);

      Get.snackbar('Deal Added', '',
          messageText: Text(
            'View Cart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          colorText: kTxtColor,
          backgroundColor: kTxtLightColor.withOpacity(0.5),
          boxShadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          icon: Icon(
            Icons.info_outline,
            size: 100.w < 500 ? 6.w : 3.5.w,
          ), onTap: (obj) {
        Get.toNamed(route.orderPage);
      });
    } else if (isEditTrue && isDealConditionTrue) {
      var json = jsonEncode(itemList
          .where((element) => int.parse(element.quantity!) > 0)
          .map((e) => e.toJson())
          .toList());

      List<dynamic> parsedListJson = jsonDecode(json);
      List<ItemModel> newList = List<ItemModel>.from(
          parsedListJson.map((i) => ItemModel.fromJson(i)));
      orderController.updateDeal(entryID, newList);

      update();
      Get.snackbar('Deal Updated', '',
          messageText: Text(
            'View Cart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          colorText: kTxtColor,
          backgroundColor: kTxtLightColor.withOpacity(0.5),
          boxShadows: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          icon: Icon(
            Icons.info_outline,
            size: 100.w < 500 ? 6.w : 3.5.w,
          ), onTap: (obj) {
        entryID = '';
        isEditTrue = false;

        Get.toNamed(route.orderPage);
      });
    } else {
      snackBar(
        'DEAL RULES',
        'Please add any ' + dealRuleQty.toStringAsFixed(0) + " items",
      );
    }
  }

  String getPriceAfterDiscount() {
    double price = 0.0;
    if (dealsModel.discounttype == "price") {
      price = double.parse(dealsModel.dealrules!.first.qty!) *
          double.parse(dealsModel.dealrules!.first.priceeach!);
    } else {
      print('This is The case for deals Price');
      for (var element in itemList) {
        if (element.quantity != '0') {
          price += double.parse(element.regularprice!) -
              ((double.parse(dealsModel.dealrules!.first.priceeach!) / 100) *
                  double.parse(element.regularprice!));
          print(price);
        }
        // double pr = double.parse(element.regularprice!) /
        //     double.parse(dealsModel.dealrules!.first.priceeach!);
        // price = (price + (double.parse(element.regularprice!) - pr)) *
        //     double.parse(dealsModel.dealrules!.first.qty!);
        // print(price);
      }
    }
    print("returning price here");

    return price.toStringAsFixed(2);
  }
}
