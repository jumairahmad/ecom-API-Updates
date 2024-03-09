import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/LoyaltyHistory/constants/constants.dart';
import 'package:e_commerce/screens/LoyaltyHistory/widgets/LoyaltyHistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'controller/LoyaltyHistorycontroller.dart';
import 'package:e_commerce/routes.dart' as route;

class LoyaltyHistoryScreen extends StatelessWidget {
  LoyaltyHistoryScreen({Key? key}) : super(key: key);
  final loyaltyHistoryController = Get.put(LoyaltyHistoryController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction <= 0) {
          //Navigator.pop(context);
          print('object');
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: getPageAppBar(context, 'History', () {
            Get.toNamed(route.homePage);
          }, () {
            Navigator.of(context).pop();
          }, null),
          body: GetBuilder<LoyaltyHistoryController>(builder: (controller) {
            return controller.isLoading && controller.isDeviceConnected == true
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 5.w, right: 5.w, top: 4.w, bottom: 2.w),
                          child: Container(
                            height: 5.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(3.5.w),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                    offset: Offset(0, 0),
                                    blurRadius: 2)
                              ],
                              color: tabbackgroundcolor,
                            ),
                            child: TabBar(
                                //padding: EdgeInsets.all(2.h),
                                unselectedLabelColor: mainColor,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3.w),
                                  ),
                                  color: Color.fromRGBO(189, 52, 93, 1),
                                ),
                                labelStyle: tabbarsTitleTextStyle,
                                tabs: const [
                                  Tab(
                                    text: 'Earned',
                                  ),
                                  Tab(
                                    text: 'Redeemed',
                                  ),
                                ]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(1.0.h),
                            child: controller.isDeviceConnected
                                ? TabBarView(
                                    children: [
                                      GetBuilder<LoyaltyHistoryController>(
                                          builder: (controller) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(2.w),
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller
                                              .loyaltyHistoryModel
                                              .earnedHistoryList!
                                              .length,
                                          itemBuilder: (context, index) {
                                            return LoyaltyHistoryDetailCard(
                                              earnedHistoryList: controller
                                                  .loyaltyHistoryModel
                                                  .earnedHistoryList![index],
                                            );
                                          },
                                        );
                                      }),
                                      //////// second Tabbar Data
                                      ///
                                      GetBuilder<LoyaltyHistoryController>(
                                          builder: (controller) {
                                        return ListView.builder(
                                            padding: EdgeInsets.all(2.w),
                                            itemCount: controller
                                                .loyaltyHistoryModel
                                                .redeemedHistoryList!
                                                .length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return LoyaltyHistoryDetailCardRedeemed(
                                                redeemedHistoryList: controller
                                                        .loyaltyHistoryModel
                                                        .redeemedHistoryList![
                                                    index],
                                              );
                                            });
                                      })
                                    ],
                                  )
                                : NoInternetWiget(btnController,
                                    controller.btnReload_onClick),
                          ),
                        )
                      ],
                    ),
                  );
          }),
          //bottomNavigationBar: CustomBottomNav(),
        ),
      ),
    );
  }
}
