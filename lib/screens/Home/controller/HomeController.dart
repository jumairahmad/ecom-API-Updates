// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/WebHook/Models/ApiModel.dart' as ApiModel;

import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/Widgets/Widgets.dart';

import 'package:e_commerce/screens/Home/HomeScreen.dart';
import 'package:e_commerce/screens/Home/models/CategoryModel.dart';
import 'package:e_commerce/screens/Home/models/DealsModel.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/LoyaltyHistory/controller/LoyaltyHistorycontroller.dart';
import 'package:e_commerce/screens/Search/controller/searchController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants.dart';

class HomeController extends GetxController {
  late String jsonData;
  bool isCatLoaded = false;
  bool isDealLoaded = false;
  bool isItemsLoaded = false;

  List<CategoryModel> catList = [];
  List<DealsModel> dealsList = [];
  List<ItemModel> itemList = [];
  ItemsResult itemsResult = ItemsResult();

  final apiController = Get.put(ApiController());
  final searchController = Get.put(SearchController());

  TextEditingController editingController = TextEditingController();
  final loyaltyHistoryController = Get.put(LoyaltyHistoryController());

  //final couponController = Get.put(CouponController());
  int perPageItem = 6;
  int pageCount = 0;
  int selectedIndex = 0;
  int lastPageItemLength = 0;
  PageController pageController = PageController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool isDeviceConnected = true;
  final int minSearchCharacters = 3;
  final int maxSearchCharacters = 20;

  String address = '';
  String orderType = 'Deliver To';
  String brandid = "1";
  String apptoken = "A02X0129Z1002020X4";

  //AuthDataObject authDataObject = AuthDataObject();
  BrandAuth brandAuth = BrandAuth();

  LatLng userCurrentLoc = LatLng(00.00, 00.00);

  @override
  void onInit() {
    PermissionService.getLocationService();
    PermissionService.getNotificationService();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onRefresh() async {
    print(apiController.authToken);
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    //if failed,use refreshFailed()
    PermissionService.getLocationService();
    PermissionService.getNotificationService();
    isItemsLoaded = false;
    isCatLoaded = false;
    isDealLoaded = false;
    itemList = [];
    perPageItem = 6;
    pageCount = 0;
    selectedIndex = 0;
    lastPageItemLength = 0;
    apiController.checkConnectivity().then((value) {
      setDefault(value);
    });

    update();
  }

  void btnReload_onClick() {
    PermissionService.getLocationService();
    PermissionService.getNotificationService();
    apiController.checkConnectivity().then((value) => setDefault(value));
  }

  void btnGrid_onClick(String title, BuildContext context, String routeName) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        searchController.getProductByCategory(title);
        //searchController.txtSearchController.text = title;
        Get.toNamed(routeName);
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }

