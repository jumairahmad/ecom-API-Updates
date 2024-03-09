// ignore_for_file: prefer_final_fields, prefer_typing_uninitialized_variables, must_be_immutable, prefer_collection_literals, prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:e_commerce/WebHook/Models/BrandAuth.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/controller/CustomMapController.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import 'package:e_commerce/routes.dart' as route;

class Mapscreen extends StatelessWidget {
  final customMapController = Get.put(CustomMapController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool curbSide = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomMapController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Visibility(
              visible: controller.pickupVisible,
              child: SizedBox(
                height: 34.h,
                child: Stack(
                  children: [CustomMapPickup()],
                ),
              ),
            ),
            Visibility(
              visible: controller.deliveryVisible,
              child: SizedBox(
                height: 34.h,
                child: Stack(
                  children: [CustomMap(), TxtSearchField()],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  bottom: 8,
                  top: 100.w < 500 ? 0.h : 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomMapButton('Delivery', controller.deliveryVisible, () {
                    controller.btnDelivery_onPressed();
                  }),
                  CustomMapButton('Pickup', controller.pickupVisible, () {
                    controller.btnPickup_onPressed();
                  })
                ],
              ),
            ),
            // first tab bar view widget
            Visibility(
              visible: controller.deliveryVisible,
              child: Column(
                children: [
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      SizedBox(
                        width: 4.w,
                      ),
                      Icon(Icons.pin_drop, size: 100.w < 500 ? 6.w : 4.w),
                      SizedBox(
                        width: 8.w,
                      ),
                      SizedBox(
                        width: 70.w,
                        child: Text(
                          controller.txtSearchController.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: kTxtColor,
                              fontSize: 100.w < 500 ? 10.sp : 7.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    width: 92.w,
                    child: Card(
                      //margin: EdgeInsets.zero,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.disabled,
                          key: formKey,
                          child: Column(
                            children: [
                              TxtField(
                                txtController: controller.txtCityController,
                                lblText: 'City',
                                validator: [
                                  RequiredValidator(errorText: "* Required"),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TxtField(
                                txtController:
                                    controller.txtHomeAddressController,
                                lblText: 'Home Address',
                                validator: [
                                  RequiredValidator(errorText: "* Required"),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TxtField(
                                txtController: controller.txtPhoneController,
                                lblText: 'Phone',
                                keyboardType: TextInputType.phone,
                                validator: [
                                  RequiredValidator(errorText: "* Required"),
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TxtField(
                                txtController: controller.txtZipController,
                                lblText: 'Zip',
                                keyboardType: TextInputType.phone,
                                validator: [
                                  RequiredValidator(errorText: "* Required"),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // second tab bar view widget
            Visibility(
              visible: controller.pickupVisible,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      SizedBox(height: 1.2.h),
                      Text(
                        "Select Store",
                        style: TextStyle(
                            color: kTxtColor,
                            fontSize: 100.w < 500 ? 11.sp : 9.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: 0.1.h,
                        ),
                        shrinkWrap: true,
                        itemCount: controller.stores.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Visibility(
                            visible: controller
                                    .stores[index].locationfeatures!.pickup ==
                                "true",
                            child: GestureDetector(
                              onTap: () {
                                {
                                  for (var element in controller.stores) {
                                    element.selected = false;
                                    element.locationfeatures!.curbSideEnabled =
                                        false;
                                  }
                                  controller.stores[index].selected = true;
                                  controller.update();
                                }
                              },
                              child: StoreCard(curbSide,
                                  controller.stores[index], index, controller),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 8.h,
          child: Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryLightButton('Save', 3.5.h, 30.w, () {
                  controller.btnSave_OnPressed(context);
                }),
                PrimaryButton(
                  title: 'Cancel',
                  height: 4.h,
                  width: 30.w,
                  callback: () {
                    Navigator.pop(context);
                  },
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  brRadius: 50,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CustomMapButton extends StatelessWidget {
  String title;
  bool isSelected;
  VoidCallback onPressed;

  CustomMapButton(this.title, this.isSelected, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.grey.shade100.withOpacity(0.5)),
          backgroundColor: MaterialStateProperty.all(
              isSelected ? kPrimaryColor : Colors.indigo.shade100),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        child: SizedBox(
            width: 30.w,
            height: 3.5.h,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: isSelected ? Colors.white : kTxtColor,
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  fontWeight: isSelected ? FontWeight.normal : FontWeight.w600),
            ))),
        onPressed: () {
          onPressed();
        });
  }
}

class StoreCard extends StatelessWidget {
  bool curbSideSelected;
  int index;
  Locations? location;
  CustomMapController controller;
  StoreCard(this.curbSideSelected, this.location, this.index, this.controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: location!.locationfeatures!.pickup == "true",
          child: Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Row(
              children: [
                Text(
                  index.toString() + ". ",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 100.w < 500 ? 10.5.sp : 7.5.sp),
                ),
                Text(
                  location!.locationname!,
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
        ),
        Card(
          shape: location!.selected!
              ? RoundedRectangleBorder(
                  side: BorderSide(color: kTxtColor, width: 1),
                  borderRadius: BorderRadius.circular(borderRaius),
                )
              : RoundedRectangleBorder(
                  side: BorderSide(color: kTxtLightColor, width: 0.4),
                  borderRadius: BorderRadius.circular(borderRaius),
                ),
          elevation: 5,
          shadowColor: kTxtLightColor.withOpacity(0.5),
          color: location!.selected!
              ? kTxtLightColor.withOpacity(0.8)
              : Colors.white,
          child: SizedBox(
            height: location!.locationfeatures!.curbside == "true"
                ? 100.w < 500
                    ? 11.5.h
                    : 8.h
                : 100.w < 500
                    ? 8.h
                    : 6.h,
            width: 90.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.pin_drop,
                    size: 100.w < 500 ? 6.w : 3.5.w,
                    color:
                        location!.selected! ? kPrimaryColor : kTextGreyColor),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        location!.locationaddress!.address!,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Visibility(
                      visible: location!.locationcontact!.phone! != '',
                      child: SizedBox(
                          width: 50.w,
                          child: Text(
                            location!.locationcontact!.phone!,
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 30.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                            visible:
                                location!.locationfeatures!.curbside == "true",
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Checkbox(
                                    checkColor: kPrimaryColor,
                                    shape: CircleBorder(),
                                    side: BorderSide(color: kTxtColor),
                                    activeColor: kTxtColor.withOpacity(0.1),
                                    value: location!
                                        .locationfeatures!.curbSideEnabled,
                                    onChanged: (bool? value) {
                                      controller.enableCurbSide(
                                          location!.locationid!, value!);
                                    },
                                  ),
                                  Text(
                                    'Curbside',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  )
                                ],
                              ),
                            )),
                        Text(
                          location!.distance!.toStringAsFixed(2) + " m far",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TxtSearchField extends StatelessWidget {
  const TxtSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.blue.shade50, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.only(right: 20, left: 20, top: 5.h),
      child: Container(
          margin: EdgeInsets.zero,
          color: Colors.blue.shade50.withOpacity(0.3),
          child: GetBuilder<CustomMapController>(builder: (controller) {
            return TextField(
              enableInteractiveSelection: false,
              readOnly: true,
              style: Theme.of(context).textTheme.headlineMedium,
              controller: controller.txtSearchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide:
                        const BorderSide(width: 0, color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide:
                      const BorderSide(width: 0, color: Colors.transparent),
                ),
                contentPadding: EdgeInsets.all(100.w < 500 ? 0 : 5.w),
                prefixIcon: Icon(
                  Icons.pin_drop_rounded,
                  color: kIconColor,
                  size: 100.w < 500 ? 6.w : 3.5.w,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down_rounded,
                      size: 100.w < 500 ? 6.w : 4.w, color: kIconColor),
                ),
              ),
              onTap: () {
                Get.toNamed(route.searchMapPage);
              },
            );
          })),
    );
  }
}

class CustomMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomMapController>(builder: (controller) {
      return GoogleMap(
        cameraTargetBounds: CameraTargetBounds.unbounded,
        initialCameraPosition: controller.camPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: controller.onMapCreated,
        markers: Set<Marker>.of(controller.markers.values),
        polylines: Set<Polyline>.of(controller.polylines.values),
        circles: controller.circles,
      );
    });
  }
}

class CustomMapPickup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomMapController>(builder: (controller) {
      return GoogleMap(
        cameraTargetBounds: CameraTargetBounds.unbounded,
        initialCameraPosition: controller.camPosPickup,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: controller.onMapPickupCreated,
        markers: Set<Marker>.of(controller.marker),
      );
    });
  }
}
