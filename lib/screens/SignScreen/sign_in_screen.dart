// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:e_commerce/screens/SignScreen/layout.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../constants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return SignLayout(
      pageTitle: 'Sign in',
      pageForm: SignInForm(signInController),
      bottomWidget: BottomWidget(),
      backgroundImage: ImageWidget(),
    );
  }
}

class ImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 3.h,
      right: 75.w,
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

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 92.h,
      left: 21.w,
      child: Row(
        children: [
          Text("Don't have an account ? ",
              style: Theme.of(context).textTheme.labelLarge),
          TextButton(
            onPressed: () {
              Get.toNamed(route.registerPage);
            },
            child: Text(
              'Sign up',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  SignInController controller;
  SignInForm(this.controller);
  final apiController = Get.put(ApiController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (controller) {
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
                    txtController: controller.userNameController,
                    lblText: 'Phone',
                    keyboardType: TextInputType.phone,
                    validator: [
                      RequiredValidator(errorText: "* Required"),
                      // PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
                      //     errorText: 'Please enter valid mobile number')
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TxtField(
                    txtController: controller.passwordController,
                    lblText: 'Password',
                    obsecure: controller.obscureText,
                    suffix: InkWell(
                      onTap: controller.toggle,
                      child: Icon(
                        controller.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 100.w < 500 ? 5.w : 6.w,
                      ),
                    ),
                    validator: [
                      RequiredValidator(errorText: "* Required"),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(route.forgotPasswordPage);
                        },
                        child: Text("Forgot Password ?",
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ],
                  ),
                  RoundedLoadingButton(
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize)),
                    controller: controller.btnController,
                    color: kPrimaryColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        controller.userLogin();
                        FocusScope.of(context).requestFocus(FocusNode());
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (controller.logged) {
                          prefs.setString(
                              'phone', controller.userNameController.text);
                          prefs.setString(
                              'pass', controller.passwordController.text);
                          prefs.setBool('logged', true);
                        }
                      } else {}

                      controller.update();
                    },
                    animateOnTap: true,
                    height: 100.w < 500 ? 4.5.h : 4.h,
                    width: 60.w,
                    resetDuration: Duration(seconds: 3),
                    resetAfterDuration: true,
                    errorColor: kPrimaryColor,
                    successColor: kTextColor,
                  ),
                  SizedBox(
                    height: 100.w < 500 ? 4.h : 8.h,
                  ),
                ],
              ),
            )
          : NoInternetWiget(btnController, controller.btnReload_onClick);
    });
  }
}
