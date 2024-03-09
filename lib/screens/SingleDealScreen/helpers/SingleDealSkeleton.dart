import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class SingleDealSkeleton extends StatelessWidget {
  const SingleDealSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 13.h,
        width: 75.w,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child:
              // Shimmer.fromColors(
              //   baseColor: kTxtColor,
              //   highlightColor: kTxtColor.withOpacity(0.5),
              //   child:
              Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Skeleton(
                    height: 10.h,
                    width: 22.w,
                  )),
              SizedBox(
                width: 1.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Skeleton(
                      height: 2.h,
                      width: 25.w,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Skeleton(
                      height: 2.h,
                      width: 10.w,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Skeleton(
                      height: 2.h,
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h, right: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Skeleton(
                      height: 3.5.h,
                      width: 3.5.h,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Skeleton(
                      height: 3.5.h,
                      width: 3.5.h,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Skeleton(
                      height: 3.5.h,
                      width: 3.5.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ),
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
