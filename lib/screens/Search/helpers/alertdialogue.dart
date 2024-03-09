// ignore_for_file: must_be_immutable

import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class AlertDialogcustom extends StatefulWidget {
  String dropdownValue = 'Chicken Fajita';
  AlertDialogcustom(this.dropdownValue, {Key? key}) : super(key: key);

  @override
  _AlertDialogcustomState createState() => _AlertDialogcustomState();
}

class _AlertDialogcustomState extends State<AlertDialogcustom> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //this right here
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w, bottom: 1.h),
        child: SizedBox(
          height: 48.h,
          child: Column(
            children: [
              SizedBox(
                width: 40.w,
                height: 5.h,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    side: BorderSide(color: Color(0xff284a6e), width: 0.5),
                  ),
                  child: Center(
                    child: Text(
                      'Customize Item',
                      style: TextStyle(
                        // fontFamily: 'Roboto',
                        fontSize: 14.sp,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w300,
                      ),
                      //textScaleFactor: 1.0,
                    ),
                  ),
                  color: const Color(0xff284a6e),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 1,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xff284a6e),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Chinese Pizza',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '13 inch large piza',
                            style: subTitleStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xff284a6e),
                        fontWeight: FontWeight.w300,
                      ),
                      //textScaleFactor: 1.0,
                    ),
                    Text(
                      '\$12.0',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Text(
                          'Pizza Flavors',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: kTxtColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: DropdownButton<String>(
                              underline: SizedBox(),
                              value: widget.dropdownValue,
                              icon: const Icon(Icons.arrow_downward_sharp),
                              iconSize: 2.2.h,
                              style: TextStyle(
                                color: Color(0xff284a6e),
                                fontSize: 12.sp,
                                fontFamily: 'Roboto',
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  widget.dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Chicken Fajita',
                                'Two',
                                'Free',
                                'Four'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(
                                    value,
                                    //textScaleFactor: 1.0,
                                  )),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  color: Color(0xffe1e6ff),
                ),
              ),
              SizedBox(
                height: 8.h,
                child: Card(
                  color: Color(0xffe1e6ff),
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Quantity',
                          style: TextStyle(
                            // fontFamily: 'Roboto',
                            fontSize: 13.sp,
                            color: const Color(0xff284a6e),
                          ),
                        ),
                      ),
                      Spacer(),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 1.w),
                      //   child: ItemQuantityWidget(),
                      // )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$36.0',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 4.5.h,
                    width: 30.w,
                    child: ElevatedButton(
                        child: Text(
                          "Cancel".toUpperCase(),
                          style: TextStyle(
                            //fontFamily: 'Roboto',
                            fontSize: 12.sp,
                            color: const Color(0xffffffff),
                          ),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffb72957)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side:
                                        BorderSide(color: Color(0xffb72957))))),
                        onPressed: () => Navigator.pop(context)),
                  ),
                  SizedBox(
                    height: 4.5.h,
                    width: 30.w,
                    child: ElevatedButton(
                      child: Text(
                        "Add to Cart".toUpperCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          //fontFamily: 'Roboto',
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                        // textScaleFactor: 1.0,
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xffe1e6ff)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xffe1e6ff)),
                          ))),
                      onPressed: () {
                        Get.toNamed(route.orderPage)!
                            .then((value) => Navigator.of(context).pop());
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
