// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:e_commerce/screens/LoyaltyHistory/constants/constants.dart';
import 'package:e_commerce/screens/LoyaltyHistory/model/LoyaltyHistorymodel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoyaltyHistoryDetailCard extends StatelessWidget {
  EarnedHistoryList? earnedHistoryList;

  LoyaltyHistoryDetailCard({this.earnedHistoryList});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 6.w,
          ),
          Text('\$' + earnedHistoryList!.couponAmount!.toStringAsFixed(2),
              style: priceValueTextStyle),
          SizedBox(
            width: 8.w,
          ),
          Padding(
            padding: EdgeInsets.all(1.5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  earnedHistoryList!.storeName!,
                  style: titleHistoryDetailTextStyle,
                ),

                Text(
                  earnedHistoryList!.couponCode!,
                  style: subTitleHistoryDetailsTextStyle,
                ),
                // SizedBox(
                //   height: 0.01.h,
                // ),
                Row(
                  children: [
                    Text(
                      earnedHistoryList!.expireDate!,
                      style: subTitleHistoryDetailsTextStyle,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      earnedHistoryList!.expireTime!,
                      style: subTitleHistoryDetailsTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoyaltyHistoryDetailCardRedeemed extends StatelessWidget {
  RedeemedHistoryList? redeemedHistoryList;

  LoyaltyHistoryDetailCardRedeemed({this.redeemedHistoryList});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 6.w,
          ),
          Text('\$' + redeemedHistoryList!.couponAmount!.toStringAsFixed(2),
              style: priceValueTextStyle),
          SizedBox(
            width: 8.w,
          ),
          Padding(
            padding: EdgeInsets.all(1.5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  redeemedHistoryList!.storeName!,
                  style: titleHistoryDetailTextStyle,
                ),
                // SizedBox(
                //   height: 0.01.h,
                // ),
                Text(
                  redeemedHistoryList!.couponCode!,
                  style: subTitleHistoryDetailsTextStyle,
                ),
                // SizedBox(
                //   height: 0.01.h,
                // ),
                Row(
                  children: [
                    Text(
                      redeemedHistoryList!.usedDate!,
                      style: subTitleHistoryDetailsTextStyle,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      redeemedHistoryList!.usedTime!,
                      style: subTitleHistoryDetailsTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
