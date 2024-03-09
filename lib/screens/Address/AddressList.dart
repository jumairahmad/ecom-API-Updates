// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Address/Model/AddressModel.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:sizer/sizer.dart';

import 'Controller/AddressController.dart';

class AddressList extends StatelessWidget {
  final addressListController = Get.put(AddressListController());
  final refreshController = RefreshController(initialRefresh: false);
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    void onRefresh() {
      addressListController.onRefresh();
      refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: getPageAppBar(context, 'Address', () {
        Get.toNamed(route.homePage);
      }, () {
        Navigator.of(context).pop();
      }),
      body: GetBuilder<AddressListController>(builder: (controller) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SmartRefresher(
                physics: ScrollPhysics(),
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                controller: refreshController,
                onRefresh: onRefresh,
                child: controller.isDeviceConnected
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.addressList!.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: AddressCard(
                                controller,
                                controller.addressList![index],
                                Icons.apartment_outlined),
                          );
                        },
                      )
                    : NoInternetWiget(
                        btnController, controller.btnReload_onClick),
              );
      }),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: 4.h, top: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              height: 5.5.h,
              width: 85.w,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text('Add New Address',
                    style: Theme.of(context).textTheme.headlineLarge),
                onPressed: () {
                  addressListController.btnAddNew_onPressed();
                  Get.toNamed(route.newAddressPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  AddressModel address;
  AddressListController? addressListController;
  IconData? icon;
  AddressCard(this.addressListController, this.address, this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 0.5.h),
        child: Container(
          height: 18.6.h,
          width: 95.w,
          decoration: BoxDecoration(
              border: Border.all(
                color: address.isDefault == true
                    ? kPrimaryColor
                    : Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(borderRaius))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 5.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 0),
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: address.isDefault == true
                                        ? kPrimaryColor
                                        : kTxtColor,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  icon,
                                  color: kIconColor,
                                  size: 100.w < 500 ? 5.5.w : 5.w,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          address.label!,
                          style: TextStyle(
                              color: address.isDefault == true
                                  ? kPrimaryColor
                                  : kTxtColor,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          addressListController!.btnEdit_onPressed(address);
                          Get.toNamed(route.newAddressPage);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: kPrimaryColor,
                          size: 100.w < 500 ? 5.w : 3.5.w,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 6.h,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    right: 8,
                  ),
                  child: Text(
                    address.address!,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: 7.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: address.isDefault! ? 66.8.w : 50.w,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.h, left: 3.w),
                        child: Text(
                          address.contactNo!,
                          style:
                              TextStyle(fontSize: 100.w < 500 ? 12.sp : 9.sp),
                        ),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible: address.isDefault!,
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.h, left: 3.w),
                        child: DefaultButton(() {}),
                      ),
                    ),
                    Visibility(
                      visible: !address.isDefault!,
                      child: Padding(
                        padding: EdgeInsets.only(top: 3.h, left: 3.w),
                        child: SetDefaultButton(() {
                          addressListController!
                              .btnSetAsDefault_onPressed(true, address.id!);
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  DefaultButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRaius),
                  bottomRight: Radius.circular(8)),
              side: BorderSide(color: Colors.pink.shade900, width: 0.5),
            )),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
        onPressed: onPressed,
        child: Text(
          "Default",
          style: TextStyle(
              color: Colors.white, fontSize: 100.w < 500 ? 10.sp : 9.5.sp),
        ),
      ),
    );
  }
}

class SetDefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  SetDefaultButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRaius),
                  bottomRight: Radius.circular(8)),
              side: BorderSide(color: Colors.pink.shade900, width: 0.5),
            )),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
        onPressed: onPressed,
        child: Text(
          "Set as default",
          style: TextStyle(
              color: kTxtColor, fontSize: 100.w < 500 ? 10.sp : 9.5.sp),
        ),
      ),
    );
  }
}
