// ignore_for_file: prefer_const_literals_to_create_immutables, constant_identifier_names, non_constant_identifier_names, must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 130);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 130);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SingleItemScreen extends StatelessWidget {
  SingleItemScreen({Key? key}) : super(key: key);
  // final orderController = Get.put(OrderController());
  final singleItemController = Get.put(SingleItemController());

  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleItemController>(builder: (controller) {
      return controller.isDeviceConnected
          ? Scaffold(
              appBar: getPageAppBar(context, "Detail", () {
                controller.btnClose_onPressed(context);
              }, () {
                controller.btnBack_onPressed(context);
              }, kTxtLightColor),
              body: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: kTxtLightColor,
                      height: 1.h,
                    ),
                    SizedBox(
                      height: controller.itemModel.isItemAddon! ? 23.h : 28.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.topCenter,
                        fit: StackFit.expand,
                        children: <Widget>[
                          Positioned(
                            child: ClipPath(
                              clipper: MyClipper(),
                              child: Container(
                                  height: 19.h, color: kTxtLightColor),
                            ),
                          ),
                          Positioned(
                            top: -1.h,
                            child: Column(
                              children: [
                                Text(
                                  controller.itemModel.name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kTxtColor,
                                      fontSize: 100.w < 500 ? 14.sp : 11.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$" +
                                          double.parse(controller
                                                  .itemModel.regularprice!)
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                        decoration:
                                            controller.itemModel.onspecial! ==
                                                    "true"
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                        color: Colors.grey,
                                        fontSize: 100.w < 500 ? 12.sp : 9.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: controller.itemModel.onspecial! ==
                                              "true"
                                          ? 4.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible:
                                          controller.itemModel.onspecial! ==
                                                  "true"
                                              ? true
                                              : false,
                                      child: Text(
                                        "\$" +
                                            double.parse(controller
                                                    .itemModel.specialprice!)
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 100.w < 500 ? 13.sp : 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: controller.itemModel.isItemAddon!
                                ? 4.h
                                : 100.w < 500
                                    ? 5.h
                                    : 6.h,
                            child: SizedBox(
                              width: controller.itemModel.isItemAddon!
                                  ? 25.h
                                  : 30.h,
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'item_${controller.itemModel.id}',
                                child: Image.network(
                                  controller.itemModel.image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: controller.itemModel.isItemAddon! ? 1.h : 8.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ItemQuantityWidget(
                            Text(
                              controller.itemModel.quantity!,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 100.w < 500 ? 10.sp : 7.sp),
                            ),
                            controller.btnIncrease,
                            controller.btnDecrease)
                      ],
                    ),
                    SizedBox(
                      height: controller.itemModel.isItemAddon! ? 1.h : 4.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              color: kTxtColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 100.w < 500 ? 11.sp : 8.5.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.itemModel.contents!,
                        maxLines: 5,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 100.w < 500 ? 12.sp : 9.sp),
                      ),
                    ),
                    Visibility(
                      visible: controller.itemModel.isItemAddon!,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            "Ingrediants",
                            style: TextStyle(
                                color: kTxtColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 100.w < 500 ? 11.sp : 8.5.sp),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: Visibility(
                              visible: controller
                                          .getAllIngPrice()
                                          .toStringAsFixed(2) ==
                                      '0.00'
                                  ? false
                                  : true,
                              child: Text(
                                '\$${controller.getAllIngPrice().toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: kTxtColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 100.w < 500 ? 11.sp : 8.5.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.itemModel.isItemAddon!,
                      child: SizedBox(
                        child: CustomizeOrder(),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: GetBuilder<SingleItemController>(
                builder: (controller) {
                  return CustomBottomNavigation(
                    txtButtonTitle: 'Add To Cart',
                    txtPrice: "\$ " + controller.getItemPriceAsPerQuantity(),
                    btnPressed: () {
                      controller.btnAddToCart_OnClick(context);
                    },
                  );
                },
              ),
              // floatingActionButton: AnotherMenu(),
            )
          : Scaffold(
              appBar: getPageAppBar(
                context,
                "Detail",
                () {},
                () {},
                kTxtColor.withOpacity(0.1),
              ),
              body:
                  NoInternetWiget(btnController, controller.btnReload_onClick),
            );
    });
  }
}

class CustomBottomNavigation extends StatelessWidget {
  final String txtButtonTitle;
  final String txtPrice;
  final void Function()? btnPressed;
  const CustomBottomNavigation(
      {Key? key,
      required this.txtButtonTitle,
      required this.txtPrice,
      required this.btnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 11.5.h,
      child: Padding(
        padding: EdgeInsets.only(right: 8.0, left: 8, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Total price',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  txtPrice,
                  style: TextStyle(
                    //fontFamily: 'Roboto',
                    fontSize: 100.w < 500 ? 16.sp : 12.sp,
                    color: kTxtColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  child: SizedBox(
                      width: 40.w,
                      height: 4.5.h,
                      child: Center(
                          child: Text(
                        txtButtonTitle,
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            fontWeight: FontWeight.w600),
                      ))),
                  onPressed: btnPressed),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomizeOrder extends StatelessWidget {
  const CustomizeOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
        child: Column(
          children: [
            Expanded(
              flex: 100.w < 500 ? 4 : 4,
              child: GetBuilder<SingleItemController>(builder: (controller) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller
                        .ingrList
                        //.where((element) => int.parse(element.maxItemSelection!) >1)
                        .length,
                    itemBuilder: (BuildContext ctxt, int i) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Theme(
                          data: ThemeData(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            collapsedTextColor: kTxtColor,
                            collapsedIconColor: kTxtColor,
                            textColor: kPrimaryColor,
                            iconColor: kPrimaryColor,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.ingrList[i].headText!,
                                  style: TextStyle(
                                      fontSize: 100.w < 500 ? 10.sp : 7.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Visibility(
                                  visible: controller.getPricePerIng(
                                              controller.ingrList[i]) ==
                                          '0.00'
                                      ? false
                                      : true,
                                  child: Text(
                                    '\$${controller.getPricePerIng(controller.ingrList[i])}',
                                    style: TextStyle(
                                        fontSize: 100.w < 500 ? 10.sp : 7.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.ingrList[i].items!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    margin: EdgeInsets.only(),
                                    child: ListTile(
                                      dense: true,
                                      title: Text(
                                        controller
                                            .ingrList[i].items![index].name!,
                                        style: TextStyle(
                                            fontSize:
                                                100.w < 500 ? 10.sp : 7.sp),
                                      ),
                                      leading: Image.network(controller
                                          .ingrList[i].items![index].image!),
                                      trailing: SizedBox(
                                        width: 30.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              controller.ingrList[i]
                                                  .items![index].price!,
                                              style: subTitleStyle,
                                            ),
                                            CupertinoSwitch(
                                                value: controller
                                                    .ingrList[i].includedItems!
                                                    .contains(int.parse(
                                                        controller.ingrList[i]
                                                            .items![index].id!
                                                            .toString())),
                                                onChanged: (val) {
                                                  controller.updateSelection(
                                                      controller.ingrList[i],
                                                      controller.ingrList[i]
                                                          .items![index],
                                                      val);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 1,
                                    color: kPrimaryColor,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
            ),
            Expanded(
              flex: 4,
              child: SizedBox(
                height: 10.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
