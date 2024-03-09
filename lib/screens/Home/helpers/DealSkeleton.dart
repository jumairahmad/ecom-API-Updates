import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../constants.dart';

class DealSkeletonCard extends StatelessWidget {
  const DealSkeletonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.h,
      width: 72.w,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 1.5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 3.h,
                    width: 35.w,
                  ),
                  SizedBox(
                    height: 0.3.h,
                  ),
                  Skeleton(
                    height: 2.h,
                    width: 20.w,
                  ),
                  SizedBox(
                    height: 1.2.h,
                  ),
                  Skeleton(
                    height: 4.h,
                    width: 23.w,
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 2.w),
              child: Skeleton(
                height: 11.5.h,
                width: 15.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: kTxtColor.withOpacity(0.12),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
    );
  }
}
