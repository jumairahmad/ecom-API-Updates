//import 'package:e_commerce/Widgets/NotifcationService.dart';
// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable

import 'dart:async';

import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await GetStorage.init();
  final box = GetStorage();
  bool logged = box.read('logged') ?? false;
  if (logged) {
    final signController = Get.put(SignInController());

    signController
        .userLogin_saved(box.read('phone')!, box.read('pass')!)
        .then((value) {
      if (value) {
        Timer(Duration(seconds: 3), () {
          runApp(MyApp(route.splash));
        });
      }
    });
  } else {
    runApp(MyApp(route.splash));
  }
}

class MyApp extends StatelessWidget {
  String? initialRoute;
  MyApp(this.initialRoute, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ECommerce',
            theme: defaultTheme,
            builder: (context, widget) => ResponsiveWrapper.builder(
                  BouncingScrollWrapper.builder(context, widget!),
                  maxWidth: 1200,
                  minWidth: 480,
                  defaultScale: false,
                  breakpoints: [
                    ResponsiveBreakpoint.resize(480, name: MOBILE),
                    ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                  ],
                  background: Container(
                    color: Color(0xFFF5F5F5),
                  ),
                ),
            onGenerateRoute: route.controller,
            initialRoute: initialRoute);
      },
    );
  }
}
