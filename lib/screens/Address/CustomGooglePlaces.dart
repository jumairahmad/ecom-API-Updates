// ignore_for_file: avoid_print, file_names, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import 'Controller/AddressController.dart';

class CustomGoogleSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() {
    return _LocationSearchState();
  }
}

class _LocationSearchState extends State<CustomGoogleSearch> {
  TextEditingController controller = TextEditingController(text: "");

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
    final newAddressController = Get.put(NewAddressController());
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
                  Navigator.pop(context);
                  locationsVisible = false;

                  newAddressController.updateDestination(
                      predictions[index].placeId!,
                      predictions[index].description!);
                  newAddressController.update();
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
}
