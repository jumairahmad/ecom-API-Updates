// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/services/NotifcationService.dart';

import 'package:e_commerce/controller/CustomMapController.dart';
import 'package:e_commerce/controller/WidgetController.dart';

import 'package:e_commerce/screens/Coupons/model/CouponModel.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/Order/models/CreateOrderModel.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/screens/Order/models/GetUserCardsPaymentDetailsModel.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:e_commerce/screens/Order/models/PaymentModel.dart';
import 'package:e_commerce/screens/OrderStatus/Model/OrderStatusModel.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SingleDealScreen/controller/SingleDealController.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';
import 'package:e_commerce/services/PermissionServices.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Address/Controller/AddressController.dart';
import '../../OrderStatus/Controller/OrderStatusController.dart';
import '../models/OrderSuccessModel.dart';

class OrderController extends GetxController {
  CreateOrder order = CreateOrder();
  final roundedButtonController = RoundedLoadingButtonController();
  final widgetController = Get.put(WidgetController());

  final apiController = Get.put(ApiController());
  List<PaymentModel> paymentModel = [];
  late List<GetUserCardsPaymentDetailsModel> savedPaymentcardsDetails;

  List<String> nameList = [];
  List<OrderStatusModel> statusList = [];
  bool isDeviceConnected = true;
  bool isLoadingPayments = true;
  void btnReload_onClick() {
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getPaymentMethods();
    }
  }

  @override
  void onInit() {
    apiController.checkConnectivity().then((value) {
      if (value) {
        order.receipt = Receipt();
        order.receipt!.entries = <Entry>[];
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

  void editItemPressed(
      BuildContext context, Entry entry, SingleItemController itemController) {
    itemController.isEditTrue = true;
    itemController.entryID = entry.entryId!;
    itemController.itemModel = entry.item!;
    itemController.itemModel.quantity = entry.qty;
    if (entry.ingredients!.isNotEmpty) {
      itemController.ingrList = entry.ingredients!;
    }
    if (entry.ingredients!.isEmpty) {
      itemController.ingrList = [];
    }
    itemController.update();

    Get.toNamed(route.singleItemPage);
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

  IngredientItem getIngItem(String id, List<IngredientItem> items) {
    IngredientItem name;

    name = items.firstWhere((element) => element.id == id);
    return name;
  }

  void updateEntryItem(String entryID, ItemModel itemModel,
      List<IngredientModel> ingList, String lineTotal, String finalPrice) {
    order.receipt!.entries!
        .firstWhere((element) => element.entryId == entryID)
        .item = itemModel;
    order.receipt!.entries!
        .firstWhere((element) => element.entryId == entryID)
        .qty = itemModel.quantity;

    if (ingList.isNotEmpty) {
      order.receipt!.entries!
          .firstWhere((element) => element.entryId == entryID)
          .finalprice = finalPrice;
      order.receipt!.entries!
              .firstWhere((element) => element.entryId == entryID)
              .linetotal =
          (double.parse(finalPrice) * double.parse(itemModel.quantity!))
              .toStringAsFixed(2);
      order.receipt!.entries!
          .firstWhere((element) => element.entryId == entryID)
          .ingredients = ingList;
    }

    update();
  }

  void onDealEdit(
      BuildContext context, Entry entry, SingleDealController dealController) {
    dealController.dealsModel = entry.deal!.deal!;

    dealController.update;
    dealController.editGetDealDetails(
        entry.deal!.deal!.dealid!, entry.deal!.itemList!);
    dealController.update();
    dealController.isEditTrue = true;
    dealController.entryID = entry.entryId!;
    dealController.update();
    update();
    Get.toNamed(route.singleDetailPage);
  }

  void updateDeal(String entryID, List<ItemModel> list) {
    order.receipt!.entries!
        .firstWhere((element) => element.entryId == entryID)
        .deal!
        .itemList = list;
  }

  String getAddressType() {
    String addressType = '';

    if (widgetController.orderType == "Pickup") {
      addressType = "Pickup Address";
    }

    if (widgetController.orderType == "Pickup - Curbside") {
      addressType = "Curbside Address";
    }
    if (widgetController.orderType == "Delivery") {
      addressType = "Delivery Address";
    }

    return addressType;
  }

  String getAddress() {
    final signController = Get.put(SignInController());
    String address = '';
    final mapController = Get.put(CustomMapController());

    if (widgetController.orderType == "Pickup" ||
        widgetController.orderType == "Pickup - Curbside") {
      for (var element in mapController.stores) {
        if (element.selected!) {
          address = element.locationaddress!.address!;
        }
      }
    }

    if (widgetController.orderType == "Delivery") {
      if (signController.addressList != null) {
        address = signController.addressList!
            .firstWhere((element) => element.isDefault!)
            .address
            .toString();
      }
    }

    return address;
  }

  void btnPlaceOrder_onClick(BuildContext context) {
    final addressListController = Get.put(AddressListController());
    print('object');
    print(apiController.authToken);

    final mapController = Get.put(CustomMapController());
    order.userID = apiController.userId;
    order.phoneNo = apiController.UserPhoneNo;
    order.addressID = addressListController.addressList!
        .firstWhere((element) => element.isDefault == true)
        .id!
        .toString();

    if (widgetController.orderType == "Pickup" ||
        widgetController.orderType == "Pickup - Curbside") {
      for (var element in mapController.stores) {
        if (element.selected!) {
          order.locationid = element.locationid;
          order.locationname = element.locationaddress!.address!;
        }
      }
    }
    if (widgetController.orderType == "Delivery") {
      order.locationid = '1';
      order.locationname = null;

      order.orderType = "Delivery";
    }
    if (widgetController.orderType == "Pickup") {
      order.orderType = "Pickup";
      order.receipt!.fees = null;
    }

    if (widgetController.orderType == "Pickup - Curbside") {
      String s = widgetController.orderType;
      String result = s.split(" - ").last;
      order.orderType = result;
      order.receipt!.fees = null;
    }

    for (var element in paymentModel) {
      if (element.isDefault == "true") {
        order.accountDetail = element;
        break;
      }
    }

    var jsonOrderCreate = order.toJson();
    log(jsonEncode(jsonOrderCreate));

    //lets Send this to Server So that it recieves the order there to validate

    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('Order/Create', jsonOrderCreate).then((value) {
            print('Order Created here $value');
            print(apiController.authToken);
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == "true") {
              PermissionService.getNotificationService();
              NotificationApi.init();
              listenNotifications();
              update();
              Get.offAllNamed(route.orderSuccessPage);

              OrderSuccessModel orderSuccessModel =
                  OrderSuccessModel.fromJson(apiResponse.successcode);

              const oneSec = Duration(seconds: 10);
              Timer.periodic(
                  oneSec,
                  (Timer t) => getOrderStatusAndShowNotification(
                      orderSuccessModel.orderID.toString()));
              order.receipt!.entries = [];
              order.receipt!.coupon = null;
            } else {
              print('error');
              update();
              snackBar('Error', apiResponse.failreason!);
            }
          });
        } catch (exception) {
          Get.toNamed(route.orderFailurePage);

          print('Server Exception in in Order Create');
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

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickNotication);
  }

  void onClickNotication(String? orderID) {
    final orderStatusController = Get.put(OrderStatusController());

    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall('Order/GetOrderDetailsByID_v2',
              {"orderID": orderID}).then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));
            if (apiResponse.success == 'true') {
              String jsonData = jsonEncode(apiResponse.successcode).toString();
              var parsedData = json.decode(jsonData);

              orderStatusController.order = CreateOrder.fromJson(parsedData);

              orderStatusController.getOrderStatus(orderID!);

              Get.toNamed(route.orderStatusPage);

              update();
            } else {
              print(
                  'An error accoured while getting information , please try again');
            }
          });
        } catch (exception) {
          print('exception while retrieving the order from order again ');
        }
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });

    orderStatusController.getOrderData(orderID!);
  }

  void getOrderStatusAndShowNotification(String id) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        try {
          apiController.apiCall(
              'Order/GetOrdersStatusByID', {"orderID": id}).then((value) {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              String catData = jsonEncode(apiResponse.successcode).toString();

              List parsedCat = json.decode(catData);

              List<OrderStatusModel> newList = parsedCat
                  .map((item) => OrderStatusModel.fromJson(item))
                  .toList();

              if (statusList.isEmpty) {
                statusList = parsedCat
                    .map((item) => OrderStatusModel.fromJson(item))
                    .toList();
              } else if (statusList.isNotEmpty) {
                if (newList.length > statusList.length) {
                  NotificationApi.showNotification(
                      title: 'Tap to view',
                      body: 'Your order is ready',
                      payload: id);

                  statusList = newList;
                }
              }

              update();
            } else {
              print('No Order History Found');
            }
          });
        } catch (exception) {
          print('Exception is Fething Order from server ');
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

  void getPaymentMethods() async {
    isLoadingPayments = true;

    apiController.checkConnectivity().then((value) async {
      if (value) {
        try {
          await apiController
              .apiCall('UserPaymentCardInfo/GetByPhoneNo')
              .then((value) async {
            final apiResponse = api_model.Response.fromJson(jsonDecode(value));

            if (apiResponse.success == 'true') {
              String catData = jsonEncode(apiResponse.successcode).toString();
              List parsedCat = json.decode(catData);
              paymentModel =
                  parsedCat.map((item) => PaymentModel.fromJson(item)).toList();
              isLoadingPayments = false;
            } else {
              print(
                  'Failed in Getting Response From Server for UserCards Details ');
            }
          });
        } catch (exception) {
          print('Server exceptions in getting the Saved Cards Details');
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

  int getOrderItemCount() {
    int itemCount = 0;
    if (order.receipt != null) {
      if (order.receipt!.entries != null) {
        itemCount = order.receipt!.entries!.length;
      }
    }
    return itemCount;
  }

  bool checkIfPaymentSelected() {
    bool isSelected = false;

    for (var element in paymentModel) {
      if (element.isDefault == "true") {
        isSelected = true;
      }
    }
    return isSelected;
  }

  bool checkIfCurbSide() {
    bool isSelected = false;
    if (widgetController.orderType == "Pickup - Curbside") {
      isSelected = true;
    }

    return isSelected;
  }

  void updateSelectedPaymentMethod(String cardNumber) {
    for (var element in paymentModel) {
      element.isDefault = "false";
    }
    update();
    paymentModel
        .where((element) => element.cardNumber == cardNumber)
        .first
        .isDefault = "true";
    update();
  }

  void addOrder(Entry entry) {
    if (order.receipt!.entries!.isEmpty) {
      createNewOrder(entry);
    } else if (order.receipt!.entries!.isNotEmpty) {
      updateItem(entry);
    }

    getPaymentMethods();
  }

  void createNewOrder(Entry entry) {
    addEntry(entry);
    order.orderID = "1";
    order.orderDateTime = DateTime.now().toString();
    order.orderstatus = "Pending";
    order.receipt!.tip = "0";
    order.receipt!.fees = getFees();

    order.orderSubTotalPrice = getOrderSubTotal().toStringAsFixed(2);
    order.receipt!.ordertotal = getOrderTotal().toStringAsFixed(2);
    order.locationid = apiController.LocationID;
    order.locationname =
        apiController.brandAuth.locations!.first.locationaddress!.address;

    order.notes = 'please be fast';

    // this needs to be updated on server for cardHolder and ccv

    update();
  }

  void updateItem(Entry entry) {
    bool ifItemExists = false;
    if (entry.item != null) {
      ifItemExists = order.receipt!.entries!
          .where((element) => element.entryId == entry.item!.id)
          .isNotEmpty;
    }
    if (entry.deal != null) {
      ifItemExists = order.receipt!.entries!
          .where((element) => element.entryId == entry.deal!.deal!.dealid)
          .isNotEmpty;
    }

    if (ifItemExists) {
      updateEntryQty(entry);
    } else {
      addEntry(entry);
    }
    updateOrderPrice();
  }

  void updateEntryQty(Entry entry) {
    if (entry.item != null) {
      if (entry.item!.isItemAddon == true) {
        entry.entryId = getID(entry.entryId!);

        addEntry(entry);
      }
      if (entry.item!.isItemAddon == false) {
        order.receipt!.entries!
            .removeWhere((element) => element.entryId == entry.item!.id);
        addEntry(entry);
      }
    }
    if (entry.deal != null) {
      entry.entryId = getID(entry.entryId!);

      addEntry(entry);
    }

    update();
  }

  void addEntry(Entry entry) {
    order.receipt?.entries?.add(entry);
    update();
  }

  void updateOrderPrice() {
    order.orderSubTotalPrice = getOrderSubTotal().toStringAsFixed(2);
    order.receipt!.ordertotal = getOrderTotal().toStringAsFixed(2);
    update();
  }

  void addTip(String tip) {
    order.receipt!.tip = getTip(tip);
    updateOrderPrice();
    update();
  }

  void removeTip() {
    order.receipt!.tip = "0";
    updateOrderPrice();
    update();
  }

  void applyCoupon(CouponModel couponModel) {
    if (getOrderSubTotal() >= couponModel.couponAmount!) {
      order.receipt!.coupon = couponModel;
      updateOrderPrice();
    } else {
      snackBar('Voucher Rules',
          'Voucher amount can not exceed Order Sub Total amount ');
    }

    update();
  }

  void removeCoupon() {
    order.receipt!.coupon = null;
    updateOrderPrice();
    update();
  }

  void btnIncrease(Entry entry) {
    int quantity;
    quantity = int.parse(order.receipt!.entries!
        .where((element) => element.entryId == entry.entryId)
        .first
        .qty!);

    updateEntryQtyCount(entry.entryId!, quantity + 1);
    updateOrderPrice();
  }

  void btnDecrease(Entry entry, BuildContext context) {
    int quantity;

    quantity = int.parse(order.receipt!.entries!
        .where((element) => element.entryId == entry.entryId)
        .first
        .qty!);
    if (quantity > 1) {
      updateEntryQtyCount(entry.entryId, quantity - 1);
      updateOrderPrice();
    } else {
      print("This item is 0");
      Slidable.of(context)?.openStartActionPane();
    }
  }

  void removeItem(Entry entry) {
    order.receipt!.entries!
        .removeWhere((element) => element.entryId == entry.entryId);
    updateOrderPrice();

    //widgetController.updateCartCount(widgetController.cartItemCount - 1);
    if (order.receipt!.entries!.isEmpty) {
      order = CreateOrder();
      order.receipt = Receipt();
      order.receipt!.entries = <Entry>[];
    }
    update();
  }

  void updateEntryQtyCount(String? id, int quantity) {
    print(
        'EntryID OF the Single Itemhere ${order.receipt!.entries![0].entryId}');
    order.receipt!.entries!
        .where((element) => element.entryId! == id)
        .first
        .qty = quantity.toString();

    double price = double.parse(order.receipt!.entries!
        .where((element) => element.entryId! == id)
        .first
        .finalprice!);
    order.receipt!.entries!
        .where((element) => element.entryId! == id)
        .first
        .linetotal = (quantity * price).toStringAsFixed(2);

    update();
  }

  String getID(String entryID) {
    String character = '_';
    String id = '';
    String updatedID = '';

    bool ifCopyExist = false;
    ifCopyExist = order.receipt!.entries!
        .where((element) => element.entryId!.contains(character))
        .isNotEmpty;
    if (ifCopyExist) {
      id = order.receipt!.entries!
          .where((element) => element.entryId!.contains(character))
          .last
          .entryId!;

      String increment = id.substring(id.indexOf('_') + 1);

      increment = (int.parse(increment) + 1).toString();
      updatedID = entryID + '_' + increment;
    } else {
      updatedID = entryID + '_1';
    }

    return updatedID;
  }

  double getOrderSubTotal() {
    double orderSubTotal = 0.0;
    for (var element in order.receipt!.entries!) {
      orderSubTotal +=
          double.parse(element.finalprice!) * int.parse(element.qty!);
    }

    return orderSubTotal;
  }

  double getVoucherAmount() {
    double amount = 0;

    if (order.receipt!.coupon != null) {
      amount = order.receipt!.coupon!.couponAmount!;
    }

    return amount;
  }

  double getOrderTotal() {
    double orderTotal = 0.0;
    orderTotal = (double.parse(order.receipt!.tip!) +
        getOrderSubTotal() -
        getVoucherAmount());
    if (widgetController.orderType == 'Pickup' ||
        widgetController.orderType == 'Pickup - Curbside') {
      // print('here in Getorderupdate $orderTotal ${widgetController.orderType}');
      //update();
      return orderTotal;
    } else {
      orderTotal = double.parse(order.receipt!.fees!.deliveryFee!) + orderTotal;
      // print('Getorderupdate $orderTotal ${widgetController.orderType}');
      //update();

      return orderTotal;
    }
  }

  String getTip(String tip) {
    return (((double.parse(tip) / 100.0) *
            double.parse(order.orderSubTotalPrice!)))
        .toStringAsFixed(2);
  }

  Fees getFees() {
    Fees fee = Fees();
    fee.deliveryFee = "1.99";
    fee.serviceFee = "0.00";
    fee.regularFee = "0.00";
    return fee;
  }

  String getEntryQty(Entry entry) {
    String qty = "0";
    qty = order.receipt!.entries!
        .where((element) => element.entryId == entry.entryId)
        .first
        .qty!;
    return qty;
  }

  String getItemPriceAsPerQuantity(Entry entry) {
    int qty = int.parse(order.receipt!.entries!
        .where((element) => element.entryId == entry.entryId)
        .first
        .qty!);
    double price = double.parse(order.receipt!.entries!
            .where((element) => element.entryId == entry.entryId)
            .first
            .finalprice!) *
        qty;
    return price.toStringAsFixed(2);
  }
}
