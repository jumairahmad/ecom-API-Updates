// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Address/Controller/AddressController.dart';
import 'package:e_commerce/screens/LoyaltyHistory/controller/LoyaltyHistorycontroller.dart';
import 'package:e_commerce/screens/OrderHistory/controller/OrderHistoryController.dart';
import 'package:e_commerce/screens/Profile/controller/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../Notification/controller/NotificationController.dart';
import '../Rewards/controller/RewardController.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());
  final loyaltyController = Get.put(LoyaltyHistoryController());
  final orderHistoryController = Get.put(OrderHistoryController());
  final addressListController = Get.put(AddressListController());
  final rewardController = Get.put(RewardController());
  final notificationController = Get.put(NotificationController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        appBar: getPageAppBar(context, "Profile", () {
          Get.toNamed(route.homePage);
        }, () {
          Navigator.pop(context);
        }),
        body: controller.isDeviceConnected
            ? Center(
                child: controller.user != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          ProfileAvatar(
                              getInitials(controller.user!.firstName! +
                                  ' ' +
                                  controller.user!.lastName!),
                              100.w < 500 ? 9.w : 7.w,
                              16.sp),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            controller.user!.firstName! +
                                ' ' +
                                controller.user!.lastName!,
                            style: TextStyle(
                              color: kTxtColor,
                              fontSize: 100.w < 500 ? 12.sp : 10.sp,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            controller.user!.userPhone!,
                            style: TextStyle(
                                color: kTxtColor,
                                fontSize: 100.w < 500 ? 11.sp : 9.sp,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: 5,
                            shadowColor: kTxtLightColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 80.w,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  getButtonWidget(
                                    context,
                                    "My Profile",
                                    Icons.person_outline,
                                    enabledBorder,
                                    () {
                                      Get.toNamed(route.myProfilePage);
                                    },
                                  ),
                                  getButtonWidget(
                                    context,
                                    "Addresses",
                                    Icons.pin_drop_outlined,
                                    enabledBorder,
                                    () {
                                      addressListController
                                          .getAddressList(true);
                                      Get.toNamed(route.addressListPage);
                                    },
                                  ),
                                  getButtonWidget(
                                    context,
                                    "My Orders",
                                    Icons.list_alt_outlined,
                                    enabledBorder,
                                    () {
                                      orderHistoryController
                                          .getOrderHistoryData(true);
                                      orderHistoryController.update();
                                      Get.toNamed(route.orderHistoryPage);
                                    },
                                  ),
                                  getButtonWidget(
                                    context,
                                    "My Rewards",
                                    Icons.notifications_outlined,
                                    enabledBorder,
                                    () {
                                      rewardController.getRewardDetails();
                                      rewardController.update();
                                      Get.toNamed(route.rewardsPage);
                                    },
                                  ),
                                  getButtonWidget(
                                    context,
                                    "Rewards History",
                                    Icons.history_outlined,
                                    enabledBorder,
                                    () {
                                      loyaltyController.getRewardDetails();
                                      loyaltyController.update();

                                      Get.toNamed(route.loyaltyHistoryPage);
                                    },
                                  ),
                                  getButtonWidget(
                                    context,
                                    "Notifications",
                                    Icons.notifications_outlined,
                                    enabledBorder,
                                    () {
                                      notificationController.getNotifications();
                                      Get.toNamed(route.notificationPage);
                                    },
                                  ),
                                  // getButtonWidget(
                                  //   "About App",
                                  //   Icons.info_outline,
                                  //   null,
                                  //   () {},
                                  // ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  getButtonWidget(
                                    context,
                                    "Logout",
                                    Icons.login_outlined,
                                    null,
                                    () async {
                                      controller.btnLogout_onClick();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              )
            : NoInternetWiget(btnController, controller.btnReload_onClick),
      );
    });
  }

  Widget getButtonWidget(BuildContext context, String title, IconData iconData,
      ShapeBorder? shape, Function()? myFunc) {
    return SizedBox(
      height: 100.w < 500 ? 6.5.h : 6.h,
      child: Card(
          margin: EdgeInsets.only(top: 100.w < 500 ? 0.8.h : 1.1.h),
          elevation: 0,
          child: ListTile(
            dense: true,
            shape: shape,
            leading: Icon(
              iconData,
              color: kTxtColor,
              size: 100.w < 500 ? 16.sp : 11.sp,
            ),
            title: Text(title, style: Theme.of(context).textTheme.labelLarge),
            trailing: RotatedBox(
              quarterTurns: 3,
              child: Icon(
                Icons.expand_more_outlined,
                color: kTxtColor,
                size: 100.w < 500 ? 16.sp : 10.sp,
              ),
            ),
            onTap: myFunc,
          )),
    );
  }
}
