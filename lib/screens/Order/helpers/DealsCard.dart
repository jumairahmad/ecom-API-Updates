// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:e_commerce/screens/SingleDealScreen/controller/SingleDealController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class DealsCard extends StatelessWidget {
  final Entry? entry;
  final OrderController? orderController;
  final dealController = Get.put(SingleDealController());
  DealsCard({this.entry, this.orderController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Slidable.of(context)!.openStartActionPane(),
      child: Container(
        margin: EdgeInsets.only(top: 1.h, left: 2.w),
        height: 100.w < 500 ? 18.h : 16.5.h,
        width: 95.w,
        child: Card(
          elevation: 5,
          shadowColor: kTxtLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRaius),
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
                height: 100.w < 500 ? 12.h : 12.h,
                width: 100.w < 500 ? 25.w : 24.w,
              ),
              SizedBox(
                width: 0.5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 100.w < 500 ? 38.w : 50.w,
                    child: Text(
                      entry!.deal!.deal!.dealname!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 100.w < 500 ? 11.sp : 8.sp,
                        color: kTxtColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  SizedBox(
                    height: 100.w < 500 ? 10.h : 9.h,
                    width: 38.w,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 100.w < 500 ? 10.sp : 7.5.sp,
                              color: kTxtColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: entry!.deal!.itemList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(
                                  "( " +
                                      entry!.deal!.itemList![index].quantity! +
                                      " ) " +
                                      entry!.deal!.itemList![index].name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 100.w < 500 ? 10.sp : 7.sp,
                                    color: kTxtColor,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: SizedBox(
                      //width: .w,
                      height: 4.2.h,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                orderController!.onDealEdit(
                                    context, entry!, dealController);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: kPrimaryColor,
                              )),
                          Card(
                            elevation: 0,
                            child: Center(
                              child: Text(
                                'Deal',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 100.w < 500 ? 12.sp : 9.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h, right: 2.w),
                    child: ItemQuantityWidget(
                      Text(
                        orderController!.getEntryQty(entry!),
                        style: TextStyle(fontSize: 100.w < 500 ? 10.sp : 7.sp),
                      ),
                      () {
                        orderController!.btnIncrease(entry!);
                      },
                      () {
                        orderController!.btnDecrease(entry!, context);
                      },
                    ),
                  ),
                  Text(
                    '\$' + orderController!.getItemPriceAsPerQuantity(entry!),
                    style: Theme.of(context).textTheme.titleMedium,
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
