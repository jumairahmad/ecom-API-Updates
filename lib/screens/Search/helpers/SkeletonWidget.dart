import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../constants.dart';

class SearchSkeletonCard extends StatelessWidget {
  const SearchSkeletonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 14.h,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Shimmer.fromColors(
            baseColor: kTxtColor,
            highlightColor: kTxtColor.withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Skeleton(
                    height: 10.h,
                    width: 22.w,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Skeleton(
                          height: 3.h,
                          width: 50.w,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Skeleton(
                          height: 3.h,
                          width: 20.w,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.090),
                    child: Skeleton(
                      height: 3.h,
                      width: 13.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
