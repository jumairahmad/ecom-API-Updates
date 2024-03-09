// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable

import 'package:csc_picker/csc_picker.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/SignScreen/layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'controlller/SignController.dart';
import 'package:e_commerce/routes.dart' as route;

import 'package:flip_card/flip_card.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final signUpController = Get.put(SignUpController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SignLayout(
      pageTitle: 'Sign up',
      pageForm: SignUpForm(),
      bottomWidget: BottomWidget(),
      backgroundImage: ImageWidget(),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final controller = Get.put(SignUpController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (controller) {
      return controller.isDeviceConnected
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                autovalidateMode: controller.signup_formValidation == false
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                          lblText: 'First Name',
                          txtController: controller.txtFNameController,
                          validator: [
                            MinLengthValidator(3,
                                errorText:
                                    'name must be at least 3 digits long'),
                          ]),
                    ),
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                          lblText: 'Last Name',
                          txtController: controller.txtLNameController,
                          validator: [
                            MinLengthValidator(3,
                                errorText:
                                    'name must be at least 3 digits long'),
                          ]),
                    ),
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                        txtController: controller.txtPhoneController,
                        lblText: 'Phone',
                        keyboardType: TextInputType.phone,
                        validator: [
                          RequiredValidator(errorText: "* Required"),
                          PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
                              errorText: 'Please enter valid mobile number')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                        txtController: controller.txtAddressController,
                        lblText: 'Address',
                        validator: [
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(6, errorText: 'Invalid address'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                        txtController: controller.txtPasswordController,
                        lblText: 'Password',
                        obsecure: controller.obscureText,
                        suffix: InkWell(
                          onTap: controller.toggle,
                          child: Icon(
                            controller.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: [
                          RequiredValidator(errorText: "* Required"),
                          MinLengthValidator(8,
                              errorText: 'Password must contain 8 characters'),
                          PatternValidator(
                              r'(^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$)',
                              errorText:
                                  'Must contain 1 number, 1 char, 1 capital')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                      child: TxtField(
                          lblText: 'Zip',
                          txtController: controller.txtZipController,
                          validator: [
                            MinLengthValidator(4,
                                errorText:
                                    'zip must be at least 4 digits long'),
                          ],
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(
                      height: 100.w < 500 ? 17.5.h : 13.h,
                      child: DDL(controller),
                    ),
                    RoundedLoadingButton(
                      child: Text('Sign up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.fontSize)),
                      controller: controller.btnController,
                      color: kPrimaryColor,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.signup_formValidation = true;
                          controller.update();
                          controller.btnSignUp_onClick();
                        } else {
                          print('invalid!');
                        }
                      },
                      animateOnTap: true,
                      height: 100.w < 500 ? 4.5.h : 3.5.h,
                      width: 60.w,
                      resetDuration: Duration(seconds: 3),
                      resetAfterDuration: true,
                      errorColor: kPrimaryColor,
                      successColor: kTextColor,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'By Login you agree to our  \n',
                            style: TextStyle(
                                color: kTextColor,
                                fontSize: 100.w < 500 ? 10.sp : 8.sp),
                          ),
                          TextSpan(
                            text: ' Privacy Policy ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 100.w < 500 ? 10.sp : 8.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tapped');
                              },
                          ),
                          TextSpan(
                            text: 'and',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 100.w < 500 ? 10.sp : 8.sp,
                            ),
                          ),
                          TextSpan(
                            text: ' Terms',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 100.w < 500 ? 10.sp : 8.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tapped');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : NoInternetWiget(btnController, controller.btnReload_onClick);
    });
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 92.h,
      left: 18.w,
      child: Row(
        children: [
          Text(
            "Already have an account ? ",
            style: TextStyle(
              fontSize: 100.w < 500 ? 11.sp : 8.sp,
              color: Color(0xFF284A6E).withOpacity(0.8),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(route.loginPage);
            },
            child: Text(
              'Sign in',
              style: TextStyle(
                fontSize: 100.w < 500 ? 12.sp : 9.sp,
                color: Color(0xFF284A6E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 3.h,
      right: 80.w,
      child: Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: 15.h,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(20 / 360),
            child: Image.asset(
              'assets/icons/pizza2.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class DDL extends StatelessWidget {
  SignUpController controller;
  DDL(this.controller);
  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
      child:

          ///Adding CSC Picker Widget in app
          CSCPicker(
        key: cscPickerKey,

        ///Enable disable state dropdown [OPTIONAL PARAMETER]
        showStates: true,

        /// Enable disable city drop down [OPTIONAL PARAMETER]
        showCities: true,

        ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
        flagState: CountryFlag.DISABLE,

        ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
        dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1)),

        ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey.shade300,
            border: Border.all(color: kTxtLightColor, width: 1)),

        currentCountry: 'United States',
        currentCity:
            controller.txtCity.text.isEmpty ? 'City' : controller.txtCity.text,
        currentState: controller.txtState.text.isEmpty
            ? 'State'
            : controller.txtState.text,

        disableCountry: true,

        selectedItemStyle: TextStyle(
          color: kTxtColor,
          fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
        ),

        dropdownHeadingStyle: Theme.of(context).textTheme.titleMedium,

        dropdownItemStyle: TextStyle(
          color: kTxtColor,
          fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
        ),

        dropdownDialogRadius: 10.0,

        searchBarRadius: 10.0,

        onCountryChanged: (value) {},

        onStateChanged: (value) {
          controller.txtState.text = value!;
          controller.update();
        },

        onCityChanged: (value) {
          if (value != null) {
            controller.txtCity.text = value;
          } else {
            //controller.txtCity.text = controller.txtState.text;
          }

          controller.update();
        },
      ),
    );
  }
}
