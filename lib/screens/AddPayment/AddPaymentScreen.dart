// ignore_for_file: non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class AddNewPayment extends StatelessWidget {
  const AddNewPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    btnClose_onPressed() {
      Get.toNamed(route.homePage);
    }

    return Scaffold(
      appBar: getPageAppBar(context, 'Payment', btnClose_onPressed, () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            Text(
              'Add Payment Method',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 3.h,
            ),
            ListTile(
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
            SizedBox(
              height: 3.h,
            ),
            // Text(
            //   'Saved Payment Methods',
            //   style: titleStyle,
            // ),
            // SizedBox(
            //   height: 2.h,
            // ),
            // ListTile(
            //   leading: Image.asset('assets/icons/Apple_Pay.png'),
            //   title: Text("Apple Pay"),
            //   trailing: Icon(Icons.done),
            // ),
            // SizedBox(
            //   height: 3.h,
            // ),
          ],
        ),
      ),
    );
  }
}
