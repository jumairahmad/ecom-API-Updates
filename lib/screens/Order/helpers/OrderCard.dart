//ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/OrderModel.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderCard extends StatelessWidget {
  final Entry entry;
  final OrderController? orderController;
  final itemController = Get.put(SingleItemController());

  OrderCard({required this.entry, this.orderController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Slidable.of(context)!.openStartActionPane(),
      child: Container(
        margin: EdgeInsets.only(
          top: 0.5.h,
          left: 2.w,
        ),
        height: entry.item!.isItemAddon == true ? 17.5.h : 17.h,
        width: 95.w,
        child: Card(
          elevation: 5,
          shadowColor: kTxtLightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRaius),
            side: BorderSide(color: kTxtLightColor, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                entry.item!.image!,
                height: 100.w < 500 ? 12.h : 12.h,
                width: 100.w < 500 ? 25.w : 24.w,
              ),
              SizedBox(
                width: 2.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 38.w,
                      child: Text(
                        entry.item!.name!,
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
                      height: 1.h,
                    ),
                    Visibility(
                      visible: entry.item!.isItemAddon == false,
                      child: Text(
                        "\$" +
                            double.parse(entry.finalprice!).toStringAsFixed(2),
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
                                      orderController?.getIngrLength(entry),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text(
                                      orderController?.nameList[index] ??
                                          'test',
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
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 100.w < 500 ? 12.w : 9.w),
                    child: IconButton(
                        onPressed: () {
                          orderController!
                              .editItemPressed(context, entry, itemController);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: kPrimaryColor,
                          size: 100.w < 500 ? 6.w : 3.w,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 100.w < 500 ? 2.w : 2.w),
                    child: ItemQuantityWidget(
                      Text(
                        orderController!.getEntryQty(entry),
                        style: TextStyle(fontSize: 100.w < 500 ? 10.sp : 7.sp),
                      ),
                      () {
                        orderController!.btnIncrease(entry);
                      },
                      () {
                        orderController!.btnDecrease(entry, context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 100.w < 500 ? 2.w : 2.w),
                    child: Text(
                      '\$' + orderController!.getItemPriceAsPerQuantity(entry),
                      style: Theme.of(context).textTheme.titleMedium,
                      textScaleFactor: 1.0,
                    ),
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
