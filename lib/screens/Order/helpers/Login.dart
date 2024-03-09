// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/Order/models/PaymentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../../constants.dart';

class IfNotLoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void btnSignup_OnClick() {
      Get.toNamed(route.registerPage);
    }

    void btnLogin_OnClick() {
      Get.toNamed(route.loginPage);
    }

    //final controller =Get.put(OrderController());

    return SizedBox(
      height: 35.h,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 1.h),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Sign up or log in ',
              style: TextStyle(
                fontSize: 18.sp,
                color: kTxtColor,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            PrimaryButton(
                title: 'Log in',
                height: 5.h,
                width: 60.w,
                callback: btnLogin_OnClick,
                fontSize: 16.sp),
            SizedBox(
              height: 2.h,
            ),
            PrimaryButton(
                title: 'Sign up',
                height: 5.h,
                width: 60.w,
                callback: btnSignup_OnClick,
                fontSize: 16.sp),
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
    return SizedBox(
      height: 60,
      child: Card(
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
            "assets/icons/" +
                paymentModel.cardType!.replaceAll(' ', '_') +
                ".png",
            fit: BoxFit.scaleDown,
            width: 12.w,
          ),
          title: Text(
            paymentModel.cardType!,
            style: TextStyle(
              fontSize: 14.sp,
              color:
                  paymentModel.isDefault == "true" ? kTxtColor : kTextGreyColor,
            ),
          ),
          subtitle: Text(
            paymentModel.cardNumber!,
            style: subTitleStyle,
          ),
          trailing: IconButton(
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
      ),
    );
  }
}
