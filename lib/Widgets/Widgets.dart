// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, constant_identifier_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:badges/badges.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:e_commerce/constants.dart';

import 'package:e_commerce/controller/WidgetController.dart';
import 'package:e_commerce/screens/Home/controller/HomeController.dart';

import 'package:e_commerce/screens/Order/controller/OrderController.dart';
import 'package:e_commerce/screens/SignScreen/controlller/SignController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../screens/Notification/controller/NotificationController.dart';
import '../screens/Order/helpers/Login.dart';

final WidgetController _widgetController = Get.put(WidgetController());

AppBar getAppBar(BuildContext context, [intials]) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 8.h,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        _widgetController.update();
        Get.toNamed(route.deliveryPage);
      },
      child: GetBuilder<WidgetController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                controller.orderType,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      controller.address,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                    size: 3.h,
                  )
                ],
              ),
            ],
          );
        },
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: GestureDetector(
          onTap: () {
            intials == "Guest"
                ? Get.toNamed(route.loginPage)
                : Get.toNamed(route.profilePage);
          },
          child: CircleAvatar(
            radius: 7.1.w,
            backgroundColor: kTxtLightColor,
            child: CircleAvatar(
              radius: 7.w,
              backgroundColor: kPrimaryColor,
              child: Text(
                intials,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: intials == "Guest"
                        ? 100.w < 500
                            ? 11.sp
                            : 8.sp
                        : 100.w < 500
                            ? 14.sp
                            : 9.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: intials == "Guest" ? 1 : 5),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

AppBar getPageAppBar(BuildContext context, String title, VoidCallback onTap,
    VoidCallback onTapBack,
    [bgColor, fontSize, isActionVisible]) {
  return AppBar(
    //toolbarHeight: 6.h,
    automaticallyImplyLeading: true,
    backgroundColor: bgColor ?? Colors.white,
    centerTitle: true,
    elevation: 0.0,
    title: Text(
      title,
      style: TextStyle(
        color: kTxtColor,
        fontSize: fontSize ?? 100.w < 500 ? 18.sp : 13.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    leading: Padding(
      padding: EdgeInsets.only(left: 100.w < 500 ? 0 : 6.w),
      child: IconButton(
        splashRadius: 6.w,
        iconSize: 100.w < 500 ? 7.w : 5.w,
        onPressed: () {
          onTapBack();
        },
        icon: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.arrow_right_alt,
            color: kTxtColor,
          ),
        ),
      ),
    ),
    actions: <Widget>[
      isActionVisible ??
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                onTap();
              },
              child: Icon(
                Icons.close,
                color: kPrimaryColor,
                size: 100.w < 500 ? 7.w : 4.5.w,
              ),
            ),
          ),
    ],
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: bgColor ?? Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  AddButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRaius),
                  bottomRight: Radius.circular(borderRaius)),
              side: BorderSide(color: Colors.pink.shade900, width: 0.5),
            )),
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
        onPressed: onPressed,
        child: Text(
          "Add",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WidgetController>(
      builder: (controller) {
        return Container(
          height: 100.h == 896 ? 10.h : 8.5.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(7.w),
              topLeft: Radius.circular(7.w),
            ),
            boxShadow: [
              BoxShadow(color: kTxtLightColor, spreadRadius: 4, blurRadius: 8),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.w),
              topRight: Radius.circular(7.w),
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 100.w < 500 ? 7 : 12,
              elevation: 0,
              color: Colors.white,
              child: Row(
                //children inside bottom appbar
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      controller.selectedNav = 0;
                      controller.update();

                      Get.offAllNamed(route.homePage);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: controller.selectedNav == 0
                              ? kPrimaryColor
                              : kTxtColor,
                          size: 100.w < 500 ? 7.w : 5.w,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 100.w < 500 ? 10.sp : 7.sp,
                            color: controller.selectedNav == 0
                                ? kPrimaryColor
                                : kTxtColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //if (controller.selectedNav != 1) {
                      controller.selectedNav = 1;
                      controller.update();

                      homeController.btnSeeAll_onClick(
                          context, route.searchPage);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store_outlined,
                          color: controller.selectedNav == 1
                              ? kPrimaryColor
                              : kTxtColor,
                          size: 100.w < 500 ? 7.w : 5.w,
                        ),
                        Text(
                          "Specials",
                          style: TextStyle(
                            fontSize: 100.w < 500 ? 10.sp : 7.sp,
                            color: controller.selectedNav == 1
                                ? kPrimaryColor
                                : kTxtColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //  if (controller.selectedNav != 2) {
                      controller.selectedNav = 2;
                      controller.update();
                      homeController.checkConnection();
                      homeController.update();
                      Get.offAllNamed(route.dealListALlPage);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: controller.selectedNav == 2
                              ? kPrimaryColor
                              : kTxtColor,
                          size: 100.w < 500 ? 6.w : 5.w,
                        ),
                        Text(
                          "Deals",
                          style: TextStyle(
                            fontSize: 100.w < 500 ? 10.sp : 7.sp,
                            color: controller.selectedNav == 2
                                ? kPrimaryColor
                                : kTxtColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final userController = Get.put(SignInController());

                      if (userController.user.userfullName == '' ||
                          userController.user.userfullName == null) {
                        showMaterialModalBottomSheet(
                          expand: false,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            side: BorderSide(color: Colors.black12, width: 0.5),
                          ),
                          context: context,
                          builder: (context) {
                            if (userController.user.userfullName == '' ||
                                userController.user.userfullName == null) {
                              return IfNotLoggedIn();
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        final notificationController =
                            Get.put(NotificationController());

                        controller.update();
                        notificationController.getNotifications();
                        Get.toNamed(route.notificationPage);
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          color: kTxtColor,
                          size: 100.w < 500 ? 7.w : 5.w,
                        ),
                        Text(
                          "Alerts",
                          style: TextStyle(
                            fontSize: 100.w < 500 ? 10.sp : 7.sp,
                            color: controller.selectedNav == 3
                                ? kPrimaryColor
                                : kTxtColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShoppingCartBadge extends StatelessWidget {
  ShoppingCartBadge({Key? key}) : super(key: key);
  final orderControlleer = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return Badge(
          elevation: 0,
          toAnimate: false,
          badgeColor: kPrimaryColor,
          showBadge: controller.getOrderItemCount() > 0,
          badgeContent: Text(
            controller.getOrderItemCount().toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.labelSmall?.fontSize),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 100.w < 500 ? 0 : 1.h,
                  right: 100.w < 500 ? 0 : 1.8.w),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 100.w < 500 ? 6.w : 5.w,
                ),
                onPressed: () {
                  Get.toNamed(route.orderPage);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemQuantityWidget extends StatelessWidget {
  Widget countWidget;
  final VoidCallback btnIncrease;
  final VoidCallback btnDecrease;
  ItemQuantityWidget(this.countWidget, this.btnIncrease, this.btnDecrease);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 100.w < 500 ? 9.sp : 6.sp,
          backgroundColor: kTxtColor.withOpacity(0.2),
          child: IconButton(
            splashRadius: 100.w < 500 ? 18 : 20,
            onPressed: () {
              btnDecrease();
            },
            icon: SvgPicture.string(
              svg_ohkv,
              allowDrawingOutsideViewBox: true,
              height: 100.w < 500 ? 1.h : 0.3.h,
              width: 100.w < 500 ? 4.w : 1.2.w,
            ),
          ),
        ),
        SizedBox(
          width: 3.w,
        ),
        countWidget,
        SizedBox(
          width: 3.w,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          splashRadius: 100.w < 500 ? 18 : 20,
          onPressed: () {
            btnIncrease();
          },
          iconSize: 100.w < 500 ? 20.sp : 15.sp,
          icon: Icon(
            Icons.add_circle,
            color: kTxtColor,
          ),
        ),
      ],
    );
  }
}

class ButtonTabbar extends StatelessWidget {
  TabController myTabController;
  String txtTab1;
  String txtTab2;
  double contentPaddHor;
  ButtonTabbar(
      this.myTabController, this.txtTab1, this.txtTab2, this.contentPaddHor);

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      onTap: (val) {
        _widgetController.updateSelectedNav(val);
      },
      contentPadding: EdgeInsets.symmetric(horizontal: contentPaddHor),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      height: 70,
      unselectedLabelStyle: TextStyle(
        color: kTxtColor,
        fontWeight: FontWeight.bold,
      ),
      radius: 50,
      controller: myTabController,
      backgroundColor: kPrimaryColor,
      unselectedBackgroundColor: Colors.indigo.shade100.withOpacity(0.6),
      center: false,
      tabs: [
        Tab(
          text: txtTab1,
        ),
        Tab(
          text: txtTab2,
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  String? title;
  double? height;
  double? width;
  double? fontSize;
  double? brRadius;
  final VoidCallback? callback;
  Color? bgColor;
  Color? txtColor;

  PrimaryButton({
    this.title,
    this.height,
    this.width,
    this.callback,
    this.fontSize,
    this.brRadius,
    this.bgColor,
    this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor ?? kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(brRadius ?? borderRaius),
            ),
          ),
        ),
        child: SizedBox(
            width: width ?? 40.w,
            height: height ?? 4.h,
            child: Center(
                child: Text(
              title ?? 'Title',
              style: TextStyle(
                  //fontFamily: 'Muli',
                  color: txtColor ?? Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600),
            ))),
        onPressed: callback);
  }
}

class PrimaryLightButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? callback; // Notice the variable type

  const PrimaryLightButton(this.title, this.height, this.width, this.callback,
      {Key? key})
      : super(key: key);

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
              //side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        child: SizedBox(
            width: width,
            height: height,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  color: kTxtColor,
                  // fontFamily: 'Muli',
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  fontWeight: FontWeight.w600),
            ))),
        onPressed: callback);
  }
}

