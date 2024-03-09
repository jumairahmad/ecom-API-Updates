import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class DealView extends StatelessWidget {
  DealView({
    Key? key,
    this.image,
    this.dealname,
    this.price,
    this.finalprice,
  }) : super(key: key);

  final String? image;
  final String? dealname;
  final String? price;
  final String? finalprice;
  final List<String> items = ['Avalcaldo ', 'Hamburger etc'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h, left: 2.w, right: 2.w),
      height: 18.h,
      width: 90.w,
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
            //   visible: false,
            //   child: Image.network(
            //     image!,
            //     height: 12.h,
            //     width: 25.w,
            //   ),
            // ),
            Image.network(
              'http://dev.cronypos.com/images/items/785654161108.png',
              width: 25.w,
              height: 12.h,
            ),
            SizedBox(
              width: 0.5.w,
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 45.w,
                    child: Text(
                      dealname!,
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
                    height: 0.8.h,
                  ),
                  Text(
                    'Items',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: kTxtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 6.5.h,
                    width: 35.w,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            "( "
                                    '1'
                                    " ) " +
                                items[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: kTxtColor,
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: SizedBox(
                    //width: .w,
                    height: 3.2.h,
                    child: Row(
                      children: [
                        Card(
                          elevation: 0,
                          child: Center(
                            child: Text(
                              'Deal',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  '\$' + price!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textScaleFactor: 1.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
