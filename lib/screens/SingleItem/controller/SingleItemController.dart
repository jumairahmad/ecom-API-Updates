// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'dart:convert';
import '../../../constants.dart';

class SingleItemController extends GetxController {
  ItemModel itemModel = ItemModel();
  FToast fToast = FToast();
  final widgetController = Get.put(WidgetController());
  final orderController = Get.put(OrderController());
  final apiController = Get.put(ApiController());
  late bool isSelected;
  List<IngredientModel> ingrList = [];
  List<CustomModel> csList = [];

  bool isEditTrue = false;
  String entryID = '';
  bool isDeviceConnected = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getData();
    }
  }

  @override
  void onInit() {
    apiController.checkConnectivity().then((value) {
      if (value) {
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

  void btnClose_onPressed(BuildContext context) {
    update();
    //Get.toNamed(route.homePage);
    Navigator.of(context).pop();
  }

  void btnBack_onPressed(BuildContext context) {
    update();
    Navigator.of(context).pop();
  }

  void btnAddToCart_OnClick(BuildContext context) {
    if (isEditTrue) {
      updateOrderEntry();
      showToastCancel(context);
    } else {
      double ingPrice = 0.0;
      for (var element in ingrList) {
        ingPrice += double.parse(getPricePerIng(element));
      }

      Entry entry = Entry();
      entry.item = itemModel;
      entry.entryId = itemModel.id;
      if (ingrList.isNotEmpty) {
        String ingdata = jsonEncode(ingrList).toString();

        List parsedIngList = jsonDecode(ingdata);
        List<IngredientModel> newList =
            parsedIngList.map((e) => IngredientModel.fromJson(e)).toList();

        entry.ingredients = newList;
        update();
      } else if (ingrList.isEmpty) {
        entry.ingredients = [];
      }
      entry.qty = itemModel.quantity;
      entry.name = itemModel.name;
      entry.linetotal = getItemPriceAsPerQuantity();
      entry.special = itemModel.onspecial;
      entry.regularprice = itemModel.regularprice;
      entry.finalprice = itemModel.onspecial == "true"
          ? (double.parse(itemModel.specialprice!) + ingPrice)
              .toStringAsFixed(2)
          : (double.parse(itemModel.regularprice!) + ingPrice)
              .toStringAsFixed(2);
      entry.itemEntryDate = DateTime.now().toString();
      orderController.addOrder(entry);
      orderController.update();
      showToastCancel(context);
    }
  }

  void updateOrderEntry() {
    double ingPrice = 0.0;
    for (var element in ingrList) {
      ingPrice += double.parse(getPricePerIng(element));
    }
    String finalPrice = itemModel.onspecial == "true"
        ? (double.parse(itemModel.specialprice!) + ingPrice).toStringAsFixed(2)
        : (double.parse(itemModel.regularprice!) + ingPrice).toStringAsFixed(2);
    orderController.updateEntryItem(
        entryID, itemModel, ingrList, getItemPriceAsPerQuantity(), finalPrice);
    isEditTrue = false;
    entryID = '';
    orderController.update();
    update();
  }

  void btnIncrease() {
    itemModel.quantity = (int.parse(itemModel.quantity!) + 1).toString();
    update();
  }

  void btnDecrease() {
    int quantity;
    quantity = int.parse(itemModel.quantity!);

    if (quantity > 1) {
      itemModel.quantity = (int.parse(itemModel.quantity!) - 1).toString();
    } else {
      print("This item is 0");
    }

    update();
  }

  String getItemPriceAsPerQuantity() {
    double ingPrice = 0.0;
    for (var element in ingrList) {
      ingPrice += double.parse(getPricePerIng(element));
    }
    String price;
    double myPrice;
    int quantity;
    if (itemModel.onspecial == "true") {
      myPrice = double.parse(itemModel.specialprice!) + ingPrice;
    } else {
      myPrice = double.parse(itemModel.regularprice!) + ingPrice;
    }

    quantity = int.parse(itemModel.quantity!);

    price = (myPrice * quantity).toStringAsFixed(2);

    return price;
  }

  showToastCancel(BuildContext context) {
    fToast.init(context);

    update();
    Widget toastWithButton = Container(
      height: 5.h,
      width: 70.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: kPrimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
              onPressed: () {
                fToast.removeCustomToast();
                //itemModel.quantity = "1";
                update();

                Get.toNamed(route.orderPage);
              },
              child: Text("View Cart",
                  style: Theme.of(context).textTheme.headlineLarge)),
          IconButton(
            iconSize: 100.w < 500 ? 4.w : 3.w,
            icon: Icon(
              Icons.close,
            ),
            color: Colors.white,
            onPressed: () {
              fToast.removeCustomToast();
            },
          )
        ],
      ),
    );

    fToast.showToast(
      child: toastWithButton,
      gravity: ToastGravity.TOP,
      fadeDuration: 700,
      toastDuration: Duration(milliseconds: 2000),
    );
  }

  void getData() {
    //read json file
    //final jsondata = await rootBundle.loadString('assets/ingredientsData.json');

    /// calling api if items have ingrediants to check for
    apiController.checkConnectivity().then((value) {
      if (value) {
        if (itemModel.isItemAddon == true) {
          try {
            apiController.apiCall('items/GetIngredientsByItem',
                {"itemID": itemModel.id}).then((value) {
              final apiResponse =
                  api_model.Response.fromJson(jsonDecode(value));
              if (apiResponse.success == 'true') {
                print(
                    'Api Is not Having a ingrediant list for this call $value');
                String ingdata = jsonEncode(apiResponse.successcode).toString();
                List parsedIngList = jsonDecode(ingdata);
                ingrList = parsedIngList
                    .map((e) => IngredientModel.fromJson(e))
                    .toList();
                itemModel.hasIngredients = "true";
                print("Head text here In The  ${ingrList[0].headText}");
                update();
              } else {
                itemModel.hasIngredients = "false";
                print(
                    'Api Is not Having a ingrediant list for this call $value');
                update();
              }
            });
          } catch (exception) {
            itemModel.hasIngredients = "false";
            print("exception from server while retriving Ingrediants List");
          }
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
  }

  void updateSelection(IngredientModel ing, IngredientItem item, bool val) {
    int maxSelection = int.parse(ingrList
        .firstWhere((element) => element.id == ing.id)
        .maxItemSelection!);
    int itemQty = ingrList
        .firstWhere((element) => element.id == ing.id)
        .includedItems!
        .length;
    bool isRequired =
        ingrList.firstWhere((element) => element.id == ing.id).isRequiredTrue ==
                "true"
            ? true
            : false;

    if (itemQty < maxSelection) {
      if (val) {
        ingrList
            .firstWhere((element) => element.id == ing.id)
            .includedItems!
            .add(int.parse(item.id!));
      }
    }
    if (val == false) {
      if (isRequired && itemQty <= 1) {
        snackBar(
          'Can not remove',
          'Minimum 1 ' +
              ingrList.firstWhere((element) => element.id == ing.id).headText! +
              ' type is required',
        );
      } else {
        ingrList
            .firstWhere((element) => element.id == ing.id)
            .includedItems!
            .remove(int.parse(item.id!));
      }
    }
    if (val && itemQty >= maxSelection && maxSelection != 1) {
      snackBar(
        'Alert',
        'Can not exceed max limit : ' + maxSelection.toString(),
      );
    }
    if (maxSelection == 1) {
      ingrList.firstWhere((element) => element.id == ing.id).includedItems = [];
      ingrList
          .where((element) => element == ing)
          .first
          .includedItems!
          .add(int.parse(item.id!));
    }
    update();
  }

  String getPricePerIng(IngredientModel ing) {
    csList = [];
    double itemsTotalPrice = 0.0;
    int maxCount = int.parse(ingrList
        .firstWhere((element) => element.id == ing.id)
        .maxIncludedCount!);
    int selectedCount = ingrList
        .firstWhere((element) => element.id == ing.id)
        .includedItems!
        .length;

    if (selectedCount > maxCount) {
      int endIndex = (selectedCount - maxCount);
      addItemsToCustomList(ing);
      for (var element in csList.sublist(0, endIndex)) {
        itemsTotalPrice += getIngredientItemPrice(ing, element.id!);
      }
    }

    return itemsTotalPrice.toStringAsFixed(2);
  }

  void addItemsToCustomList(IngredientModel ing) {
    for (var element in ingrList
        .firstWhere((element) => element.id == ing.id)
        .includedItems!) {
      CustomModel cs = CustomModel();
      cs.id = element.toString();
      cs.nameofingrediantitem = getNameIngredientItem(ing, element.toString());
      cs.price = getIngredientItemPrice(ing, element.toString());
      csList.add(cs);
    }
    csList.sort((a, b) => a.price!.compareTo(b.price!));
  }

  double getAllIngPrice() {
    double ingPrice = 0.0;
    for (var element in ingrList) {
      ingPrice += double.parse(getPricePerIng(element));
    }

    return ingPrice;
  }

  double getIngredientItemPrice(IngredientModel ing, String id) {
    double price = 0.0;

    price = double.parse(ingrList
        .firstWhere((element) => element.id == ing.id)
        .items!
        .firstWhere((e) => e.id == id)
        .price!);

    return price;
  }

  String getNameIngredientItem(IngredientModel ing, String id) {
    String name = '';

    name = (ingrList
        .firstWhere((element) => element.id == ing.id)
        .items!
        .firstWhere((e) => e.id == id)
        .name!);

    return name;
  }
}
