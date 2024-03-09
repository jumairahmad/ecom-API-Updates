import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StoresCard extends StatelessWidget {
  final Locations brandLocation;

  const StoresCard({Key? key, required this.brandLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 17.h,
      width: 90.w,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${brandLocation.locationname}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Text(
                  '4.5km',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'My Address ${brandLocation.locationaddress!.address},${brandLocation.locationaddress!.city},${brandLocation.locationaddress!.state}',
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 9.sp,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  'open:',
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  'Closes at 11 pm',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                //Rounded,
                PrimaryButton(
                  title: 'Call Store',
                  width: 20.w,
                  height: 4.h,
                  callback: () {
                    // This need to be implemented on clicking the call button
                  },
                ),
              ],
            ),
            SizedBox(height: 1.h),
            // call button here
          ],
        ),
      ),
    );
  }
}