class Notifications extends StatelessWidget {
  String title;
  String detail;
  String timeStamp;

  Notifications(this.title, this.detail, this.timeStamp, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h, top: 1.2.h, right: 4.w, left: 4.w),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRaius),
        ),
        margin: EdgeInsets.all(0),
        elevation: 5,
        shadowColor: kTxtLightColor,
        child: ListTile(
            isThreeLine: true,
            dense: true,
            title: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text('Notfication title',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            subtitle: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(title, style: Theme.of(context).textTheme.titleSmall),
            ),
            trailing: Text(
              timeStamp,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              print(title + " clicked");
            }),
      ),
    );
  }
}

class TxtField extends StatelessWidget {
  final txtController;
  final lblText;
  final keyboardType;
  final suffix;
  final obsecure;
  final validator;

  const TxtField(
      {this.txtController,
      this.lblText,
      this.keyboardType,
      this.suffix,
      this.obsecure,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: txtController,
      keyboardType: keyboardType,
      obscureText: obsecure ?? false,
      validator: MultiValidator(validator),
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.labelLarge,
      decoration: InputDecoration(
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        //labelText: lblText,
        hintText: lblText,
        contentPadding: EdgeInsets.all(10),
        suffix: suffix,
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  String initials;
  double radius;
  double fontSize;
  ProfileAvatar(this.initials, this.radius, this.fontSize);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 15, color: kTxtLightColor, spreadRadius: 10)
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: kPrimaryColor,
        child: Text(
          initials,
          style: TextStyle(
              fontSize: initials == "Guest" ? fontSize - 2.sp : fontSize,
              letterSpacing: initials == "Guest" ? 1 : 10,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class NoInternetWiget extends StatelessWidget {
  RoundedLoadingButtonController btnController;
  VoidCallback onPressed;
  NoInternetWiget(this.btnController, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 40.w,
            backgroundColor: Colors.transparent,
            child: Image.asset(
              'assets/icons/noInternet.png',
            ),
          ),
        ),
        Text(
          "No internet connection!",
          style: TextStyle(
              color: kTxtColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              wordSpacing: 10,
              shadows: <Shadow>[
                Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(1, 1),
                    blurRadius: 15),
              ]),
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          "Please check your internet connection.",
          style:
              TextStyle(fontSize: 16.sp, color: kTextGreyColor, wordSpacing: 4),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.h,
        ),
        RoundedLoadingButton(
          child: Text('Refresh',
              style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          controller: RoundedLoadingButtonController(),
          color: kPrimaryColor,
          onPressed: onPressed,
          animateOnTap: true,
          height: 5.h,
          width: 60.w,
          resetDuration: Duration(seconds: 2),
          resetAfterDuration: true,
          errorColor: kPrimaryColor,
          successColor: kTextColor,
        ),
      ],
    );
  }
}

String getInitials(fullname) {
  if (fullname == null || fullname == '' || fullname == 'Guest') {
    return "Guest";
  } else {
    List<String> names = fullname.split(" ");
    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials;
  }
}

snackBar(String title, String subTitle) {
  Get.snackbar(
    title,
    subTitle,
    colorText: kTxtColor,
    backgroundColor: kTxtLightColor.withOpacity(0.5),
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}

const String svg_ohkv =
    '<svg viewBox="277.5 147.5 8.0 1.0" ><path transform="translate(270.0, 129.5)" d="M 7.5 18 L 15.5 18" fill="none" stroke="#284a6e" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
