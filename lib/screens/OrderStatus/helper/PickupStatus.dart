// ignore_for_file: must_be_immutable

import 'package:e_commerce/screens/OrderStatus/Controller/OrderStatusController.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class PickupStatus extends StatelessWidget {
  PickupStatus({Key? key}) : super(key: key);
  final orderStatusControlelr = Get.put(OrderStatusController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderStatusController>(builder: (controller) {
      return Card(
        margin: EdgeInsets.symmetric(horizontal: 4.h),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.5.h),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
                child: Row(
                  children: [
                    Text('Track Order',
                        style: Theme.of(context).textTheme.titleLarge),
                    Spacer(),
                    Text('Orderid: ' + controller.orderID.toString(),
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              Divider(
                height: 2.h,
                color: Colors.grey.shade600,
              ),
              SizedBox(
                height: 50.h,
                width: 100.w,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Container(
                          width: 4.h,
                          height: 4.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isOrderAccepted()
                                ? Colors.green
                                : kTextGreyColor,
                          ),
                          child: Icon(
                            controller.isOrderAccepted()
                                ? Icons.check
                                : Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            controller.isOrderAccepted()
                                ? 'Order Created'
                                : 'Order Pending',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderAccepted()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Pending")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.w < 500 ? 6.8.h : 6.h,
                      right: 0,
                      bottom: 0,
                      left: 100.w < 500 ? 4.0.h : 3.h,
                      child: DottedLine(
                        dashLength: 0.5.h,
                        dashGapLength: 0.5.h,
                        lineThickness: 0.5.h,
                        dashColor: Colors.green,
                        dashRadius: 0.4.h,
                        dashGapColor: Colors.transparent,
                        direction: Axis.vertical,
                        lineLength: 6.h,
                      ),
                    ),
                    Positioned(
                      top: 11.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Container(
                          width: 4.h,
                          height: 4.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isOrderReceived()
                                ? Colors.pink.shade500
                                : kTextGreyColor,
                          ),
                          child: Icon(
                            controller.isOrderReceived()
                                ? Icons.check
                                : Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            controller.isOrderReceived()
                                ? 'Order Received'
                                : 'Waiting for order to be received',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderReceived()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Received")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ),
                    CustomDotedLines(100.w < 500 ? 17.8.h : 16.5.h),
                    Positioned(
                      top: 21.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Container(
                          width: 4.h,
                          height: 4.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isOrderProcessing()
                                ? Colors.blueAccent
                                : kTextGreyColor,
                          ),
                          child: Icon(
                            controller.isOrderProcessing()
                                ? Icons.check
                                : Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            controller.isOrderProcessing()
                                ? 'Order Processing'
                                : 'Waiting for order to be processed',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderProcessing()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Processing")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ),
                    CustomDotedLines(100.w < 500 ? 28.h : 26.8.h),
                    Positioned(
                      top: 31.5.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Container(
                          width: 4.h,
                          height: 4.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.isOrderReady()
                                ? Colors.amberAccent
                                : kTextGreyColor,
                          ),
                          child: Icon(
                            controller.isOrderReady()
                                ? Icons.check
                                : Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                            controller.isOrderReady()
                                ? 'Order Ready'
                                : 'Order will be ready soon',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderReady()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Ready")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.w < 500 ? 38.h : 37.h,
                      right: 0,
                      bottom: 0,
                      left: 100.w < 500 ? 4.0.h : 3.h,
                      child: DottedLine(
                        dashLength: 0.5.h,
                        dashGapLength: 0.5.h,
                        lineThickness: 0.5.h,
                        dashColor: Colors.green,
                        dashRadius: 0.4.h,
                        dashGapColor: Colors.transparent,
                        direction: Axis.vertical,
                        lineLength: 7.h,
                      ),
                    ),
                    Positioned(
                      top: 43.h,
                      left: 100.w < 500 ? 0.h : 1.w,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Icon(
                          Icons.storefront_outlined,
                          color: kIconColor,
                          size: 100.w < 500 ? 6.w : 4.w,
                        ),
                        title: Text(
                            controller.isOrderPickedUp()
                                ? 'Order PickedUp'
                                : '',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderPickedUp()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Pickedup")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CustomDotedLines extends StatelessWidget {
  double? height;
  CustomDotedLines(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height,
      right: 0,
      bottom: 0,
      left: 100.w < 500 ? 4.0.h : 3.h,
      child: DottedLine(
        dashLength: 0.5.h,
        dashGapLength: 0.5.h,
        lineThickness: 0.5.h,
        dashColor: Colors.green,
        dashRadius: 0.4.h,
        dashGapColor: Colors.transparent,
        direction: Axis.vertical,
        lineLength: 5.h,
      ),
    );
  }
}
