import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class SpecialsSkeletonCard extends StatelessWidget {
  const SpecialsSkeletonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      width: 22.h,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Skeleton(
                  height: 4.h,
                  width: 4.h,
                ),
              ],
            ),
            Skeleton(
              height: 11.h,
              width: 11.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            Skeleton(
              height: 2.h,
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Skeleton(
                      height: 1.h,
                      width: 7.w,
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Skeleton(
                      height: 1.h,
                      width: 7.w,
                    ),
                  ],
                ),
                Spacer(),
                Skeleton(
                  height: 2.h,
                  width: 10.w,
                ),
              ],
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
