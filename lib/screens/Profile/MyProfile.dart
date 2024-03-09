// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable

import 'package:csc_picker/csc_picker.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Profile/controller/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      void btnSave_onClick() {
        if (formKey.currentState!.validate()) {
          controller.btnSave_onClick(context);
          //controller.showToastCancel(context, 'There was an error !');
          // controller.btnController.error();
        } else {
          print("Not Validated");
        }
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getPageAppBar(context, "My Profile", () {
          Get.toNamed(route.homePage);
        }, () {
          Navigator.pop(context);
          FocusScope.of(context).requestFocus(FocusNode());
        }),
        body: controller.isDeviceConnected
            ? SizedBox(
                height: 100.h,
                width: 100.w,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 1.h),
                      ProfileAvatar(
                          getInitials(controller.user!.firstName! +
                              ' ' +
                              controller.user!.lastName!),
                          8.w,
                          14.sp),
                      //_shoppingCartBadge(),
                      SizedBox(height: 1.h),
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                            height: 70.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1)),
                            child: Form(
                              autovalidateMode: AutovalidateMode.disabled,
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 1.h),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                      lblText: 'First Name',
                                      txtController:
                                          controller.txtFNameController,
                                      validator: [
                                        MinLengthValidator(3,
                                            errorText:
                                                'name must be at least 3 digits long'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                      lblText: 'Last Name',
                                      txtController:
                                          controller.txtLNameController,
                                      validator: [
                                        MinLengthValidator(3,
                                            errorText:
                                                'name must be at least 3 digits long'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                      txtController:
                                          controller.txtPhoneController,
                                      lblText: 'Phone',
                                      keyboardType: TextInputType.phone,
                                      validator: [
                                        RequiredValidator(
                                            errorText: "* Required"),
                                        PatternValidator(
                                            r'(^(?:[+0]9)?[0-9]{10,12}$)',
                                            errorText:
                                                'Please enter valid mobile number')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                      lblText: 'Address',
                                      txtController:
                                          controller.txtAddressController,
                                      validator: [
                                        MinLengthValidator(8,
                                            errorText:
                                                'address must be at least 8 digits long'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                      lblText: 'Email',
                                      txtController:
                                          controller.txtEmailController,
                                      validator: [
                                        MinLengthValidator(4,
                                            errorText:
                                                'must be at least 4 digits long'),
                                        // EmailValidator(errorText: 'Enter correct email')
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5.h,
                                    child: TxtField(
                                        lblText: 'Zip',
                                        txtController:
                                            controller.txtZipController,
                                        validator: [
                                          MinLengthValidator(4,
                                              errorText:
                                                  'zip must be at least 4 digits long'),
                                        ],
                                        keyboardType: TextInputType.number),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                    child: DDL(),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  RoundedLoadingButton(
                                    child: Text('Save',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge),
                                    controller: controller.btnController,
                                    color: kPrimaryColor,
                                    onPressed: btnSave_onClick,
                                    animateOnTap: true,
                                    height: 5.h,
                                    width: 60.w,
                                    resetDuration: Duration(seconds: 1),
                                    resetAfterDuration: true,
                                    errorColor: kPrimaryColor,
                                    successColor: kTextColor,
                                  ),
                                  // PrimaryButton(
                                  //     'Save', 5.h, 50.w, btnSave_onClick, 16.sp),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            : NoInternetWiget(btnController, controller.btnReload_onClick),
      );
    });
  }
}

class DDL extends StatelessWidget {
  DDL({Key? key}) : super(key: key);
  GlobalKey<CSCPickerState> cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 0.5.h),
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
              border: Border.all(color: Colors.grey.shade300, width: 1)),

          currentCountry: 'United States',
          currentState: controller.user!.billingaddress!.stateName == ''
              ? 'State'
              : controller.user!.billingaddress?.stateName,
          currentCity: controller.user!.billingaddress?.city == ''
              ? 'City'
              : controller.user!.billingaddress?.city,

          disableCountry: true,

          selectedItemStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),

          dropdownHeadingStyle: Theme.of(context).textTheme.labelLarge,

          dropdownItemStyle: TextStyle(
            color: kTxtColor,
            fontSize: 14,
          ),

          dropdownDialogRadius: 10.0,

          searchBarRadius: 10.0,

          onCountryChanged: (value) {},

          onStateChanged: (value) {
            controller.user!.billingaddress!.stateName = value;
            controller.user!.billingaddress!.city = value;
            controller.update();
          },

          onCityChanged: (value) {
            controller.user!.billingaddress!.city = value;
            controller.update();
          },
        ),
      );
    });
  }
}
