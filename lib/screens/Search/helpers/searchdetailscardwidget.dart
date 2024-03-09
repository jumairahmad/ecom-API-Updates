// ignore_for_file: must_be_immutable, unused_element, non_constant_identifier_names

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class SearchDetailsCardWidget extends StatelessWidget {
  late ItemModel item;
  final singleItemController = Get.put(SingleItemController());
  late int index;

  SearchDetailsCardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void btnAdd_onPressed() {
      singleItemController.itemModel = item;

      singleItemController.getData();
      singleItemController.update();

      Get.toNamed(route.singleItemPage);
    }

    return SizedBox(
      height: 14.h,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.only(left: 2.w),
              shadowColor: Colors.grey.withOpacity(0.5),
              clipBehavior: Clip.antiAlias,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRaius),
                  borderSide: BorderSide(color: kTxtLightColor)),
              child: Image.network(
                item.image!,
                fit: BoxFit.contain,
                height: 10.h,
                width: 22.w,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            SizedBox(
              width: 48.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name!,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(
                    height: 0.4.h,
                  ),
                  Text(
                    item.size!,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: 0.4.h,
                  ),
                  SizedBox(
                    width: 30.w,
                    child: Row(
                      children: [
                        Text(
                          "\$" +
                              double.parse(item.regularprice!)
                                  .toStringAsFixed(2),
                          style: TextStyle(
                            decoration: item.onspecial! == "true"
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: Colors.grey,
                            fontSize: item.onspecial! == "true"
                                ? 100.w < 500
                                    ? 8.5.sp
                                    : 6.5.sp
                                : Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Visibility(
                          visible: item.onspecial! == "true" ? true : false,
                          child: Text(
                            "\$" +
                                double.parse(item.specialprice!)
                                    .toStringAsFixed(2),
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.fontSize,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 9.5.h),
              child: AddButton(btnAdd_onPressed),
            ),
          ],
        ),
      ),
    );
  }
}
