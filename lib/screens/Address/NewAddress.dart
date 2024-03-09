// ignore_for_file: use_key_in_widget_constructors

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';

import 'package:e_commerce/screens/Address/Controller/AddressController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:sizer/sizer.dart';

class NewAddress extends StatelessWidget {
  final addressController = Get.put(NewAddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: getPageAppBar(
        context,
        'New Address',
        () {
          Navigator.of(context).pop();
        },
        () {
          Navigator.of(context).pop();
        },
        Colors.transparent,
        null,
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: 100.w < 500 ? 9.w : 6.w,
              child: FloatingActionButton(
                backgroundColor: kTxtLightColor,
                child: Icon(
                  Icons.close,
                  color: kPrimaryColor,
                  size: 100.w < 500 ? 5.w : 3.5.w,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            child: Column(
              children: <Widget>[
                //MAPS CONTAINER
                SizedBox(
                  height: 100.h,
                  child: Stack(
                    children: [
                      CustomMapPickup(),
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: TxtSearchField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 5.5.h,
                            width: 85.w,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              child: Text('Confirm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                              onPressed: () {
                                addressController.btnConfirm_onPressed(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          mini: true,
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.location_on),
          onPressed: () {
            addressController.btnMyLocation_onPressed();
          },
          // label: Text('My Location'),
          // icon: Icon(Icons.location_on),
        ),
      ),
    );
  }
}

class CustomMapPickup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewAddressController>(builder: (controller) {
      return GoogleMap(
        cameraTargetBounds: CameraTargetBounds.unbounded,
        initialCameraPosition: controller.camPos,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: controller.onMapPickupCreated,
        markers: controller.markers,
        onCameraMoveStarted: controller.onCameraMoveStarted,
        onCameraMove: ((_position) => controller.updatePosition(_position)),
      );
    });
  }
}

class TxtSearchField extends StatelessWidget {
  const TxtSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        color: kTxtLightColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.only(right: 16, left: 16, top: 4.h),
      child: Container(
          margin: EdgeInsets.all(4),
          color: Colors.blue.shade50.withOpacity(0.3),
          child: GetBuilder<NewAddressController>(builder: (controller) {
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
                  size: 100.w < 500 ? 5.w : 3.5.w,
                ),
                suffixIcon: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down_rounded,
                      size: 100.w < 500 ? 7.w : 4.5.w, color: kIconColor),
                ),
              ),
              onTap: () {
                controller.btnSearch_onPressed(context);
              },
            );
          })),
    );
  }
}