  void btnSeeAll_onClick(BuildContext context, String routeName) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        searchController.txtSearchController.text = '';
        searchController.getAllSpecialItem();
        Get.offAllNamed(routeName);
      } else {
        isDeviceConnected = false;
        update();
      }
    }).catchError((val) {
      isDeviceConnected = false;
      update();
    });
  }

  void setDefault(bool val) {
    isDeviceConnected = val;
    update();
    if (val) {
      getCategories();
    }
  }

  void updateIndex(int value) {
    selectedIndex = value;
    update();
  }

  void catDotIndicator() {
    pageController = PageController(initialPage: 0);

    var num = (catList.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = catList.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;
    update();
  }

  void getCategories() async {
    PermissionService.getLocationService();
    PermissionService.getNotificationService();
    try {
      await apiController.apiCall('Category/GetList').then((value) {
        updateCategoryList(value);
        getDealsData();
      });
    } catch (exception) {
      print(exception);
      print('Exception in Home Page While Retriving Categories from server');
    }
  }

  void updateCategoryList(dynamic result) {
    final apiResponse = ApiModel.Response.fromJson(jsonDecode(result));
    if (apiResponse.success == "true") {
      isCatLoaded = true;

      String catData = jsonEncode(apiResponse.successcode).toString();
      List parsedCat = json.decode(catData);
      catList = parsedCat.map((item) => CategoryModel.fromJson(item)).toList();
      update();
      catDotIndicator();
    } else {
      snackBar('Error', 'Get Categories Api Error ');
    }
  }

  void getItems() async {
    try {
      await apiController.apiCall('Items/ItemSearch',
          {"searchtype": "specials", "searchcontents": ""}).then((value) {
        updateItemsList(value);
      });
    } catch (exception) {
      print(
          'Exception while Retrieving Items through getItems() in Home Page Controller');
    }
  }

  void updateItemsList(dynamic result) {
    isItemsLoaded = true;
    itemList = [];
    final apiResponse = ApiModel.Response.fromJson(jsonDecode(result));

    if (apiResponse.success == "true") {
      String productData = jsonEncode(apiResponse.successcode).toString();
      log(productData);
      itemsResult = ItemsResult.fromJson(jsonDecode(productData));
      if (itemsResult.items!.length < 6) {
        itemList.addAll(itemsResult.items!);
      } else {
        for (int i = 0; i < 6; i++) {
          itemList.add(itemsResult.items![i]);
        }
      }

      update();
      itemList[0].hasIngredients = "true";
      update();
    } else {
      snackBar('Api Error', apiResponse.failreason!);
    }
  }

  void getDealsData() async {
    try {
      await apiController.apiCall('Deals/GetList').then((value) {
        updateDealsList(value);
        getItems();
      });
    } catch (exceptions) {
      print('EXception while Retriving Deals Data in HomePAge Controller');
    }
  }

  void updateDealsList(dynamic result) {
    final apiResponse = ApiModel.Response.fromJson(jsonDecode(result));

    if (apiResponse.success == "true") {
      isDealLoaded = true;

      String dealData = jsonEncode(apiResponse.successcode).toString();
      List parsedDeal = json.decode(dealData);
      dealsList = parsedDeal
          .map((item) => DealsModel.fromJson(item))
          .where((element) => element.dealrules!.isNotEmpty)
          .toList();

      update();
    } else {
      snackBar('Error', 'Get deals api errro');
    }
  }

  void onSearchSubmit(
    String searchItem,
    BuildContext context,
    String routeName,
  ) {
    apiController.checkConnectivity().then((value) {
      if (value) {
        if (searchItem.length >= minSearchCharacters &&
            searchItem.length < maxSearchCharacters) {
          searchController.getItemBySearchName(searchItem);
          searchController.txtSearchController.text = searchItem;
          searchController.update();
          Get.toNamed(routeName);
        } else {
          snackBar('Search', 'Please enter item name');
        }
      } else {
        isDeviceConnected = value;
        update();
      }
    }).catchError((val) {});
  }

  void authBrand() async {
    apiController.apiCall('Stores/GetListByID').then((value) {
      updateAuthDataObject(value);
    });
  }

  void updateAuthDataObject(result) async {
    final apiResponse = ApiModel.Response.fromJson(jsonDecode(result));
    final jsondata = await rootBundle.loadString('assets/locations.json');

    final list = json.decode(jsondata) as List<dynamic>;

    if (apiResponse.success == "true") {
      brandAuth = BrandAuth.fromJson(apiResponse.successcode!);
      brandAuth.locations!
          .addAll(list.map((e) => Locations.fromJson(e)).toList());
      apiController.UserName = "guest";

      update();
      apiController.LocationID =
          brandAuth.locations!.first.locationid.toString();

      apiController.brandAuth = brandAuth;
      apiController.update();
      getCategories();

      update();
    } else {
      print('Api Error : ' + apiResponse.failreason!);
    }
  }

  void searchDealsList(String name) {
    ////////////////////
    var pattern = name.toLowerCase();

    var starts = dealsList
        .where((s) => s.dealname!.toLowerCase().startsWith(pattern))
        .toList();
    var contains = dealsList
        .where((s) =>
            s.dealname!.toLowerCase().contains(pattern) &&
            !s.dealname!.toLowerCase().startsWith(pattern))
        .toList()
      ..sort((a, b) =>
          a.dealname!.toLowerCase().compareTo(b.dealname!.toLowerCase()));

    var combined = [...starts, ...contains];
    //print(combined);
    dealsList = combined;
    update();
  }

  void checkConnection() {
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
  }
}
 





// created modifiend

// pages used in

//General details about

// orignal reference JSon file Name

//model references