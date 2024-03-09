// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/OrderHistory/controller/OrderHistoryController.dart';
import 'package:e_commerce/screens/OrderView/controller/orderviewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'models/OrderHistoryModel.dart';
import 'package:intl/intl.dart';
import 'package:e_commerce/routes.dart' as route;

class OrderHistory extends StatelessWidget {
  final orderHistoryController = Get.put(OrderHistoryController());
  OrderHistory({Key? key}) : super(key: key);
  final refreshController = RefreshController(initialRefresh: false);
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    void btnClose_onPressed() {
      Get.toNamed(route.homePage);
    }

    void onRefresh() {
      orderHistoryController.onRefresh();
      refreshController.refreshCompleted();
    }

    return Scaffold(
        appBar: getPageAppBar(context, "My Orders", btnClose_onPressed, () {
          Navigator.pop(context);
        }),
        body: GetBuilder<OrderHistoryController>(builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80.h,
                    width: 95.w,
                    child: SmartRefresher(
                      physics: ScrollPhysics(),
                      enablePullDown: true,
                      enablePullUp: false,
                      header: WaterDropHeader(),
                      controller: refreshController,
                      onRefresh: onRefresh,
                      child: controller.isDeviceConnected
                          ? ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.orderHistoryList!.length,
                              itemBuilder: (context, index) {
                                return OrderCard(
                                    order: controller.orderHistoryList![index]);
                              },
                            )
                          : NoInternetWiget(
                              btnController, controller.btnReload_onClick),
                    ),
                  ),
                );
        }));
  }
}

class OrderCard extends StatelessWidget {
  final orderHistoryController = Get.put(OrderHistoryController());
  final orderViewController = Get.put(OrderViewController());
  final OrderHistoryModel order;
  OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        orderViewController.viewOrder(order.orderID.toString());

        Get.toNamed(route.orderViewPage);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.5.h),
        child: SizedBox(
          child: Card(
            shadowColor: kTxtLightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: kTxtLightColor,
                width: 1,
              ),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 1.5.h, bottom: 1.h, right: 2.w, left: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.locationName!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 0.4.h,
                      ),
                      Text(
                        order.totalItems.toString() + " items",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 100.w < 500 ? 2.h : 1.h,
                      ),
                      Text(
                        // getOrderType(order.deliveryStatus!),
                        order.orderStatus!,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      Text(
                        order.orderDateTime!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${order.totalAmount}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        height: 3.5.h,
                      ),
                      PrimaryButton(
                          title: order.orderStatus == 'Delivered' ||
                                  order.orderStatus == 'Pickedup'
                              ? 'Order Again'
                              : 'Track Order',
                          height: 100.w < 500 ? 5.h : 4.h,
                          width: 25.w,
                          callback: () {
                            if (order.orderStatus == 'Delivered') {
                              btnOrderAgain_OnClick(
                                  context, order.orderID.toString());
                            } else {
                              orderHistoryController.btnTrackOrder_onPressed(
                                  context, order.orderID.toString());
                            }
                          },
                          fontSize: 100.w < 500 ? 12.sp : 9.sp)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void btnOrderAgain_OnClick(BuildContext context, String order_id) {
    // dialog to conform the order again here

    Get.defaultDialog(
      title: 'Order Again ?',
      middleText: 'Press Cancel Or continue',
      backgroundColor: Colors.white,
      radius: 3.h,
      textCancel: 'Cancel',
      cancelTextColor: Colors.black,
      textConfirm: 'Continue',
      confirmTextColor: Colors.white,
      onCancel: () {},
      onConfirm: () {
        orderHistoryController.orderAgainPressed(context, order_id);
      },
      buttonColor: kPrimaryColor,
    );
  }

  String getOrderType(int val) {
    if (val == 1) {
      return "Delivered";
    } else {
      return "Picked Up";
    }
  }

  String getDate(String date) {
    DateTime dateTime = DateFormat("dd-MM-yyyy hh:mm:ss").parse(date);
    DateTime now = DateTime.now();
    String day =
        DateFormat('EE').format(DateFormat("dd-MM-yyyy hh:mm:ss").parse(date));
    String time =
        DateFormat.jm().format(DateFormat("dd-MM-yyyy hh:mm:ss").parse(date));
    String diff;
    // print(now.difference(dateTime).inHours);
    if (now.difference(dateTime).inHours < 24) {
      diff = "Today";
    } else if (now.difference(dateTime).inHours >= 24 &&
        now.difference(dateTime).inHours < 48) {
      diff = "Yesterday";
    } else {
      diff = DateFormat().add_yMMMd().format(dateTime);
    }
    return day + " " + time + ", " + diff;
  }
}
