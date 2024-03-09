import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/Home/HomeScreen.dart';
import 'package:e_commerce/screens/Stores/controller/Storescontroller.dart';
import 'package:e_commerce/screens/Stores/helpers/StoresCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

class StoresScreen extends StatelessWidget {
  StoresScreen({Key? key}) : super(key: key);
  final controller = Get.put(StoreController());
  final btnController = RoundedLoadingButtonController();
  //final apiController = Get.put(ApiController());
  //late BitmapDescriptor customIcon;
  // final CameraPosition initialPosition = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14,
  // );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controllerbb) {
        return controllerbb.isDeviceConnected
            ? Scaffold(
                appBar: getPageAppBar(context, 'Stores', () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, route.homePage, (route) => false);
                }, () {
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, route.homePage, (route) => false);
                }),
                body: controllerbb.brandLocation == null ||
                        controllerbb.initialPosition == null ||
                        controllerbb.markerList == null
                    ? CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 1.h, right: 1.h),
                            child: SizedBox(
                              height: 50.h,
                              child: GoogleMap(
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                initialCameraPosition:
                                    controllerbb.initialPosition!,
                                onMapCreated: controllerbb.onMapCreated,
                                //circles: Set.from(controllerbb.circlePointsOfStores),
                                markers: Set.from(controllerbb.markerList!),
                              ),
                            ),
                          ),
                          // this will show total number of stores

                          Container(
                            height: 6.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 5.0, color: Colors.white),
                            ),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(0.29.h),
                                child: Text(
                                  '${controllerbb.brandLocation!.length} Stores ',
                                ),
                              ),
                            ),
                          ),
                          // Will show List of Stores here

                          // this list view will show the details of locations

                          SizedBox(
                            height: 25.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controllerbb.brandLocation!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controllerbb.moveCameraToStoreLocation(
                                            double.parse(controllerbb
                                                .brandLocation![index]
                                                .locationaddress!
                                                .locationlat!),
                                            double.parse(controllerbb
                                                .brandLocation![index]
                                                .locationaddress!
                                                .locationlong!));
                                      },
                                      child: StoresCard(
                                          brandLocation: controllerbb
                                              .brandLocation![index]),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
              )
            : Scaffold(
                appBar: getPageAppBar(context, 'Stores', () {}, () {}),
                body: NoInternetWiget(
                    btnController, controllerbb.btnReload_onClick),
              );
      },
    );
  }
}
