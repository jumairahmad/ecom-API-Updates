import 'package:e_commerce/screens/CurbSide/CurbSideOrder/controller/CurbSideOrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../../../Widgets/Widgets.dart';
import 'helperwidgets/curbside_widget.dart';

class CurbSideOrderScreen extends StatelessWidget {
  final curbSideOderController = Get.put(CurbSideOrderController());
  CurbSideOrderScreen({Key? key}) : super(key: key);
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Positioned(
              left: 4,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                color: Color(0xffa81947),
              ),
            ),
            //Spacer(),

            const Positioned(
              top: 50,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25),
                child: Text(
                  'Curbside\nOrder\'s',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 35,
                    color: Color(0xffb72957),
                    letterSpacing: 1.435,
                    fontWeight: FontWeight.w800,
                    height: 1.1428571428571428,
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                ),
              ),
            ),

            const Positioned(
              left: 80,
              top: 175,
              child: Text(
                'Park in a Curbside parking\nSpace and enter your space\nNumber',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: Color(0xffb72957),
                  letterSpacing: 0.656,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),

            Positioned(
              left: 80,
              top: 245,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.040,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xffb72957),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 15),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What if there are no available spaces?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        color: Color(0xffffffff),
                        letterSpacing: 0.492,
                        fontWeight: FontWeight.w800,
                        height: 1.6666666666666667,
                      ),
                      textHeightBehavior:
                          TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 290,
              left: 80,
              child: Text(
                'A Team Member is on the way\nWith your order',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  color: const Color(0x92b72957),
                  letterSpacing: 0.656,
                  fontWeight: FontWeight.w800,
                  height: 1.25,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.left,
              ),
            ),

            Positioned(
              top: 175,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.045,
                height: MediaQuery.of(context).size.height * 0.045,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: const Color(0xffb72957),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 10),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.8200000000000001,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 290,
              left: 30,
              child: Container(
                width: MediaQuery.of(context).size.height * 0.045,
                height: MediaQuery.of(context).size.height * 0.045,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: const Color(0xffb72957),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 10),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.8200000000000001,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),

            // const SizedBox(
            //  height: 20,
            //),
            GetBuilder<CurbSideOrderController>(builder: (controller) {
              return controller.isDeviceConnected
                  ? Positioned(
                      top: 350,
                      //bottom: 5,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.all(12),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 18.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.vertical,

                            //physics: NeverScrollableScrollPhysics(),
                            //padding: const EdgeInsets.all(2.0),
                            crossAxisSpacing: 0.h,
                            mainAxisSpacing: 0.h,
                            crossAxisCount: 4,
                            children: List.generate(20, (index) {
                              return CurbSideOrderButtonWidget(
                                  buttonid: index + 1,
                                  onpressed: () {
                                    controller.onParkingSelected(
                                        context, (index + 1).toString());
                                  });
                            }),
                          ),
                        ),
                      ),
                    )
                  : NoInternetWiget(
                      btnController, controller.btnReload_onClick);
            }),
          ],
        ),
      ),
    );
  }
}
