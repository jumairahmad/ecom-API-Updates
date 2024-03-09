import 'package:flutter/material.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:get/get.dart';

import 'OrderLocation/Search.dart';
import 'package:geolocator/geolocator.dart';

class Screens extends StatelessWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _determinePosition();
    return Scaffold(
        appBar: AppBar(
          title: Text('Screens'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Home page'),
                  onPressed: () => Get.toNamed(route.homePage),
                ),
                ElevatedButton(
                  child: Text('Item Search page'),
                  onPressed: () => Get.toNamed(route.searchPage),
                ),
                ElevatedButton(
                  child: Text('Item Detail'),
                  onPressed: () => Get.toNamed(route.singleItemPage),
                ),
                ElevatedButton(
                  child: Text('Order page'),
                  onPressed: () => Get.toNamed(route.orderPage),
                ),
                ElevatedButton(
                  child: Text('Order Success page'),
                  onPressed: () => Get.toNamed(route.orderSuccessPage),
                ),
                ElevatedButton(
                  child: Text('Order Track page'),
                  onPressed: () => Get.toNamed(route.orderTrackPage),
                ),
                ElevatedButton(
                  child: Text('Order View page'),
                  onPressed: () => Get.toNamed(route.orderViewPage),
                ),
                ElevatedButton(
                  child: Text('Delivery page'),
                  onPressed: () => Get.toNamed(route.deliveryPage),
                ),
                ElevatedButton(
                  child: Text('Card Detail page'),
                  onPressed: () => Get.toNamed(route.cardDetailPage),
                ),
                ElevatedButton(
                  child: Text('Sign In page'),
                  onPressed: () => Get.toNamed(route.loginPage),
                ),
                ElevatedButton(
                  child: Text('Forget Password page'),
                  onPressed: () => Get.toNamed(route.forgotPasswordPage),
                ),
                ElevatedButton(
                  child: Text('Sign Up page'),
                  onPressed: () => Get.toNamed(route.registerPage),
                ),
                ElevatedButton(
                  child: Text('Locations Search  page'),
                  onPressed: () => Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          LocationSearch(),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Splash page'),
                  onPressed: () => Get.toNamed(route.splash),
                ),
              ],
            ),
          ),
        ));
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
