// ignore_for_file: must_be_immutable

import 'package:e_commerce/screens/OrderStatus/Controller/OrderStatusController.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class CardOfStatus extends StatelessWidget {
  CardOfStatus({Key? key}) : super(key: key);
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
                            size: 100.w < 500 ? 6.2.w : 4.8.w,
                          ),
                        ),
                        title: Text(
                            controller.isOrderAccepted()
                                ? 'Order Created'
                                : 'Order Pending',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(
                            controller.isOrderAccepted()
                                ? controller.statusList
                                    .firstWhere((element) =>
                                        element.orderStatus == "Pending")
                                    .orderDateTime!
                                : '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    Positioned(
                      top: 100.w < 500 ? 7.h : 5.7.h,
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
                    ),
                    Positioned(
                      top: 10.h,
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
                            size: 100.w < 500 ? 6.2.w : 4.8.w,
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
                    CustomDotedLines(100.w < 500 ? 16.5.h : 15.8.h),
                    Positioned(
                      top: 17.5.h,
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
                            size: 100.w < 500 ? 6.2.w : 4.8.w,
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
                    CustomDotedLines(100.w < 500 ? 24.h : 23.1.h),
                    Positioned(
                      top: 25.h,
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
                            size: 100.w < 500 ? 6.2.w : 4.8.w,
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
                    CustomDotedLines(100.w < 500 ? 31.5.h : 30.6.h),
                    Positioned(
                      top: 32.5.h,
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
                            color: controller.isOrderOnRoute()
                                ? Colors.deepPurple
                                : kTextGreyColor,
                          ),
                          child: Icon(
                            controller.isOrderOnRoute()
                                ? Icons.check
                                : Icons.info,
                            color: Colors.white,
                            size: 100.w < 500 ? 6.2.w : 4.8.w,
                          ),
                        ),
                        title: Text(
                            controller.isOrderOnRoute()
                                ? 'Rider picked your order'
                                : 'Waiting for rider',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderOnRoute()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "OnRoute")
                                        .orderDateTime!
                                    : '',
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.w < 500 ? 39.h : 38.h,
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
                      top: 43.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ListTile(
                        onTap: () {
                          // should be implemented to see changes
                        },
                        leading: Icon(
                          Icons.directions_bike_outlined,
                          color: kIconColor,
                          size: 100.w < 500 ? 6.2.w : 4.8.w,
                        ),
                        title: Text(
                            controller.isOrderDelivered()
                                ? 'Order Delivered'
                                : 'Order will be delivered soon',
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Row(
                          children: [
                            Text(
                                controller.isOrderDelivered()
                                    ? controller.statusList
                                        .firstWhere((element) =>
                                            element.orderStatus == "Delivered")
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
        lineLength: 3.h,
      ),
    );
  }
}
