import 'package:e_commerce/screens/Rewards/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShowRewardsData extends StatelessWidget {
  const ShowRewardsData(
      {Key? key,
      required this.circleColor,
      required this.price,
      required this.title})
      : super(key: key);
  final Color circleColor;
  final String price;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 2.h,
          width: 2.h,
          //  color: Colors.black,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 1.h,
        ),
        Text(
          title,
          style: detailsTitlesTextStyle,
        ),
        Spacer(),
        // SizedBox(
        //   width: 20.w,
        // ),
        Text(
          price,
          style: detailsValuesTextStyle,
        ),
      ],
    );
  }
}
