import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/OrderStatus/helper/PickupStatus.dart';
import 'package:e_commerce/screens/OrderStatus/helper/cardOfStatus.dart';
import 'package:e_commerce/screens/OrderStatus/Controller/OrderStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../constants.dart';
import '../CurbSide/CurbSideOrder/controller/CurbSideOrderController.dart';

class OrderStatusScreen extends StatelessWidget {
  OrderStatusScreen({Key? key}) : super(key: key);
  final orderStatusControlelr = Get.put(OrderStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getPageAppBar(context, 'Order Status', () {
          Navigator.of(context).pop();
        }, () {
          Navigator.of(context).pop();
        }),
        body: GetBuilder<OrderStatusController>(builder: (controller) {
          return Container(
            child: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Text(
                        controller.order!.orderType == "Delivery"
                            ? 'Estimated Delivery Time'
                            : 'Estimated Pickup Time',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        '05:30 PM',
                        style: TextStyle(
                          fontSize: 100.w < 500 ? 18.sp : 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      controller.order!.orderType == "Delivery"
                          ? CardOfStatus()
                          : PickupStatus(),
                      SizedBox(
                        height: controller.order!.orderType == "Delivery"
                            ? 9.h
                            : 5.h,
                      ),
                      Visibility(
                        visible: controller.isOrderPickup() &&
                            controller.isOrderReady() &&
                            !controller.isOrderPickedUp(),
                        child: Text('Please select pickup type',
                            style: Theme.of(context).textTheme.headlineMedium),
                      ),
                      Visibility(
                        visible: controller.isOrderPickup() &&
                            controller.isOrderReady() &&
                            !controller.isOrderPickedUp(),
                        child: SizedBox(
                          height: 100.w < 500 ? 0.h : 1.h,
                        ),
                      ),
                      Visibility(
                        visible: controller.isOrderPickup() &&
                            controller.isOrderReady() &&
                            !controller.isOrderPickedUp(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PrimaryButton(
                              title: 'Walk-in',
                              height: 4.5.h,
                              width: 30.w,
                              callback: () {
                                // Navigator.of(context).pop();
                              },
                              brRadius: 2.h,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.fontSize,
                            ),
                            PrimaryButton(
                              title: 'CurbSide',
                              height: 4.5.h,
                              width: 30.w,
                              callback: () {
                                final curbSideOrderController =
                                    Get.put(CurbSideOrderController());
                                curbSideOrderController.curbSide.orderID =
                                    orderStatusControlelr.orderID;
                                curbSideOrderController.update();
                                Get.toNamed(route.curbSideHowItWorks);
                              },
                              brRadius: 2.h,
                              bgColor: Colors.indigo.shade100,
                              txtColor: kTxtColor,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.fontSize,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !controller.isOrderPickup() ||
                            !controller.isOrderReady() &&
                                controller.isOrderPickedUp() ||
                            controller.isOrderDelivered(),
                        child: PrimaryButton(
                          title: 'Back To Home',
                          height: 6.h,
                          width: 80.w,
                          callback: () {
                            Navigator.of(context).pop();
                          },
                          brRadius: 2.h,
                          fontSize: 100.w < 500 ? 14.sp : 10.sp,
                        ),
                      ),
                    ],
                  ),
          );
        }));
  }
}
