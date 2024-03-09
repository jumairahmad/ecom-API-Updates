// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors, constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_collection_literals, non_constant_identifier_names

import 'dart:ui' as ui;

import 'dart:typed_data';

import 'package:e_commerce/Widgets/Widgets.dart';
import 'package:e_commerce/services/PermissionServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:e_commerce/routes.dart' as route;

class OrderTrackScreen extends StatefulWidget {
  @override
  _OrderTrackScreenState createState() => _OrderTrackScreenState();
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  Set<Marker> marker = {};

  TextEditingController txtSearchController = TextEditingController();

  late DetailsResult detailsResult;
  late GoogleMapController mapController;

  Set<Circle> circles = Set.from([
    Circle(
        circleId: CircleId("Origin"),
        center: LatLng(25.4148, 68.3385),
        radius: 150,
        fillColor: kTxtColor,
        strokeColor: kTxtColor.withOpacity(0.2),
        strokeWidth: 10)
  ]);

  double destLatitude = 25.4041, destLongitude = 68.3362;
  double originLatitude = 25.4148, originLongitude = 68.3385;

  late GooglePlace googlePlace =
      GooglePlace("AIzaSyAwJvVMDxcDD2E5mzuXq-WCvR_Ib7GjQsc");

  late BitmapDescriptor customIcon;
  Map<MarkerId, Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  PolylinePoints polylinePoints = PolylinePoints();
  late Uint8List markerIcon;
  late Uint8List markerDestinationIcon;
  late TabController tabController;
  @override
  void initState() {
    PermissionService.getLocationService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PermissionService.getLocationService();
    void btnClose_onPressed() {
      Get.toNamed(route.homePage);
    }

    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: getPageAppBar(context, 'Track Order', btnClose_onPressed, () {
        Navigator.pop(context);
      }, Colors.transparent),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(originLatitude, originLongitude), zoom: 14),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
            circles: circles,
          ),
          Positioned(
              top: 200,
              left: 310,
              child: FloatingActionButton(
                  elevation: 0.0,
                  child: Icon(
                    Icons.my_location,
                    color: Colors.black,
                    size: 40,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {})),
          Positioned(
            top: 280,
            left: 310,
            child: FloatingActionButton(
              elevation: 0.0,
              child: Icon(Icons.chat_rounded),
              backgroundColor: kTxtColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 200,
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
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: kTxtColor,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: kTxtColor, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0), //or 15.0
                    child: Container(
                        height: 45,
                        width: 55,
                        color: Color(0xffFF0E58),
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.fill,
                        )),
                  ),
                  title: Transform.translate(
                    offset: Offset(
                      0,
                      0,
                    ),
                    child: Text(
                      "Helmon Smit h",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  selected: true,
                  subtitle: Transform.translate(
                    offset: Offset(
                      0,
                      0,
                    ),
                    child: Text(
                      "Rider",
                      style: TextStyle(color: kTextGreyColor),
                    ),
                  ),
                  trailing: SizedBox(
                    height: 45,
                    width: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      side: BorderSide(color: Colors.red)))),
                      child: Icon(Icons.call),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  addMarker(LatLng position, String id, BitmapDescriptor descriptor,
      String title, String subTitle, double rotation, ui.Offset anchor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: descriptor,
        position: position,
        rotation: rotation,
        anchor: anchor,
        infoWindow: InfoWindow(title: title, snippet: subTitle));
    markers[markerId] = marker;

    setState(() {
      markers[markerId] = marker;
    });
  }

  updateMarker(MarkerId id, LatLng pos) {
    final marker =
        markers.values.toList().firstWhere((item) => item.markerId == id);
    Marker _marker = Marker(
      markerId: marker.markerId,
      position: pos,
      icon: marker.icon,
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        geodesic: true,
        width: 4,
        polylineId: id,
        color: kTxtColor,
        points: polylineCoordinates);
    setState(() {
      polylines[id] = polyline;
    });
  }

  onMapCreated(GoogleMapController controller) async {
    markerDestinationIcon =
        await getBytesFromAsset('assets/images/mapDestinationMarker.png', 150);
    addMarker(
      LatLng(destLatitude, destLongitude),
      "destination",
      BitmapDescriptor.fromBytes(markerDestinationIcon),
      "Drop",
      "Reduction at the designation",
      45,
      ui.Offset(0.5, 0.3),
    );

    markerIcon =
        await getBytesFromAsset('assets/images/mapOriginMarker.png', 50);
    addMarker(
      LatLng(originLatitude, originLongitude),
      "origin",
      BitmapDescriptor.fromBytes(markerIcon),
      "Pick up",
      "Your pickup location is here",
      0,
      ui.Offset(0.5, 0.5),
    );

    await getPolyline("Wadhu Wah Gate, Qasimabad, Hyderabad", "");

    mapController = controller;

    rootBundle.loadString('assets/map_style.json').then((String mapStyle) {
      mapController.setMapStyle(mapStyle);
    });
  }

  getPolyline(String loc, String placeId) async {
    if (placeId.isNotEmpty) {
      var result1 = await googlePlace.details.get(placeId);

      if (result1 != null && result1.result != null) {
        detailsResult = result1.result!;
        destLatitude = detailsResult.geometry!.location!.lat!;
        destLongitude = detailsResult.geometry!.location!.lng!;
      }
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyAwJvVMDxcDD2E5mzuXq-WCvR_Ib7GjQsc",
        PointLatLng(originLatitude, originLongitude),
        PointLatLng(destLatitude, destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: loc)]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      addPolyLine();
    }

    // updateMarker(MarkerId("destination"), LatLng(destLatitude, destLongitude));
  }
}
