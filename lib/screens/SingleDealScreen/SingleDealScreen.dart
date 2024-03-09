// ignore_for_file: prefer_const_literals_to_create_immutables, constant_identifier_names, non_constant_identifier_names, must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_single_cascade_in_expression_statements

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Home/models/DealsModel.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/SingleItem/SingleItemScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;
import 'controller/SingleDealController.dart';
import 'helpers/SingleDealSkeleton.dart';

class SingleDealScreen extends StatelessWidget {
  SingleDealScreen({Key? key}) : super(key: key);
  final dealController = Get.put(SingleDealController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleDealController>(builder: (controller) {
      return controller.isDeviceConnected
          ? Scaffold(
              appBar: getPageAppBar(
                context,
                "Deal",
                () {
                  controller.isItemsLoaded = false;
                  controller.update();
                  Navigator.popAndPushNamed(context, route.homePage);
                },
                () {
                  controller.isItemsLoaded = false;
                  controller.update();
                  Navigator.popAndPushNamed(context, route.homePage);
                },
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 20.w,
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: 'deal_' + controller.dealsModel.dealid!,
                          child: Image.network(
                            controller.dealsModel.image!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text(
                        controller.dealsModel.dealname!.capitalizeFirst!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kTxtColor,
                            fontSize: 100.w < 500 ? 14.sp : 10.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        getDealRules(controller.dealsModel),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kTextGreyColor,
                            fontSize: 100.w < 500 ? 12.sp : 9.sp,
                            //fontFamily: 'Muli',
                            fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: !controller.isItemsLoaded,
                        child: SizedBox(
                          height: 59.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return SingleDealSkeleton();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 59.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.itemList.length,
                          itemBuilder: (context, index) {
                            return DealsCard(
                              item: controller.itemList[index],
                              dealsModel: controller.dealsModel,
                              dealController: controller,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: SizedBox(
                height: 11.5.h,
                child: Column(
                  children: [
                    Visibility(
                      visible: !controller.isDealConditionTrue,
                      child: Container(
                        height: 6.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: kTxtColor.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              color: kPrimaryColor,
                              size: 100.w < 500 ? 5.w : 3.w,
                            ),
                            Text(
                              'Please select any ' +
                                  controller.dealRuleQty().toStringAsFixed(0) +
                                  " items",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isDealConditionTrue,
                      child: CustomBottomNavigation(
                          txtButtonTitle: 'Add To Cart',
                          txtPrice: "\$ " + controller.getPriceAfterDiscount(),
                          btnPressed: () {
                            controller.btnAddToCart_onClick(context);
                          }),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: getPageAppBar(
                context,
                "Deal",
                () {},
                () {},
              ),
              body:
                  NoInternetWiget(btnController, controller.btnReload_onClick),
            );
    });
  }

  String getDealRules(DealsModel dealsModel) {
    String dealRule = '';
    if (dealsModel.discounttype == "price") {
      dealRule = "\$ " +
          (double.parse(dealsModel.dealrules!.first.qty!) *
                  double.parse(dealsModel.dealrules!.first.priceeach!))
              .toStringAsFixed(2);
    } else if (dealsModel.discounttype == "percent") {
      dealRule = "- " +
          (double.parse(dealsModel.dealrules!.first.priceeach!))
              .toStringAsFixed(0) +
          " %";
    }
    return dealRule;
  }
}

class DealsCard extends StatelessWidget {
  //final OrderModel order;
  final ItemModel item;
  final DealsModel? dealsModel;
  final OrderController? orderController;
  final SingleDealController? dealController;
  DealsCard({
    //required this.order,
    this.dealsModel,
    required this.item,
    this.orderController,
    this.dealController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h, left: 3.w, right: 3.w),
      height: 13.5.h,
      width: 75.w,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                item.image!,
                width: 22.w,
              ),
            ),
            SizedBox(
              width: 1.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 38.w,
                  child: Text(
                    item.name!.capitalizeFirst!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 100.w < 500 ? 11.sp : 8.sp,
                      color: kTxtColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "\$" + double.parse(item.regularprice!).toStringAsFixed(2),
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 100.w < 500 ? 12.sp : 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  getPriceAfterDiscount(dealsModel!, item),
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 100.w < 500 ? 12.sp : 9.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            ItemQuantityWidget(
              Text(
                item.quantity!.toString(),
                style: TextStyle(fontSize: 100.w < 500 ? 10.sp : 10.sp),
              ),
              () {
                dealController!.btnIncreaseProduct(item);
              },
              () {
                dealController!.btnDecreaseProduct(item, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  String getPriceAfterDiscount(DealsModel dealsModel, ItemModel item) {
    String price = '';
    if (dealsModel.discounttype == "price") {
      price = "\$" +
          double.parse(dealsModel.dealrules!.first.priceeach!)
              .toStringAsFixed(2);
    } else {
      double pr = double.parse(item.regularprice!) *
          (double.parse(dealsModel.dealrules!.first.priceeach!) / 100);
      price = "\$" + (double.parse(item.regularprice!) - pr).toStringAsFixed(2);
    }

    // if (element.quantity != '0') {
    //       price += double.parse(element.regularprice!) -
    //           ((double.parse(dealsModel.dealrules!.first.priceeach!) / 100) *
    //               double.parse(element.regularprice!));
    //       print(price);
    //     }
    return price;
  }
}
