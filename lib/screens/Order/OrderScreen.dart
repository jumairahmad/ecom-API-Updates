// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/controller/CustomMapController.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';
import 'package:e_commerce/screens/Order/helpers/CheckOut.dart';
import 'package:e_commerce/screens/Order/helpers/Login.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SingleDealScreen/controller/SingleDealController.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:e_commerce/screens/Order/helpers/OrderCard.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import 'controller/OrderController.dart';
import 'package:e_commerce/routes.dart' as route;

import 'helpers/DealsCard.dart';

class OrderScreen extends StatelessWidget {
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return orderController.order.receipt!.entries!.isEmpty
          ? EmptyCartScreen()
          : CartScreen();
    });
  }
}

class CartScreen extends StatelessWidget {
  final productController = Get.put(HomeController());
  final widgetController = Get.put(WidgetController());
  final customMapController = Get.put(CustomMapController());
  final userController = Get.put(SignInController());
  final dealController = Get.put(SingleDealController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    GlobalKey<FabCircularMenuState> fabKeyClear =
        GlobalKey<FabCircularMenuState>();
    GlobalKey<FabCircularMenuState> fabKey = GlobalKey<FabCircularMenuState>();
    return GetBuilder<OrderController>(builder: (controller) {
      void btnClose_onPressed() {
        // if (controller.fabKey.currentState!.isOpen) {
        //   controller.fabKey.currentState!.close();
        // }

        Get.toNamed(route.homePage);
      }

      double getFabSize() {
        double size = 4.h;

        if (double.parse(controller.order.receipt!.tip!) > 0) {
          if (100.w < 500) {
            size = 17.w;
          } else {
            size = 9.w;
          }
        } else {
          if (100.w < 500) {
            size = 12.w;
          } else {
            size = 8.w;
          }
        }

        return size;
      }

      return controller.isDeviceConnected
          ? Scaffold(
              appBar:
                  getPageAppBar(context, 'My Order', btnClose_onPressed, () {
                controller.update();
                Navigator.pop(context);
              }),
              bottomNavigationBar: SizedBox(
                height: 11.5.h,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total price',
                            style: TextStyle(
                              // fontFamily: 'Roboto',
                              fontSize: 100.w < 500 ? 12.sp : 9.sp,
                              color: kTxtColor,
                              fontWeight: FontWeight.w300,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: 30.w,
                            child: Text(
                              "\$" +
                                  controller.getOrderTotal().toStringAsFixed(2),
                              style: TextStyle(
                                //fontFamily: 'Roboto',
                                fontSize: 100.w < 500 ? 15.sp : 11.sp,
                                color: kTxtColor,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Flexible(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          child: SizedBox(
                              width: 55.w,
                              height: 4.5.h,
                              child: Center(
                                  child: Text(
                                "Checkout",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.fontSize,
                                    fontWeight: FontWeight.w600),
                              ))),
                          onPressed: () {
                            fabKey.currentState!.close();
                            showMaterialModalBottomSheet(
                              expand: false,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                side: BorderSide(
                                    color: Colors.black12, width: 0.5),
                              ),
                              context: context,
                              builder: (context) {
                                if (userController.user.userfullName == '' ||
                                    userController.user.userfullName == null) {
                                  return IfNotLoggedIn();
                                } else {
                                  controller.getPaymentMethods();
                                  return CheckOut();
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: SizedBox(
                //height: 100.h,
                child: Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.order.receipt!.entries!.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return Slidable(
                              key: ValueKey(
                                  controller.order.receipt!.entries![index]),
                              enabled: true,
                              startActionPane: ActionPane(
                                // A motion is a widget used to control how the pane animates.
                                motion: const ScrollMotion(),
                                extentRatio: 0.7,
                                // A pane can dismiss the Slidable.
                                dismissible: DismissiblePane(onDismissed: () {
                                  controller.removeItem(controller
                                      .order.receipt!.entries![index]);
                                  // controller.removeCoupon();
                                  controller.update();
                                }),

                                // All actions are defined in the children parameter.
                                children: [
                                  // A SlidableAction can have an icon and/or a label.
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 10.h,
                                      width: 22.w,
                                      child: Card(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.removeItem(controller
                                                  .order
                                                  .receipt!
                                                  .entries![index]);

                                              controller.update();
                                            },
                                            child: Container(
                                                color: kPrimaryColor,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.delete,
                                                        color: Colors.white,
                                                        size: 100.w < 500
                                                            ? 8.w
                                                            : 4.w),
                                                    Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium
                                                                  ?.fontSize,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                        margin: EdgeInsets.zero,
                                        shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: kPrimaryColor,
                                            )),
                                      ),
                                    ),
                                  ),

                                  GetCancelButton()
                                ],
                              ),
                              child: controller.order.receipt!.entries![index]
                                          .deal ==
                                      null
                                  ? OrderCard(
                                      orderController: controller,
                                      entry: controller
                                          .order.receipt!.entries![index],
                                    )
                                  : DealsCard(
                                      orderController: controller,
                                      entry: controller
                                          .order.receipt!.entries![index],
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 5.w, right: 8.w, top: 1.h, bottom: 1.h),
                      child: SizedBox(
                        height: widgetController.orderType == 'Pickup' ||
                                widgetController.orderType ==
                                    'Pickup - Curbside'
                            ? 15.h
                            : 19.h,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Sub Total",
                                      style: TextStyle(
                                        // fontFamily: 'Roboto',
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                            ?.fontSize,
                                        color: kTxtColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  controller
                                      .getOrderSubTotal()
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                    // fontFamily: 'Roboto',
                                    fontSize: 100.w < 500 ? 14.sp : 11.sp,
                                    color: kTxtColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: widgetController.orderType == 'Pickup' ||
                                      widgetController.orderType ==
                                          'Pickup - Curbside'
                                  ? false
                                  : true,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery",
                                    style: TextStyle(
                                      // fontFamily: 'Roboto',
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.fontSize,
                                      color: kTxtColor,
                                    ),
                                  ),
                                  Text(
                                    widgetController.orderType == 'Pickup' ||
                                            widgetController.orderType ==
                                                'Pickup - Curbside'
                                        ? '0.0'
                                        : controller
                                            .order.receipt!.fees!.deliveryFee!,
                                    style: TextStyle(
                                      // fontFamily: 'Roboto',
                                      fontSize: 100.w < 500 ? 14.sp : 11.sp,
                                      color: kTxtColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.sell_outlined,
                                      color: kPrimaryColor,
                                      size: 100.w < 500 ? 5.w : 3.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Visibility(
                                      visible:
                                          controller.getVoucherAmount() <= 0
                                              ? true
                                              : false,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (userController
                                                      .user.userfullName ==
                                                  '' ||
                                              userController
                                                      .user.userfullName ==
                                                  null ||
                                              userController
                                                      .user.userfullName ==
                                                  'Guest') {
                                            fabKey.currentState!.close();
                                            showMaterialModalBottomSheet(
                                              expand: false,
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  topRight: Radius.circular(25),
                                                ),
                                                side: BorderSide(
                                                    color: Colors.black12,
                                                    width: 0.5),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return IfNotLoggedIn();
                                              },
                                            );

                                            //Navigator.push(context, );
                                          } else {
                                            Navigator.pushNamed(
                                                context, route.couponPage);
                                          }
                                        },
                                        child: Text(
                                          "Apply a voucher",
                                          style: TextStyle(
                                            // fontFamily: 'Roboto',
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .headlineLarge
                                                ?.fontSize,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.getVoucherAmount() > 0
                                          ? true
                                          : false,
                                      child: GestureDetector(
                                        onTap: () => controller.removeCoupon(),
                                        child: Text(
                                          "Remove Voucher",
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .headlineLarge
                                                ?.fontSize,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: controller.getVoucherAmount() > 0
                                      ? true
                                      : false,
                                  child: Text(
                                    '-' +
                                        controller
                                            .getVoucherAmount()
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      // fontFamily: 'Roboto',
                                      fontSize: 100.w < 500 ? 16.sp : 12.sp,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                // fit: StackFit.expand,
                children: [
                  FabCircularMenu(
                    animationDuration: Duration(seconds: 1),
                    ringColor: kTxtLightColor,
                    ringWidth: 100.w < 500 ? 40 : 65,
                    key: fabKeyClear,
                    fabMargin: EdgeInsets.only(left: 4.w),
                    fabElevation: 0,
                    ringDiameter: 100.w < 500 ? 200 : 400,
                    fabSize: 100.w < 500 ? 12.5.w : 8.w,
                    fabColor: kTxtLightColor,
                    alignment: Alignment.bottomLeft,
                    fabOpenIcon: FabOpenIconCustom('Clear', Icons.delete),
                    fabCloseIcon: Icon(
                      Icons.close,
                      color: kPrimaryColor,
                      size: 100.w < 500 ? 9.w : 5.w,
                    ),
                    children: [
                      TipButtonwidget(() {
                        controller.order.receipt!.entries = [];
                        controller.update();
                        fabKeyClear.currentState!.close();
                      }, 'Yes', Colors.white, kPrimaryColor),
                      TipButtonwidget(() {
                        fabKeyClear.currentState!.close();
                      }, 'No', Colors.white, kTxtColor),
                    ],
                  ),
                  FabCircularMenu(
                    animationDuration: Duration(seconds: 1),
                    key: fabKey,
                    fabMargin: EdgeInsets.only(right: 4.w),
                    ringColor: kTxtLightColor,
                    ringWidth: 100.w < 500 ? 40 : 65,
                    fabSize: getFabSize(),
                    fabElevation: 0,
                    ringDiameter: 100.w < 500 ? 350 : 600,
                    fabOpenColor: kTxtLightColor,
                    fabCloseColor:
                        double.parse(controller.order.receipt!.tip!) > 0
                            ? Colors.transparent
                            : kTxtLightColor,
                    //alignment: Alignment.bottomRight,
                    fabOpenIcon:
                        double.parse(controller.order.receipt!.tip!) > 0
                            ? FabCloseIconCustom(controller)
                            : FabOpenIconCustom('Tip', Icons.add_outlined),
                    fabCloseIcon: Icon(
                      Icons.close,
                      color: kPrimaryColor,
                      size: 100.w < 500 ? 9.w : 5.w,
                    ),
                    children: [
                      TipButtonwidget(() {
                        controller.addTip("5");
                        fabKey.currentState!.close();
                      }, '5%', Colors.white, kTxtColor),
                      TipButtonwidget(() {
                        controller.addTip("10");
                        fabKey.currentState!.close();
                      }, '10%', Colors.white, kTxtColor),
                      TipButtonwidget(() {
                        controller.addTip("15");
                        fabKey.currentState!.close();
                      }, '15%', Colors.white, kTxtColor),
                      TipButtonwidget(() {
                        controller.addTip("20");
                        fabKey.currentState!.close();
                      }, '20%', Colors.white, kTxtColor),
                      TipButtonwidget(() {
                        controller.addTip("25");
                        fabKey.currentState!.close();
                      }, '25%', Colors.white, kTxtColor),
                    ],
                  )
                ],
              ),
            )
          : Scaffold(
              appBar:
                  getPageAppBar(context, 'My Order', btnClose_onPressed, () {
                controller.update();
                Navigator.pop(context);
              }),
              body:
                  NoInternetWiget(btnController, controller.btnReload_onClick),
            );
    });
  }
}

class GetCancelButton extends StatelessWidget {
  const GetCancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 10.h,
        width: 22.w,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => Slidable.of(context)!.close(),
              child: Container(
                  color: kTxtColor.withOpacity(0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close,
                          color: kTxtColor, size: 100.w < 500 ? 8.w : 4.w),
                      Text(
                        'Cancel',
                        style: TextStyle(
                            color: kTxtColor,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            ),
          ),
          margin: EdgeInsets.zero,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: kLightBlue,
              )),
        ),
      ),
    );
  }
}

class FabOpenIconCustom extends StatelessWidget {
  String? txt;
  IconData? icon;
  FabOpenIconCustom(this.txt, this.icon);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 0.6.h),
        child: Column(
          children: [
            Icon(
              icon!,
              color: kPrimaryColor,
              size: 100.w < 500 ? 5.w : 3.5.w,
            ),
            Text(
              txt!,
              style: TextStyle(
                  fontSize: 100.w < 500 ? 9.sp : 5.5.sp,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class FabCloseIconCustom extends StatelessWidget {
  OrderController? controller;
  FabCloseIconCustom(this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //color: Colors.amber,
          height: 100.w < 500 ? 5.h : 4.h,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.close_outlined, size: 100.w < 500 ? 6.w : 3.w),
            onPressed: () {
              controller!.removeTip();
            },
            color: kPrimaryColor,
          ),
        ),
        Text(
          "\$" + controller!.order.receipt!.tip! + ' Tip',
          style: TextStyle(
              fontSize: 100.w < 500 ? 11.sp : 6.sp,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor),
        ),
      ],
    );
  }
}

class TipButtonwidget extends StatelessWidget {
  VoidCallback ontap;
  String titleOfButton;

  Color btnColor;
  Color textcolor;
  TipButtonwidget(
      this.ontap, this.titleOfButton, this.textcolor, this.btnColor);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100.w < 500 ? 8.w : 5.5.w,
        decoration: BoxDecoration(
          color: btnColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            titleOfButton,
            style: TextStyle(
              fontSize: 100.w < 500 ? 10.sp : 6.sp,
              fontWeight: FontWeight.bold,
              color: textcolor,
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void btnBrowse_OnClick() {
      Navigator.popAndPushNamed(context, route.homePage);
    }

    void btnClose_OnClick() {
      Navigator.popAndPushNamed(context, route.homePage);
    }

    return Scaffold(
      appBar: getPageAppBar(context, "", btnClose_OnClick, () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 40.w,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/icons/EmptyCart_1.png',
              ),
            ),
          ),
          Text(
            "Your cart is empty!",
            style: TextStyle(
                color: kTxtColor,
                fontSize: 100.w < 500 ? 18.sp : 13.sp,
                fontWeight: FontWeight.bold,
                wordSpacing: 10,
                shadows: <Shadow>[
                  Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(1, 1),
                      blurRadius: 15),
                ]),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            "Looks like you haven't made your choice",
            style: TextStyle(
                fontSize: 100.w < 500 ? 16.sp : 12.sp,
                color: kTextGreyColor,
                wordSpacing: 4),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5.h,
          ),
          PrimaryButton(
              title: 'Browse',
              height: 5.h,
              width: 50.w,
              callback: btnBrowse_OnClick,
              fontSize: 100.w < 500 ? 16.sp : 13.sp)
        ],
      ),
    );
  }
}


//  Initial Created By Name , Date , Created by

// Modified by Name , Date

// Widgets type ,Page,Component,etc

// Parent Widget Name

// details about the widgets