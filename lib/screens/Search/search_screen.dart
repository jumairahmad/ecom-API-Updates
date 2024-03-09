// ignore_for_file: must_be_immutable

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/screens/Search/controller/searchController.dart';
import 'package:e_commerce/screens/Search/helpers/searchdetailscardwidget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/screens/Search/helpers/SkeletonWidget.dart';

import '../../constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  bool showElevatedButtonBadge = true;
  TextEditingController editingController = TextEditingController();
  final searchController = Get.put(SearchController());
  final apiController = Get.put(ApiController());
  final homeController = Get.put(HomeController());
  //final TextEditingController _searchByNamecontroller = TextEditingController();

  final userController = Get.put(SignInController());
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        height: 100.w < 500 ? 8.h : 7.h,
        width: 100.w < 500 ? 14.w : 10.w,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          //Floating action button on Scaffold
          onPressed: () {
            //code to execute on button press
          },
          child: ShoppingCartBadge(), //icon inside button
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNav(),
      appBar: getAppBar(
          context,
          getInitials(userController.user.userfullName == null ||
                  userController.user.userfullName == ' '
              ? 'Guest'
              : userController.user.firstName! +
                  ' ' +
                  userController.user.lastName!)),
      backgroundColor: Colors.white,
      body: GetBuilder<SearchController>(builder: (controller) {
        return SmartRefresher(
          physics: ScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          controller: refreshController,
          onRefresh: () {
            controller.onRefresh();
            refreshController.refreshCompleted();
          },
          onLoading: () {
            controller.onLoading();
            refreshController.loadComplete();
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: controller.isDeviceConnected
                    ? Column(
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 4.w, left: 4.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 6.2.h,
                                  width: 75.w,
                                  child: Card(
                                    elevation: 5,
                                    color: kTxtLightColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(borderRaius),
                                    ),
                                    child: TextField(
                                      controller:
                                          searchController.txtSearchController,
                                      style: subTitleStyle,
                                      textInputAction: TextInputAction.search,
                                      onChanged: (value) {},
                                      onSubmitted: (value) {
                                        controller.onSearchSubmit(value);
                                      },
                                      decoration: searchStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.5.h,
                                  width: 14.w,
                                  child: Card(
                                      elevation: 5,
                                      color: kTxtLightColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(borderRaius),
                                      ),
                                      child: ShoppingCartBadge()),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Column(
                            children: [
                              Visibility(
                                visible: !controller.isItemsLoaded,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        SearchSkeletonCard(),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 10,
                                        ),
                                    itemCount: 6),
                              ),
                              Visibility(
                                  visible: controller.isItemsLoaded,
                                  child: controller.itemList.isNotEmpty
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller.itemList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: 1.h,
                                                  left: 3.w,
                                                  right: 3.w),
                                              child: SearchDetailsCardWidget(
                                                  item: controller
                                                      .itemList[index]),
                                            );
                                          },
                                        )
                                      : Text("No product found")),
                            ],
                          ),
                        ],
                      )
                    : NoInternetWiget(RoundedLoadingButtonController(),
                        controller.btnReload_onClick)),
          ),
        );
      }),
    );
  }
}
