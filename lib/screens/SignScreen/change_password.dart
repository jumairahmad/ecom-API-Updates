// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SignScreen/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final controller = Get.put(ConfirmPasswordController());
  @override
  Widget build(BuildContext context) {
    return SignLayout(
      pageTitle: 'Confirm Password',
      pageForm: ConfirmForm(),
      bottomWidget: Text(""),
      backgroundImage: ImageWidget(),
    );
  }
}

class ConfirmForm extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmPasswordController>(builder: (controller) {
      void btnUpdate_onClick() {
        if (formKey.currentState!.validate()) {
          controller.btnUpdate_onClick();
          FocusScope.of(context).requestFocus(FocusNode());
          print("Validated");
        } else {
          print("Not Validated");
        }
      }

      return controller.isDeviceConnected
          ? Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  TxtField(
                    txtController: controller.txtPassController,
                    lblText: 'Password',
                    obsecure: controller.obscureText,
                    suffix: InkWell(
                      onTap: controller.toggle,
                      child: Icon(
                        controller.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 100.w < 500 ? 10.sp : 8.sp,
                      ),
                    ),
                    validator: [
                      RequiredValidator(errorText: "* Required"),
                      // PatternValidator(
                      //     r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                      //     errorText:
                      //         'Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character')
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TxtField(
                    txtController: controller.txtConfirmPassController,
                    lblText: 'Confirm Password',
                    obsecure: controller.obscureTextConfirm,
                    suffix: InkWell(
                      onTap: controller.toggleConfirm,
                      child: Icon(
                        controller.obscureTextConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: [
                      RequiredValidator(errorText: "* Required"),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
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
                        'OTP expires in  0${time.min ?? 00} : ${time.sec}',
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Visibility(
                    visible: controller.codeEnabled,
                    child: RoundedLoadingButton(
                      child: Text('Update',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 100.w < 500 ? 16.sp : 13.sp)),
                      controller: controller.btnController,
                      color: kPrimaryColor,
                      onPressed: () {
                        btnUpdate_onClick();
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
                    child: PrimaryButton(
                        title: 'Resend',
                        height: 5.h,
                        width: 60.w,
                        callback: () {
                          Get.toNamed(route.forgotPasswordPage);
                        },
                        fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            )
          : NoInternetWiget(btnController, controller.btnReload_onClick);
    });
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 5.h,
      right: 80.w,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          child: Image.asset(
            'assets/icons/brger.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
