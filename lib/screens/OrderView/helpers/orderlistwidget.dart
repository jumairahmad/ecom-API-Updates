// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:e_commerce/screens/OrderView/constants/constantsorderview.dart';
import 'package:sizer/sizer.dart';

class OrdersListWidget extends StatelessWidget {
  String? image_name;
  String? item_name;
  String? item_size;
  String? single_item_price;

  OrdersListWidget(
      this.image_name, this.item_name, this.item_size, this.single_item_price,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      decoration: BoxDecoration(
        //color: Colors.white,

        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),

        boxShadow: [
          //background color of box
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03),
              child: Card(
                shadowColor: Colors.black,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Image.asset(
                  //image_name!,
                  "assets/images/avatar.png",
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.height * 0.07,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item_name!,
                    style: kOrderViewItemNameTitleTextStyle,
                    textScaleFactor: 1.0,
                  ),
                  Visibility(
                      visible: item_size == null ? false : true,
                      child: Text(
                        '$item_size ',
                        style: kOrderViewItemSizeValueTextStyle,
                        textScaleFactor: 1.0,
                      )),
                  Text(
                    '\$$single_item_price',
                    style: kOrderViewItemPriceValueTextStyle,
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
            Spacer(),
            // Padding(
            //   padding: EdgeInsets.only(right: 20.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Q | $quantity',
            //         style: kOrderViewQunatitiyTextStyle,
            //         textScaleFactor: 1.0,
            //       ),
            //       Text(
            //         '\$$totalprice',
            //         style: kOrderViewItemquantityPriceTextStyle,
            //         textScaleFactor: 1.0,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
