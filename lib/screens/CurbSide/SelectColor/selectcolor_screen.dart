import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../Widgets/Widgets.dart';
import 'controller/select_color_controller.dart';
import 'helperwidgets/colorwidgets.dart';

class SelectColorScreen extends StatelessWidget {
  SelectColorScreen({Key? key}) : super(key: key);
  final selecColorController = Get.put(SelectColorController());
  final btnController = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Positioned(
              left: 4,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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
                  'Select\nVehicle Color',
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
            // const SizedBox(
            //  height: 20,
            //),
            GetBuilder<SelectColorController>(builder: (controller) {
              return controller.isDeviceConnected
                  ? Positioned(
                      //top: 50,
                      bottom: 25,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,
                          //physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(right: 18.0),
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          crossAxisCount: 2,
                          children: controller.select_colors
                              .map((e) => ColorWidgets(
                                  colorname: e.colorName, color: e.color))
                              .toList(),
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
