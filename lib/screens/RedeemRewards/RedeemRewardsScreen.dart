// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/RedeemRewards/controller/RedeemRewardController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import 'package:e_commerce/routes.dart' as route;

class RedeemRewardsScreen extends StatelessWidget {
  RedeemRewardsScreen({Key? key}) : super(key: key);
  final redeemRewardController = Get.put(ReedemRewardController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    const bodyColor = Color(0xfffaf1f1);
    const txtColor = Color(0xffbd345d);
    const txtLightColor = Color(0xffbf5a78);
    const primaryLightColor = Color(0xffffcadb);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    // Figma Flutter Generator LoyaltyscreenWidget - FRAME
    return GetBuilder<ReedemRewardController>(builder: (controller) {
      return Scaffold(
        backgroundColor: bodyColor,
        resizeToAvoidBottomInset: true,
        appBar: getPageAppBar(
            context,
            bottom > 100
                ? '\$' + controller.rewardBalance.toStringAsFixed(2)
                : 'Redeem Rewards', () {
          Get.toNamed(route.homePage);
        }, () {
          Navigator.of(context).pop();
        }, null, 16.sp),
        body: controller.isDeviceConnected
            ? SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: bottom > 100 ? 3.h : 15.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                            ),
                          ),
                          child: Visibility(
                            visible: bottom > 100 ? false : true,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '\$' +
                                      controller.rewardBalance
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: txtColor,
                                    fontSize: 40,
                                    //fontFamily: "Nunito",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "REWARD POINTS",
                                  style: TextStyle(
                                    color: txtLightColor,
                                    fontSize: 16,
                                    // fontFamily: "Nunito",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Select Redeem Amount",
                                  style: TextStyle(
                                    color: Color(0xff291e1e),
                                    fontSize: 15,
                                    //fontFamily: "Nunito",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                height: 7.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffffcadb).withOpacity(0.4),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      //physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.btnAmountList.length,
                                      itemBuilder: (context, index) {
                                        return BtnAmountCard(
                                            btnAmountModel: controller
                                                .btnAmountList[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              SizedBox(
                                width: 90.w,
                                height: 5.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 40.w,
                                        child: Divider(
                                          thickness: 2,
                                          color: primaryLightColor,
                                        )),
                                    Text(
                                      "Or",
                                      style: TextStyle(
                                        color: Color(0xff817d7d),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                      child: Divider(
                                        thickness: 2,
                                        color: primaryLightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                "Enter Redeem Amount",
                                style: TextStyle(
                                  color: Color(0xff291e1e),
                                  fontSize: 15,
                                  // fontFamily: "Nunito",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 88.w,
                                height: 10.h,
                                child: TextFormField(
                                  controller: controller.txtAmountController,
                                  onEditingComplete: () {
                                    controller.update();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                  ]),
                                  autofocus: false,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  minLines: 1,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          color: kPrimaryColor, width: 0.5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      borderSide: BorderSide(
                                          color: kTextGreyColor, width: 0.5),
                                    ),
                                    hintStyle: labelStyle,
                                    hintText: 'Amount',
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              PrimaryButton(
                                title: 'Redeem Now',
                                height: 5.5.h,
                                width: 82.w,
                                callback: () {
                                  if (formKey.currentState!.validate()) {
                                    if (double.parse(controller
                                            .txtAmountController.text) >
                                        controller.rewardBalance) {
                                      snackBar(
                                        'Can not exceed max amount',
                                        'Maximum Amount: \$' +
                                            controller.rewardBalance
                                                .toStringAsFixed(2),
                                      );
                                    }
                                    if (double.parse(controller
                                            .txtAmountController.text) <=
                                        0) {
                                      snackBar(
                                        'Minimum amount required',
                                        'Minimum Amount: \$1',
                                      );
                                    } else if (double.parse(controller
                                                .txtAmountController.text) <=
                                            controller.rewardBalance &&
                                        double.parse(controller
                                                .txtAmountController.text) >
                                            0) {
                                      _onAlertButtonsPressed(context);
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  } else {
                                    print('not validated');
                                  }
                                },
                                fontSize: 14.sp,
                                brRadius: 12,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text(
                                "Maximum redeemable amount : \$" +
                                    controller.rewardBalance.toStringAsFixed(2),
                                style: TextStyle(
                                  color: Color(0xff221c1c),
                                  fontSize: 14,
                                  //fontFamily: "Nunito",
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : NoInternetWiget(btnController, controller.btnReload_onClick),
        bottomNavigationBar: CustomBottomNav(),
      );
    });
  }

  var alertStyle = AlertStyle(
    //backgroundColor: kBodyColor.withOpacity(0.1),
    //alertPadding: EdgeInsets.only(top: 10.h),
    overlayColor: kBodyColor.withOpacity(0.8),
    animationType: AnimationType.fromRight,
    isCloseButton: true,
    isOverlayTapDismiss: true,
    descStyle: TextStyle(
      color: Color(0xffbd345d),
      fontSize: 14,
    ),
    alertElevation: 10,
    descTextAlign: TextAlign.center,
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    titleStyle: TextStyle(
      fontSize: 24,
      //fontFamily: "Nunito",
      fontWeight: FontWeight.w700,
    ),

    alertAlignment: Alignment.center,
  );
  // Alert with multiple and custom buttons
  _onAlertButtonsPressed(context) {
    final redeemRewardController = Get.put(ReedemRewardController());

    Alert(
      style: alertStyle,
      context: context,
      type: AlertType.info,
      title: "Generate Coupon",
      desc: "Please tap on a below button to create coupon",
      buttons: [
        DialogButton(
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              redeemRewardController.btnVoucher_onPressed(context);
            },
            color: kPrimaryColor),
        DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Color(0xffffcadb))
      ],
    ).show();
  }
}

class BtnAmountCard extends StatelessWidget {
  BtnAmountModel? btnAmountModel;

  BtnAmountCard({this.btnAmountModel});

  @override
  Widget build(BuildContext context) {
    final redeemRewardController = Get.put(ReedemRewardController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 3.h,
        width: 12.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: btnAmountModel!.isSelected == "true"
              ? Color(0xffbd345d)
              : Color(0xffffcadb),
        ),
        child: IconButton(
            onPressed: () {
              for (var element in redeemRewardController.btnAmountList) {
                element.isSelected = "false";
              }
              redeemRewardController.btnAmountList
                  .firstWhere((element) => element == btnAmountModel)
                  .isSelected = "true";
              redeemRewardController.txtAmountController.text =
                  btnAmountModel!.amount!;
              redeemRewardController.update();
            },
            icon: Text(
              '\$' + btnAmountModel!.amount!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                //fontFamily: "Nunito",
                fontWeight: FontWeight.w700,
              ),
            )),
      ),
    );
  }
}
