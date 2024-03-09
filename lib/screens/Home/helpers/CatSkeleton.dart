import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class CatSkeletonCard extends StatelessWidget {
  const CatSkeletonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeleton(
          height: 12.h,
          width: 50.w,
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Skeleton(
          height: 1.h,
          width: 25.w,
        ),
      ],
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
