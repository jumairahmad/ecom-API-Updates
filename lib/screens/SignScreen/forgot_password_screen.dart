// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SignScreen/layout.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final apiController = Get.put(ApiController());
  final forgotPasswordController = Get.put(ForgotPasswordController());
  final otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    return SignLayout(
      pageTitle: 'Forgot Password',
      pageForm: ForgotForm(forgotPasswordController),
      bottomWidget: Text(""),
      backgroundImage: ImageWidget(),
    );
  }
}

class ForgotForm extends StatelessWidget {
  ForgotPasswordController controller;
  ForgotForm(this.controller);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    void btnSubmit_onClick() {
      if (formKey.currentState!.validate()) {
        controller.btnSubmit();
        FocusScope.of(context).requestFocus(FocusNode());
      } else {}
    }

    return GetBuilder<ForgotPasswordController>(builder: (controller) {
      return controller.isDeviceConnected
          ? Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  TxtField(
                    txtController: controller.txtForgotPassController,
                    lblText: 'Phone',
                    keyboardType: TextInputType.phone,
                    validator: [
                      RequiredValidator(errorText: "* Required"),
                      // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
                      //     errorText: 'Please enter valid mobile number')
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  RoundedLoadingButton(
                    child: Text('Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize)),
                    controller: controller.btnController,
                    color: kPrimaryColor,
                    onPressed: () {
                      btnSubmit_onClick();
                    },
                    animateOnTap: true,
                    height: 5.h,
                    width: 60.w,
                    resetDuration: Duration(seconds: 2),
                    resetAfterDuration: true,
                    errorColor: kPrimaryColor,
                    successColor: kTextColor,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text("Check your phone and confirm \n verification code",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(
                    height: 4.h,
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
