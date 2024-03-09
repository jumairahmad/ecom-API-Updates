// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:e_commerce/WebHook/Controller/ApiController.dart';
import 'package:e_commerce/services/NotifcationService.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/Splash/controller/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sizer/sizer.dart';
import 'package:e_commerce/routes.dart' as route;

class SplashScreen extends StatelessWidget {
  final splashController = Get.put(SplashController());
  final apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    apiController.pageBuildContext = context;
    apiController.update();
    return Scaffold(
      body: GetBuilder<SplashController>(builder: (controller) {
        return LiquidSwipe(
          onPageChangeCallback: controller.pageChangeCallback,
          liquidController: controller.liquidController,
          pages: pages,
          enableLoop: true,
          initialPage: controller.page,
          enableSideReveal: true,
          slideIconWidget: Icon(Icons.arrow_back_ios),
          fullTransitionValue: 300,
          waveType: WaveType.liquidReveal,
        );
      }),
    );
  }

  final pages = [
    SplashScreen1(),
    SplashScreen2(),
    SplashScreen3(),
  ];
}

class SplashScreen1 extends StatelessWidget {
  final apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        color: kPrimaryColor.withOpacity(0.6),
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: PrimaryButton(
                    'Skip',
                    kPrimaryColor,
                    kPrimaryColor,
                  ),
                ),
              ),
              Flexible(
                  flex: 4,
                  child:
                      Center(child: Image.asset("assets/images/splash_1.png"))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.h),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Online",
                      style: greyStyle,
                    ),
                    Text(
                      "Order",
                      style: boldStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Temporibus autem aut\n"
                      "officiis debitis aut rerum\n"
                      "necessitatibus",
                      style: descriptionGreyStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          'Login',
                          kPrimaryColor,
                          kPrimaryColor,
                        ),
                        PrimaryLightButtonSplash(
                          'Register',
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static const TextStyle goldcoinGreyStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle goldCoinWhiteStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle greyStyle = TextStyle(
      fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");
  static const TextStyle whiteStyle = TextStyle(
      fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");

  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: kPrimaryColor,
    fontFamily: "Product Sans",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kTxtColor.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: PrimaryButton(
                    'Skip',
                    kTxtColor,
                    kTxtColor.withOpacity(0.8),
                  ),
                ),
              ),
              Flexible(
                  flex: 4,
                  child:
                      Center(child: Image.asset("assets/images/splash_2.png"))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.h),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Instant",
                      style: greyStyle,
                    ),
                    Text(
                      "Delivery",
                      style: boldStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Temporibus autem aut\n"
                      "officiis debitis aut rerum\n"
                      "necessitatibus",
                      style: descriptionGreyStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          'Login',
                          kTxtColor,
                          kTxtColor,
                        ),
                        PrimaryLightButtonSplash(
                          'Register',
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static const TextStyle greyStyle = TextStyle(
    fontSize: 40.0,
    color: Colors.white,
  );
  static const TextStyle whiteStyle = TextStyle(
    fontSize: 40.0,
    color: Colors.white,
  );
  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: kTxtColor,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );
  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );
}

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF5B9071).withOpacity(0.8),
        child: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: PrimaryButton(
                      'Skip',
                      Color(0xFF3F644F),
                      Color(0xFF3F644F),
                    )),
              ),
              Flexible(
                  flex: 4,
                  child:
                      Center(child: Image.asset("assets/images/splash_3.png"))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.h),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Instant",
                      style: greyStyle,
                    ),
                    Text(
                      "Delivery",
                      style: boldStyle,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Temporibus autem aut\n"
                      "officiis debitis aut rerum\n"
                      "necessitatibus",
                      style: descriptionGreyStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          'Login',
                          Color(0xFF385A47),
                          Color(0xFF385A47),
                        ),
                        PrimaryLightButtonSplash(
                          'Register',
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static const TextStyle goldcoinGreyStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle goldCoinWhiteStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle greyStyle = TextStyle(
      fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");
  static const TextStyle whiteStyle = TextStyle(
      fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");

  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: Color(0xFF385A47),
    fontFamily: "Product Sans",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );
}

class PrimaryLightButtonSplash extends StatelessWidget {
  final String title;

  // Notice the variable type

  const PrimaryLightButtonSplash(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(Colors.grey.shade100.withOpacity(0.5)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo.shade100),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
        ),
        child: SizedBox(
            height: 4.h,
            width: 26.w,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                color: kTxtColor,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
            ))),
        onPressed: () {
          Get.toNamed(route.registerPage);
        });
  }
}

class PrimaryButton extends StatelessWidget {
  String title;
  Color color;
  Color borderColor;

  // Notice the variable type

  PrimaryButton(this.title, this.borderColor, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(color: borderColor),
            ),
          ),
        ),
        child: SizedBox(
            height: 4.h,
            width: 26.w,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
            ))),
        onPressed: () {
          title == "Skip"
              ? Get.toNamed(route.homePage)
              : Get.toNamed(route.loginPage);
        });
  }
}
