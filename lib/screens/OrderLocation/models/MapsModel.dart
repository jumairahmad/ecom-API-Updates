import 'package:e_commerce/screens/OrderLocation/helpers/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsModel {
  CameraPosition initialCameraPosition;
  Marker origin;
  Marker destination;
  LatLng pos;
  Directions info;
  String googleAPiKey;

  MapsModel(this.initialCameraPosition, this.origin, this.destination, this.pos,
      this.info, this.googleAPiKey);
}

class StoreLocations {
  int storeID;
  bool selected;
  String address;
  String deliveryTime;
  double lat;
  double lng;
  String storeTitle;

  StoreLocations(this.storeID, this.selected, this.address, this.deliveryTime,
      this.lat, this.lng, this.storeTitle);

  StoreLocations.fromJson(Map<String, dynamic> data)
      : storeID = data['storeID'],
        selected = data['selected'],
        address = data['address'],
        deliveryTime = data['deliveryTime'],
        lat = data['lat'],
        lng = data['lng'],
        storeTitle = data['storeTitle'];
}
