// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, constant_identifier_names, non_constant_identifier_names

import 'package:adobe_xd/pinned.dart';
import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/screens/CardDetailScreen/controller/CardDetailController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';
import '../../size_config.dart';

class CardDetailScreen extends StatefulWidget {
  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = true;
  OutlineInputBorder? border;
  UnderlineInputBorder? enabledBorder;
  UnderlineInputBorder? focusedBorder;

  InputDecoration? decor;
  final cardDetailController = Get.put(CardDetailController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final btnController = RoundedLoadingButtonController();
  @override
  void initState() {
    enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: kTxtColor, width: 0.4),
    );
    focusedBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: kTxtColor, width: 2),
      //borderRadius: BorderRadius.circular(25.0),
    );

    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly

    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetBuilder<CardDetailController>(builder: (controller) {
        return controller.isDeviceConnected
            ? Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endTop,
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
                resizeToAvoidBottomInset: false,
                body: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                          ),
                          height: 50.h,
                          width: 100.w,
                          child: Pinned.fromPins(
                            Pin(size: 259.0, end: -6.0),
                            Pin(size: 270.1, start: -21.1),
                            child: SvgPicture.string(
                              _svg_c4p6w,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      top: 100.w < 500 ? 5.h : 4.h,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Card Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 100.w < 500 ? 20.sp : 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 100.w < 500 ? 12.h : 10.h,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CreditCardWidget(
                            height: 100.w < 500 ? 30.h : 28.h,
                            width: 94.w,
                            glassmorphismConfig: useGlassMorphism
                                ? Glassmorphism.defaultConfig()
                                : null,
                            cardNumber: cardNumber,
                            expiryDate: expiryDate,
                            cardHolderName: cardHolderName,
                            cvvCode: cvvCode,
                            showBackView: isCvvFocused,
                            obscureCardNumber: true,
                            obscureCardCvv: true,
                            isHolderNameVisible: true,
                            cardBgColor: kTxtColor,
                            backgroundImage: useBackgroundImage
                                ? 'assets/icons/map.png'
                                : null,
                            isSwipeGestureEnabled: true,
                            onCreditCardWidgetChange:
                                (CreditCardBrand creditCardBrand) {},
                            customCardTypeIcons: <CustomCardTypeIcon>[
                              CustomCardTypeIcon(
                                cardType: CardType.mastercard,
                                cardImage: Image.asset(
                                  'assets/icons/card.png',
                                  height: 20.h,
                                  width: 18.w,
                                ),
                              ),
                              CustomCardTypeIcon(
                                cardType: CardType.visa,
                                cardImage: Image.asset(
                                  'assets/icons/visa_icon.png',
                                  height: 20.h,
                                  width: 18.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100.w < 500 ? 43.h - bottom / 1.1 : 40.h,
                      left: 2.7.w,
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          width: 94.w,
                          child: Column(
                            children: <Widget>[
                              CreditCardForm(
                                formKey: formKey,
                                obscureCvv: true,
                                obscureNumber: true,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                themeColor: Colors.blue,
                                textColor: kTxtColor,
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  labelStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  focusedBorder: focusedBorder,
                                  enabledBorder: enabledBorder,
                                ),
                                expiryDateDecoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  labelStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  focusedBorder: focusedBorder,
                                  enabledBorder: enabledBorder,
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  labelStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  focusedBorder: focusedBorder,
                                  enabledBorder: enabledBorder,
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  labelStyle:
                                      Theme.of(context).textTheme.titleSmall,
                                  focusedBorder: focusedBorder,
                                  enabledBorder: enabledBorder,
                                  labelText: 'Card Holder',
                                ),
                                onCreditCardModelChange:
                                    onCreditCardModelChange,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RoundedLoadingButton(
                                    controller:
                                        controller.roundedButtonController,
                                    color: kPrimaryColor,
                                    onPressed: () {
                                      btnSave_OnPressed();
                                    },
                                    child: Text(
                                      'Pay And Place Order',
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize,
                                        color: Colors.white,
                                      ),
                                    ),
                                    animateOnTap: true,
                                    height: 100.w < 500 ? 4.h : 3.5.h,
                                    width: 60.w,
                                    resetDuration: Duration(seconds: 3),
                                    resetAfterDuration: true,
                                    errorColor: kPrimaryColor,
                                    successColor: kTextColor,
                                  ),
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        ' Save ',
                                      ),
                                      Transform.scale(
                                        scale: 1,
                                        child: Checkbox(
                                            shape: CircleBorder(),
                                            side: BorderSide(color: kTxtColor),
                                            activeColor:
                                                kTxtColor.withOpacity(0.1),
                                            value: controller.isSaved,
                                            checkColor: kPrimaryColor,
                                            onChanged: (value) {
                                              controller
                                                  .saveCheckBoxClicked(value!);
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              // }),
                              ///
                              SizedBox(
                                height: 1.h,
                              )
                            ],
                          )

                          //}),
                          // PAGE FORM
                          ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: NoInternetWiget(
                    btnController, controller.btnReload_onClick),
              );
      }),
    );
  }

  void btnSave_OnPressed() {
    print(cardNumber);
    if (formKey.currentState!.validate()) {
      CreditCardModel ccmodel = CreditCardModel(
          cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);

      cardDetailController.SendPayment(context, ccmodel);
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height / 1.25);
    var firstControlPoint = Offset(size.width / 4, size.height / 3);
    var firstEndPoint = Offset(size.width / 2, size.height / 3 - 60);
    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = Offset(size.width, size.height / 3 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

const String _svg_c4p6w =
    '<svg viewBox="122.0 -21.1 259.0 270.1" ><path transform="translate(-2768.0, 2115.41)" d="M 2949.1201171875 -2125.83251953125 C 2949.1201171875 -2125.83251953125 2891.016845703125 -2113.84423828125 2890.047119140625 -2083.456787109375 C 2889.077392578125 -2053.06982421875 2945.065185546875 -2051.265380859375 3002.635986328125 -2046.403442382812 C 3060.206787109375 -2041.541381835938 3106.192626953125 -2019.043701171875 3108.869140625 -1959.169067382812 C 3111.545654296875 -1899.294555664062 3118.503662109375 -1875.752075195312 3138.45751953125 -1869.57080078125 C 3158.411376953125 -1863.389404296875 3144.008056640625 -1868.174682617188 3144.008056640625 -1868.174682617188 L 3144.008056640625 -2125.83251953125 C 3144.008056640625 -2125.83251953125 3105.101318359375 -2136.619140625 3100.61669921875 -2136.46630859375 C 3096.132080078125 -2136.313232421875 3013.591064453125 -2136.46630859375 3013.591064453125 -2136.46630859375 L 2949.1201171875 -2125.83251953125 Z" fill="#bd345d" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
