// ignore_for_file: must_be_immutable

import 'package:e_commerce/screens/CurbSide/CurbSideOrder/controller/CurbSideOrderController.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/routes.dart' as route;
import 'package:get/get.dart';

class ColorWidgets extends StatelessWidget {
  final curbSideOrderController = Get.put(CurbSideOrderController());
  String colorname;
  Color color;
  ColorWidgets({Key? key, required this.colorname, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        curbSideOrderController.curbSide.vehicleColor = colorname;
        curbSideOrderController.update();
        Get.toNamed(route.curbSideSelect);
      },
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xffa81947),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    colorname,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Color(0xffffffff),
                      letterSpacing: 0.738,
                      fontWeight: FontWeight.w800,
                      height: 0.7222222222222222,
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  //top: MediaQuery.of(context).size.height * 0.5,
                  bottom: -35,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.height * 0.11,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.elliptical(9999.0, 9999.0)),
                      color: color,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
