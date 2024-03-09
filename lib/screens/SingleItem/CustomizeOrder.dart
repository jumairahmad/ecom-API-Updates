// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/SingleItem/controller/SingleItemController.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';

class CustomizeOrder1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context,
        "Customize Order",
        () {},
        () {},
      ),
      body: SizedBox(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 6.w, right: 6.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ingrediants",
                        style: TextStyle(
                            color: kTxtColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp),
                      ),
                      Text(
                        'price',
                        style: TextStyle(
                          //fontFamily: 'Roboto',
                          fontSize: 16.sp,
                          color: kTxtColor,
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  child: SizedBox(
                    height: 20.h,
                    width: 100.w,
                    child:
                        GetBuilder<SingleItemController>(builder: (controller) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller
                              .ingrList
                              //.where((element) => int.parse(element.maxItemSelection!) >1)
                              .length,
                          itemBuilder: (BuildContext ctxt, int i) {
                            return IngAvatar(controller.ingrList[i]);
                          });
                    }),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child:
                      GetBuilder<SingleItemController>(builder: (controller) {
                    return DefaultTabController(
                        length: controller.ingrList.length,
                        child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              toolbarHeight: 0,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              bottom: TabBar(
                                labelColor: kTextGreyColor,
                                unselectedLabelColor: kTextGreyColor,
                                isScrollable: true,
                                tabs: List<Widget>.generate(
                                    controller.ingrList.length, (int index) {
                                  return Tab(
                                      // icon: Icon(Icons.directions_car),
                                      text:
                                          controller.ingrList[index].headText);
                                }),
                              ),
                            ),
                            body: TabBarView(
                              children: List<Widget>.generate(
                                  controller.ingrList.length, (int index) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller
                                        .ingrList[index].items!.length,
                                    itemBuilder: (BuildContext ctxt, int i) {
                                      return IngredientsSubItem(
                                          controller.ingrList[index].items![i]);
                                    });
                              }),
                            )));
                  }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IngredientsSubItem extends StatelessWidget {
  IngredientItem? item;

  IngredientsSubItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
      child: SizedBox(
        height: 8.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 10.w,
              backgroundColor: kTxtColor.withOpacity(0.1),
              child: CircleAvatar(
                radius: 10.w,
                backgroundImage: NetworkImage(
                  item!.image!,
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item!.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  item!.price!,
                  style: subTitleStyle,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: ItemQuantityWidget(
                  Text(
                    '1',
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  () {},
                  () {}),
            )
          ],
        ),
      ),
    );
  }
}

class IngAvatar extends StatelessWidget {
  IngredientModel? ingModel;
  IngAvatar(this.ingModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          CircleAvatar(
            radius: 10.w,
            backgroundColor: kTxtColor.withOpacity(0.1),
            child: CircleAvatar(
              radius: 10.w,
              backgroundImage: NetworkImage(
                ingModel!.image!,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          Text(
            ingModel!.headText!,
            style: subTitleStyle,
          )
        ],
      ),
    );
  }
}
