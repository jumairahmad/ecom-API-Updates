// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';

import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:e_commerce/screens/OrderView/controller/orderviewcontroller.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class OrderViewScreen extends StatelessWidget {
  OrderViewScreen({Key? key}) : super(key: key);
  final widgetcontroller = Get.put(WidgetController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    void btnClose_onPressed() {
      Get.toNamed(route.homePage);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getPageAppBar(context, "Order view", btnClose_onPressed, () {
        Navigator.pop(context);
      }),
      body: GetBuilder<OrderViewController>(
        builder: (controller) {
          return controller.isDeviceConnected
              ? Container(
                  // physics: NeverScrollableScrollPhysics(),
                  child: controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Status: ',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 100.w < 500
                                                      ? 12.sp
                                                      : 9.sp),
                                            ),
                                            Text(
                                              controller
                                                  .orderModel.orderstatus!,
                                              style: TextStyle(
                                                  color: kTxtColor,
                                                  fontSize: 100.w < 500
                                                      ? 12.sp
                                                      : 9.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Order ID: ',
                                              style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontSize: 100.w < 500
                                                      ? 12.sp
                                                      : 9.sp),
                                            ),
                                            Text(
                                              controller.orderModel.orderID!,
                                              style: TextStyle(
                                                  color: kTxtColor,
                                                  fontSize: 100.w < 500
                                                      ? 12.sp
                                                      : 9.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 0.1.h,
                                ),
                                child: Text(
                                  controller.orderModel.orderType == "Delivery"
                                      ? 'Delivery Address:'
                                      : 'Pickup Address:',
                                  style: TextStyle(
                                      color: kTxtColor,
                                      fontSize: 100.w < 500 ? 13.sp : 10.sp),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                child: SizedBox(
                                  height: 15.5.h,
                                  width: 92.w,
                                  child: Card(
                                    elevation: 5,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100.w < 500 ? 30.w : 35.w,
                                          child: CustomMap(),
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.pin_drop_outlined,
                                                  size: 100.w < 500 ? 5.w : 4.w,
                                                ),
                                                Icon(
                                                  Icons.person,
                                                  size: 100.w < 500 ? 5.w : 4.w,
                                                ),
                                                Icon(
                                                  Icons.phone,
                                                  size: 100.w < 500 ? 5.w : 4.w,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 50.w,
                                                  child: Text(
                                                      controller
                                                          .orderModel
                                                          .deliveryAddress!
                                                          .address!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall),
                                                ),
                                                Text('John Doe',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                                Text(
                                                    controller
                                                        .orderModel
                                                        .deliveryAddress!
                                                        .contactNo!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Visibility(
                                visible: controller.orderModel.orderstatus !=
                                        "Delivered" ||
                                    controller.orderModel.orderstatus !=
                                        "Pickedup",
                                child: Container(
                                  color: kTxtLightColor,
                                  height: 3.h,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order Created:',
                                          style: TextStyle(
                                              fontSize:
                                                  100.w < 500 ? 10.sp : 7.sp),
                                        ),
                                        Text(
                                          controller.orderModel.orderDateTime!,
                                          style: TextStyle(
                                              fontSize:
                                                  100.w < 500 ? 10.sp : 7.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                                child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .orderModel.receipt!.entries!.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return controller.orderModel.receipt!
                                                .entries![index].deal ==
                                            null
                                        ? OrderCard(
                                            entry: controller.orderModel
                                                .receipt!.entries![index],
                                          )
                                        : DealsCard(
                                            entry: controller.orderModel
                                                .receipt!.entries![index],
                                          );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 8.w,
                                ),
                                child: SizedBox(
                                  height: 18.h,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Sub Total",
                                                style: TextStyle(
                                                  // fontFamily: 'Roboto',
                                                  fontSize: 100.w < 500
                                                      ? 12.sp
                                                      : 9.sp,
                                                  color: kTxtColor,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "\$" +
                                                double.parse(controller
                                                        .orderModel
                                                        .orderSubTotalPrice!)
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                              // fontFamily: 'Roboto',
                                              fontSize:
                                                  100.w < 500 ? 13.sp : 10.sp,
                                              color: kTxtColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        ],
                                      ),
                                      Visibility(
                                        visible:
                                            controller.orderModel.orderType ==
                                                "Delivery",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery",
                                              style: TextStyle(
                                                // fontFamily: 'Roboto',
                                                fontSize:
                                                    100.w < 500 ? 12.sp : 9.sp,
                                                color: kTxtColor,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "\$" +
                                                  controller.orderModel.receipt!
                                                      .fees!.deliveryFee!,
                                              style: TextStyle(
                                                // fontFamily: 'Roboto',
                                                fontSize:
                                                    100.w < 500 ? 13.sp : 10.sp,
                                                color: kTxtColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.getTip() != "0",
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Tip",
                                              style: TextStyle(
                                                // fontFamily: 'Roboto',
                                                fontSize:
                                                    100.w < 500 ? 12.sp : 9.sp,
                                                color: kTxtColor,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              "\$" +
                                                  controller
                                                      .orderModel.receipt!.tip!,
                                              style: TextStyle(
                                                // fontFamily: 'Roboto',
                                                fontSize:
                                                    100.w < 500 ? 13.sp : 10.sp,
                                                color: kTxtColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                              // fontFamily: 'Roboto',
                                              fontSize:
                                                  100.w < 500 ? 12.sp : 9.sp,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Text(
                                            "\$" +
                                                double.parse(controller
                                                        .orderModel
                                                        .receipt!
                                                        .ordertotal!)
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                              // fontFamily: 'Roboto',
                                              fontSize:
                                                  100.w < 500 ? 13.sp : 10.sp,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: kTxtLightColor,
                                height: 3.h,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Notes: ',
                                        style: TextStyle(
                                            fontSize:
                                                100.w < 500 ? 10.sp : 7.sp),
                                      ),
                                      Text(
                                        controller.orderModel.notes!,
                                        style: TextStyle(
                                            fontSize:
                                                100.w < 500 ? 10.sp : 7.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Visibility(
                                visible: controller.orderModel.orderstatus ==
                                        "Delivered" ||
                                    controller.orderModel.orderstatus ==
                                        "Pickedup",
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: 4.5.h,
                                    width: 85.w,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryColor),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Re-Order',
                                        style: TextStyle(
                                            fontSize:
                                                100.w < 500 ? 14.sp : 11.sp),
                                      ),
                                      onPressed: () {
                                        controller.btnOrderAgain_OnClick(
                                            context,
                                            controller.orderModel.orderID
                                                .toString());
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              : NoInternetWiget(btnController, controller.btnReload_onClick);
        },
      ),
    );
  }
}

class DealsCard extends StatelessWidget {
  final Entry? entry;

  const DealsCard({
    Key? key,
    this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      height: 12.h,
      width: 80.w,
      child: Card(
        elevation: 5,
        shadowColor: kTxtLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: kTxtLightColor,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              entry!.deal!.deal!.image!,
              width: 16.w,
            ),
            SizedBox(
              width: 0.5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44.w,
                  child: Text(
                    entry!.deal!.deal!.dealname!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  '\$' + double.parse(entry!.finalprice!).toStringAsFixed(2),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Deal',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 100.w < 500 ? 12.sp : 9.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '\$' + double.parse(entry!.linetotal!).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Quantity: ' + entry!.qty!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Entry entry;

  final itemController = Get.put(SingleItemController());
  final orderViewController = Get.put(OrderViewController());

  OrderCard({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: entry.item!.isItemAddon == true ? 15.h : 13.h,
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Card(
        elevation: 5,
        shadowColor: kTxtLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: kTxtLightColor,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              entry.item!.image!,
              width: 16.w,
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 44.w,
                  child: Text(entry.item!.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall),
                ),
                Visibility(
                  visible: entry.item!.isItemAddon == false,
                  child: Text(
                    "\$" + double.parse(entry.finalprice!).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodySmall,
                    textScaleFactor: 1.0,
                  ),
                ),
                Visibility(
                  visible: entry.item!.isItemAddon == true,
                  child: SizedBox(
                    height: 9.h,
                    width: 38.w,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingrediants',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 100.w < 500 ? 10.sp : 7.sp,
                              color: kTxtColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  orderViewController.getIngrLength(entry),
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  orderViewController
                                      .nameList[index].capitalizeFirst!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Item',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 100.w < 500 ? 12.sp : 9.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Text('\$' + double.parse(entry.linetotal!).toStringAsFixed(2),
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    'Quantity: ' + entry.qty!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMap extends StatelessWidget {
  const CustomMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderViewController>(builder: (controller) {
      return GoogleMap(
        mapType: MapType.terrain,
        cameraTargetBounds: CameraTargetBounds.unbounded,
        initialCameraPosition: controller.camPosPickup,
        myLocationEnabled: false,
        mapToolbarEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: controller.onMapPickupCreated,
        markers: controller.markers,
      );
    });
  }
}
