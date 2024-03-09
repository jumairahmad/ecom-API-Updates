// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:e_commerce/screens/Address/Controller/AddressController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:sizer/sizer.dart';

import '../../constants.dart';

class SaveAddress extends StatelessWidget {
  final saveAddressController = Get.put(SaveAddressController());
  final addressListController = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    void btnSaveAddress_onPressed() {
      if (formKey.currentState!.validate()) {
        saveAddressController.saveAddress();
        FocusScope.of(context).requestFocus(FocusNode());
      } else {}
    }

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: SizedBox(
          width: 100.w < 500 ? 11.w : 12.w,
          height: 100.w < 500 ? 6.h : 5.h,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.close,
              color: kPrimaryColor,
              size: 100.w < 500 ? 6.w : 4.w,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            saveAddressController.isEditable = false;
            saveAddressController.address =
                saveAddressController.txtAddressController.text;
            saveAddressController.update();
          },
          child: SingleChildScrollView(
            child: GetBuilder<SaveAddressController>(builder: (controller) {
              return Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                      child: CustomMapPickup(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Text('Add a new address',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.5.w),
                      child: SizedBox(
                        height: 15.h,
                        width: 92.w,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Visibility(
                                  visible: !controller.isEditable,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.pin_drop_outlined,
                                          color: kPrimaryColor,
                                          size: 100.w < 500 ? 6.w : 4.w),
                                      SizedBox(
                                        width: 62.w,
                                        height: 9.h,
                                        child: Text(controller.address,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall),
                                      ),
                                      IconButton(
                                          onPressed: controller
                                              .btnEditAddress_onPressed,
                                          icon: Icon(Icons.edit_outlined,
                                              color: kPrimaryColor,
                                              size: 100.w < 500 ? 6.w : 4.w))
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: controller.isEditable,
                                  child: SizedBox(
                                    width: 88.w,
                                    height: 8.h,
                                    child: TextFormField(
                                      controller:
                                          controller.txtAddressController,
                                      onEditingComplete: () {
                                        controller.isEditable = false;
                                        controller.address = controller
                                            .txtAddressController.text;
                                        controller.update();
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                      ]),
                                      autofocus: true,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor, width: 0.5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: BorderSide(
                                              color: kTextGreyColor,
                                              width: 0.5),
                                        ),
                                        hintStyle: labelStyle,
                                        hintText: 'Address',
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 3.5.w,
                        right: 3.5.w,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: SizedBox(
                                  width: 45.w,
                                  height: 5.h,
                                  child: TextFormField(
                                    controller: controller.txtCityController,
                                    textInputAction: TextInputAction.next,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "* Required"),
                                    ]),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: kPrimaryColor, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: kTextGreyColor, width: 1),
                                      ),
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      hintText: 'City',
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: SizedBox(
                                  width: 45.w,
                                  height: 5.h,
                                  child: TextFormField(
                                    controller: controller.txtStateController,
                                    textInputAction: TextInputAction.next,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: "* Required"),
                                      MaxLengthValidator(2,
                                          errorText: 'State code required')
                                    ]),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: kPrimaryColor, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: kTextGreyColor, width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                            color: kTextGreyColor, width: 1),
                                      ),
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      hintText: 'State',
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            width: 92.w,
                            height: 5.h,
                            child: TextFormField(
                              controller: controller.txtPhoneNoController,
                              textInputAction: TextInputAction.next,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "* Required"),
                                PatternValidator(r'(^(?:[+0]9)?[0-9]{10,12}$)',
                                    errorText:
                                        'Please enter valid mobile number')
                              ]),
                              style: Theme.of(context).textTheme.labelLarge,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: kPrimaryColor, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: kTextGreyColor, width: 1),
                                ),
                                hintStyle:
                                    Theme.of(context).textTheme.labelMedium,
                                hintText: 'Phone No',
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.5.w, top: 1.h),
                      child: Text('Add a label',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    SizedBox(
                      height: 10.h,
                      width: 100.w,
                      // color: Colors.amber,
                      child: Padding(
                        padding: EdgeInsets.only(left: 6.w),
                        child: ListView.builder(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.labelList.length,
                          itemBuilder: (context, index) {
                            return CustomFloating(
                                controller.labelList[index], controller);
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.infoTextVisible,
                      child: Padding(
                        padding: EdgeInsets.only(right: 12, left: 12, top: 1.h),
                        child: SizedBox(
                          height: 8.5.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 8.w,
                                child: Icon(
                                  Icons.info_outlined,
                                  color: kIconColor,
                                ),
                              ),
                              SizedBox(
                                  width: 80.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 2,
                                    ),
                                    child: Text(
                                      'The label  "' +
                                          controller.selectedLabel +
                                          '" is already save in your address book. We\'ll remove this label on other addresses.',
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.istxtFieldVisible,
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: 12, left: 12, top: 0.5.h),
                        child: SizedBox(
                          width: 92.w,
                          height: 8.h,
                          child: TextFormField(
                            controller: controller.txtOtherController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: kPrimaryColor, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide:
                                    BorderSide(color: kTextGreyColor, width: 1),
                              ),
                              labelStyle: labelStyle,
                              labelText: 'e.g:  Sam\'s House',
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.5.h),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: RoundedLoadingButton(
                          borderRadius: 12,
                          child: Text('Save address',
                              style: Theme.of(context).textTheme.headlineLarge),
                          controller: RoundedLoadingButtonController(),
                          color: kPrimaryColor,
                          onPressed: () {
                            btnSaveAddress_onPressed();
                          },
                          animateOnTap: true,
                          height: 5.5.h,
                          width: 85.w,
                          resetDuration: Duration(seconds: 3),
                          resetAfterDuration: true,
                          errorColor: kPrimaryColor,
                          successColor: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ));
  }
}

class CustomMapPickup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaveAddressController>(builder: (controller) {
      return GoogleMap(
        cameraTargetBounds: CameraTargetBounds.unbounded,
        initialCameraPosition: controller.camPos,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
        // buildingsEnabled: false,
        onMapCreated: controller.onMapPickupCreated,
        markers: controller.markers,
        // onCameraMove: ((_position) => controller.updatePosition(_position)),
      );
    });
  }
}

class CustomFloating extends StatelessWidget {
  CustomLabelModel? model;
  SaveAddressController? controller;
  CustomFloating(this.model, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        children: [
          SizedBox(
            width: 100.w < 500 ? 11.w : 11.w,
            height: 5.5.h,
            child: FloatingActionButton(
              backgroundColor:
                  model!.isSelected! ? kPrimaryColor : Colors.white,
              child: Icon(
                model!.iconData,
                color: model!.isSelected! ? Colors.white : kPrimaryColor,
                size: 100.w < 500 ? 6.w : 4.w,
              ),
              onPressed: () {
                controller!.updateLabel(model!);
              },
            ),
          ),
          Text(
            model!.label!,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class CustomLabelModel {
  String? label;
  IconData? iconData;
  bool? isSelected;

  CustomLabelModel(this.label, this.iconData, this.isSelected);
}
