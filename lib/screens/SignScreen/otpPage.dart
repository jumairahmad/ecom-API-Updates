// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

import '../../WebHook/Controller/ApiController.dart';
import 'layout.dart';

class OtpPage extends StatelessWidget {
  final otpController = Get.put(OtpController());
  final apiController = Get.put(ApiController());
  final forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SignLayout(
      pageTitle: 'Verification',
      pageForm: OtpForm(),
      bottomWidget: BottomWidget(),
      backgroundImage: ImageWidget(),
    );
  }
}

class OtpForm extends StatelessWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (controller) {
      return Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "Enter your OTP code number",
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 2.2.h,
          ),
          Container(
            // padding: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OTPWidget(true, false, controller.txtFirst),
                    OTPWidget(false, false, controller.txtSecond),
                    OTPWidget(false, false, controller.txtThird),
                    OTPWidget(false, true, controller.txtFourth),
                  ],
                ),
                CountdownTimer(
                  controller: controller.countdownController,
                  widgetBuilder: (_, time) {
                    if (time == null) {
                      return Text(
                        'Please resend code again',
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    }
                    return Text(
                      'OTP expires in  0${time.min ?? 00} : ${time.sec} \n \n dummy code is : ' +
                          controller.otpModel.otp!,
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  },
                ),
                SizedBox(
                  height: 22,
                ),
                Visibility(
                  visible: controller.codeEnabled,
                  child: RoundedLoadingButton(
                    child: Text('Verify',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize)),
                    controller: controller.btnController,
                    color: kPrimaryColor,
                    onPressed: () {
                      controller.btnVerify_onClick();
                    },
                    animateOnTap: true,
                    height: 5.h,
                    width: 60.w,
                    resetDuration: Duration(seconds: 2),
                    resetAfterDuration: true,
                    errorColor: kPrimaryColor,
                    successColor: kTextColor,
                  ),
                ),
                Visibility(
                  visible: !controller.codeEnabled,
                  child: RoundedLoadingButton(
                    child: Text('Resend',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize)),
                    controller: controller.btnController,
                    color: kPrimaryColor,
                    onPressed: () {
                      Get.toNamed(route.forgotPasswordPage);
                    },
                    animateOnTap: true,
                    height: 100.w < 500 ? 4.5.h : 4.h,
                    width: 60.w,
                    resetDuration: Duration(seconds: 2),
                    resetAfterDuration: true,
                    errorColor: kPrimaryColor,
                    successColor: kTextColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100.w < 500 ? 18 : 5.h,
          ),
        ],
      );
    });
  }
}

class OTPWidget extends StatelessWidget {
  bool first;
  final last;

  TextEditingController? txtController;

  OTPWidget(this.first, this.last, this.txtController);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.w < 500 ? 85 : 9.h,
      child: AspectRatio(
        aspectRatio: 100.w < 500 ? 0.8 : 1.2,
        child: TextField(
          controller: txtController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 100.w < 500 ? 24 : 40, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: kPrimaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 60,
      right: 250,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          child: Image.asset(
            'assets/icons/fries.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.h,
      left: 100.w < 500 ? 5.w : 18.w,
      child: Row(
        children: [
          Text("Didn't you receive any code?",
              style: Theme.of(context).textTheme.labelLarge),
          TextButton(
            onPressed: () {
              Get.toNamed(route.forgotPasswordPage);
            },
            child: Text("Resend Code",
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ],
      ),
    );
  }
}
