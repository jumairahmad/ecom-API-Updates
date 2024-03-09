import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Rewards/constants/Constants.dart';
import 'package:e_commerce/screens/Rewards/controller/RewardController.dart';
import 'package:e_commerce/screens/Rewards/widgets/RewardsCircle.dart';
import 'package:e_commerce/screens/Rewards/widgets/ShowRewrdsData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../Coupons/controller/couponController.dart';
import '../RedeemRewards/controller/RedeemRewardController.dart';

class RewardsScreen extends StatelessWidget {
  RewardsScreen({Key? key}) : super(key: key);
  final rewardController = Get.put(RewardController());
  final redeemRewardController = Get.put(ReedemRewardController());
  final couponController = Get.put(CouponController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: getPageAppBar(
          context,
          'Rewards',
          () {
            Get.toNamed(route.homePage);
          },
          () {
            Navigator.of(context).pop();
          },
          null,
          null,
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                couponController.getData();
                Get.toNamed(route.couponPage);
              },
              child: Icon(
                Icons.history_outlined,
                color: kPrimaryColor,
                size: 100.w < 500 ? 25 : 50,
              ),
            ),
          ),
        ),
        body: GetBuilder<RewardController>(builder: (controller) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: controller.isDeviceConnected
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              'Your Balance ',
                              textAlign: TextAlign.left,
                              style: yourbalanceTitleTextStyle,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              '\$' +
                                  controller.rewardModel.balance!
                                      .toStringAsFixed(2),
                              textAlign: TextAlign.left,
                              style: balancevalueTextStyle,
                            ),

                            SizedBox(
                              height: 1.h,
                            ),
                            // Decorated Circle Circle
                            RewardsCircle(controller.chartData),

                            SizedBox(
                              height: 2.h,
                            ),

                            // returns widgets for showing data about balance

                            SizedBox(
                              width: 60.w,
                              child: Column(
                                children: [
                                  ShowRewardsData(
                                    circleColor: lightPinkcolor,
                                    price: '\$' +
                                        controller.rewardModel.redeemed!
                                            .toStringAsFixed(2),
                                    title: 'Redeemed',
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ShowRewardsData(
                                    circleColor: yellowcolor,
                                    price: '\$' +
                                        controller.rewardModel.earned!
                                            .toStringAsFixed(2),
                                    title: 'Earned',
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ShowRewardsData(
                                    circleColor: greencolor,
                                    price: '\$' +
                                        controller.rewardModel.balance!
                                            .toStringAsFixed(2),
                                    title: 'Balance',
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 6.h,
                            ),

                            // Button for redeem now

                            SizedBox(
                              height: 100.w < 500 ? 4.5.h : 4.h,
                              width: 75.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: mainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(borderRaius))),
                                ),
                                onPressed: () {
                                  couponController.getData();
                                  Get.toNamed(route.couponPage);
                                },
                                child: Text(
                                  'Redeem Now',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(254, 254, 254, 1),
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.fontSize,
                                    letterSpacing: 0.10000000149011612,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : NoInternetWiget(
                          btnController, controller.btnReload_onClick),
                );
        }));
  }
}
