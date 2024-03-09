//import 'package:e_commerce/models/search.dart';
// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as api_model;
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final apiController = Get.put(ApiController());

  List<ItemModel> itemList = [];
  ItemsResult itemsResult = ItemsResult();

  TextEditingController txtSearchController = TextEditingController();
  bool isItemsLoaded = false;
  final int minSearchCharacters = 3;
  final int maxSearchCharacters = 20;
  bool isDeviceConnected = true;
  bool isTextChanged = false;

  void onSearchSubmit(String searchItem) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        if (searchItem.length >= minSearchCharacters &&
            searchItem.length < maxSearchCharacters) {
          if (searchItem == txtSearchController.text) {
            print(
                "here in onSearch controller ${txtSearchController.text}   and $searchItem  ");
            txtSearchController.text = searchItem;
            getItemBySearchName(searchItem);
            update();
          } else {
            txtSearchController.text = searchItem;
            getItemBySearchName(searchItem);
            update();
          }
        } else {
          snackBar('Search', 'Please Enter a Item Name ');
        }
      } else {
        isDeviceConnected = value;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }

  void btnReload_onClick() {
    onRefresh();
  }

  void onRefresh() {
    isItemsLoaded = false;
    apiController.checkConnectivity().then((value) {
      isDeviceConnected = value;
      update();
      if (value) {
        getItemBySearchName(txtSearchController.text);
        update();
      }
    });
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    fetchFive();
    update();
  }

  void getProductByCategory(String cat) async {
    isItemsLoaded = false;
    itemList = [];
    try {
      await apiController.apiCall('Items/ItemSearch',
          {"searchtype": "category", "searchcontents": cat}).then((value) {
        updateItemsList(value);
      });
    } catch (exception) {
      print('Server Exception while retrieving Categories');
    }
  }

  void getItemBySearchName(String name) async {
    isItemsLoaded = false;
    itemList = [];
    if (name == '') {
      name == 'ab';
    }
    try {
      await apiController.apiCall('Items/ItemSearch',
          {"searchtype": "NAME", "searchcontents": name}).then((value) {
        updateItemsList(value);
      });
    } catch (exception) {
      isItemsLoaded = true;
      itemList = [];
      update();
    }
  }

  void getAllSpecialItem() async {
    isItemsLoaded = false;
    itemList = [];

    try {
      await apiController.apiCall('Items/ItemSearch',
          {"searchtype": "specials", "searchcontents": ''}).then((value) {
        updateItemsList(value);
      });
    } catch (exception) {
      print('Server Exceptions while retrieving Special Items');
    }
  }

  void updateItemsList(dynamic result) {
    isItemsLoaded = true;
    final apiResponse = api_model.Response.fromJson(jsonDecode(result));

    String productData = jsonEncode(apiResponse.successcode).toString();

    itemsResult = ItemsResult.fromJson(jsonDecode(productData));
    if (int.parse(itemsResult.itemcount!) > 0) {
      fetchFive();
    }

    update();
  }

  void addItemsToList(int i) {
    if (itemList.length < itemsResult.items!.length) {
      itemList.add(itemsResult.items![itemList.length]);
    }
    update();
  }

  void fetchFive() {
    for (int i = 0; i < 5; i++) {
      addItemsToList(i);
    }
    update();
  }
}
