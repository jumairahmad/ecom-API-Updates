import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ItemView extends StatelessWidget {
  ItemView({
    Key? key,
    this.image,
    this.name,
    this.singlePrice,
    this.totalPrice,
  }) : super(key: key);

  final String? image;
  final String? name;
  final String? singlePrice;
  final String? totalPrice;
  // final Entry? entry;
  // final OrderController? orderController;
  // final itemController = Get.put(SingleItemController());
  final List<String> items = ['Avalcaldo ', 'Hamburger etc'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 1.h,
        left: 2.w,
        right: 2.w,
      ),
      height: 18.h,
      width: 92.w,
      child: Card(
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Visibility(
            //   visible: image!.isNotEmpty,
            //   child: Image.network(
            //     image!,
            //     height: 12.h,
            //     width: 28.w,
            //   ),
            // ),
            Image.network(
              'http://dev.cronypos.com/images/place2.png',
              width: 25.w,
              height: 12.h,
            ),
            SizedBox(
              width: 2.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35.w,
                    child: Text(
                      name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: kTxtColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.4.w,
                  ),
                  SizedBox(
                    height: 0.4.w,
                  ),
                  Visibility(
                    visible: true,
                    child: Text(
                      "\$" + singlePrice!,
                      style: Theme.of(context).textTheme.bodySmall,
                      textScaleFactor: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                    width: 30.w,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                              visible: true,
                              child: Text(
                                'Ingrediants',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: kTxtColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Visibility(
                            visible: true,
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: items.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    items[index],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: kTxtColor,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    totalPrice!,
                    style: Theme.of(context).textTheme.titleMedium,
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
