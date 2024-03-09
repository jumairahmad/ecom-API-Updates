// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/PaymentModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../../constants.dart';

class CheckOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

    return GetBuilder<OrderController>(builder: (controller) {
      return SizedBox(
        height: 75.h,
        child: Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
          child: Column(
            children: [
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Checkout',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                  color: kTxtColor,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Payment method',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: kTxtColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    iconSize: 100.w < 500 ? 5.5.w : 3.5.w,
                    onPressed: () {
                      Get.toNamed(route.addNewPaymentPage);
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              controller.paymentModel.isNotEmpty
                  ? SizedBox(
                      height: 30.h,
                      child: controller.isLoadingPayments
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              //physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.paymentModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.only(top: 1.h, bottom: 1.h),
                                    child: PaymentCard(
                                        controller.paymentModel[index]));
                              }),
                    )
                  : NoPaymentMethods(),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.getAddressType(),
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: kTxtColor,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    iconSize: 100.w < 500 ? 5.w : 3.5.w,
                    onPressed: () {
                      if (controller.getAddressType() == "Delivery Address") {
                        Get.toNamed(route.addressListPage);
                      } else {
                        Get.toNamed(route.deliveryPage);
                      }
                    },
                    icon: Icon(
                      Icons.edit_outlined,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.w < 500 ? 40 : 80,
                    width: 100.w < 500 ? 40 : 80,
                    child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          Icons.location_on,
                          size: 100.w < 500 ? 6.w : 4.w,
                        )),
                  ),
                  SizedBox(
                    height: 7.h,
                    width: 78.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderController.getAddress(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Visibility(
                visible: (controller.checkIfPaymentSelected()),
                child: RoundedLoadingButton(
                  controller: controller.roundedButtonController,
                  color: kPrimaryColor,
                  onPressed: () {
                    controller.btnPlaceOrder_onClick(context);
                  },
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: Colors.white,
                    ),
                  ),
                  animateOnTap: true,
                  height: 100.w < 500 ? 4.5.h : 4.h,
                  width: 60.w,
                  resetDuration: Duration(seconds: 3),
                  resetAfterDuration: true,
                  errorColor: kPrimaryColor,
                  successColor: kTextColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class NoPaymentMethods extends StatelessWidget {
  const NoPaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/Paypal.png'),
              title: Text(
                "Paypal",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.expand_more,
                    size: 100.w < 500 ? 6.w : 4.w,
                  )),
            ),
            Divider(
              thickness: 0.5,
              color: kTextGreyColor,
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/Apple_Pay.png'),
              title: Text(
                "Apple Pay",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.expand_more,
                    size: 100.w < 500 ? 6.w : 4.w,
                  )),
            ),
            Divider(
              thickness: 0.5,
              color: kTextGreyColor,
            ),
            ListTile(
              dense: true,
              leading: Image.asset('assets/icons/Credit_Card.png'),
              title: Text(
                "Credit/Debit Card",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.expand_more,
                    size: 100.w < 500 ? 6.w : 4.w,
                  )),
              onTap: () {
                Get.toNamed(route.cardDetailPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  PaymentModel paymentModel;
  PaymentCard(this.paymentModel);
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: paymentModel.isDefault == "true"
          ? RoundedRectangleBorder(
              side: BorderSide(color: kTxtColor, width: 1),
              borderRadius: BorderRadius.circular(12),
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
      child: ListTile(
        dense: true,
        shape: paymentModel.isDefault == "true"
            ? RoundedRectangleBorder(
                side: BorderSide(color: kTxtColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
        leading: Image.asset(
          paymentModel.cardType!.replaceAll(' ', '_') == "Mastercard"
              ? "assets/icons/Master.png"
              : "assets/icons/Visa.png",
          fit: BoxFit.scaleDown,
          width: 100.w < 500 ? 12.w : 14.w,
        ),
        title: Text(
          paymentModel.cardHolder!,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            color:
                paymentModel.isDefault == "true" ? kTxtColor : kTextGreyColor,
          ),
        ),
        subtitle: Text(paymentModel.cardNumber!,
            style: Theme.of(context).textTheme.headlineMedium),
        trailing: IconButton(
          iconSize: 100.w < 500 ? 4.w : 4.w,
          icon: paymentModel.isDefault == "true"
              ? Icon(
                  Icons.check_circle_outline_sharp,
                  color: kTxtColor,
                )
              : Icon(
                  Icons.fiber_manual_record_outlined,
                ),
          onPressed: () {},
        ),
        onTap: () {
          controller.updateSelectedPaymentMethod(paymentModel.cardNumber!);
        },
        selected: paymentModel.isDefault! == "true" ? true : false,
        selectedTileColor: Colors.indigo.shade50.withOpacity(0.5),
      ),
    );
  }
}
