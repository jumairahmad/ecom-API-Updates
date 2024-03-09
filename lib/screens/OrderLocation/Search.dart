// ignore_for_file: avoid_print, file_names

import 'package:e_commerce/controller/CustomMapController.dart';
import 'package:e_commerce/controller/WidgetController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);

  @override
  _LocationSearchState createState() {
    return _LocationSearchState();
  }
}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController controller = TextEditingController(text: "");
  CustomMapController customMapcontroller = Get.put(CustomMapController());
  WidgetController widgetController = Get.put(WidgetController());

  late GooglePlace googlePlace = GooglePlace(googleAPiKey);
  late DetailsResult detailsResult;
  late List<AutocompletePrediction> predictions = [];
  bool locationsVisible = false;

  late GoogleMapController mapController;
  bool loading = false;
  String googleAPiKey = "AIzaSyAwJvVMDxcDD2E5mzuXq-WCvR_Ib7GjQsc";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          middle: CupertinoSearchTextField(
            controller: controller,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  locationsVisible = true;
                });
                autoCompleteSearch(value);
              } else {
                if (predictions.isNotEmpty && mounted) {
                  setState(() {
                    locationsVisible = false;
                    predictions = [];
                  });
                }
              }
            },
            onSubmitted: (value) {},
            autocorrect: true,
          ),
          trailing: GestureDetector(
            child: Text("Cancel"),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      child: Scaffold(
          body: Center(
        child: ListView.builder(
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Icon(
                  Icons.pin_drop,
                  color: Colors.white,
                ),
              ),
              title: Text(predictions[index].description ?? "test"),
              onTap: () {
                setState(() {
                  print(predictions[index].description);
                  Navigator.pop(context);
                  locationsVisible = false;

                  customMapcontroller.updateDestination(
                      predictions[index].placeId!,
                      predictions[index].description!);
                });
              },
            );
          },
        ),
      )),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  // void getDetils(String placeId) async {
  //   var result = await googlePlace.details.get(placeId);
  //   if (result != null && result.result != null && mounted) {
  //     setState(() {
  //       loading = false;
  //       detailsResult = result.result!;
  //     });
  //   }
  //}
}
