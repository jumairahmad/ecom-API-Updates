class BrandAuth {
  String? brandimage;
  String? bRANDNAME;
  String? bRANDSPLASHIMAGE;
  List<Locations>? locations;

  BrandAuth(
      {this.brandimage, this.bRANDNAME, this.bRANDSPLASHIMAGE, this.locations});

  factory BrandAuth.fromJson(Map<String, dynamic> json) {
    final locations = <Locations>[];
    final brandimage = json['brandimage'];
    final bRANDNAME = json['BRANDNAME'];
    final bRANDSPLASHIMAGE = json['BRANDSPLASHIMAGE'];
    if (json['locations'] != null) {
      json['locations'].forEach((v) {
        locations.add(Locations.fromJson(v));
      });
    }

    return BrandAuth(
        brandimage: brandimage,
        bRANDNAME: bRANDNAME,
        bRANDSPLASHIMAGE: bRANDSPLASHIMAGE,
        locations: locations);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brandimage'] = brandimage;
    data['BRANDNAME'] = bRANDNAME;
    data['BRANDSPLASHIMAGE'] = bRANDSPLASHIMAGE;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  String? locationid;
  String? locationname;
  bool? selected;
  double? distance;

  Locationaddress? locationaddress;
  Locationfeatures? locationfeatures;
  Locationcontact? locationcontact;

  Locations(
      {this.locationid,
      this.locationname,
      this.locationaddress,
      this.selected,
      this.distance,
      this.locationfeatures,
      this.locationcontact});

  factory Locations.fromJson(Map<String, dynamic> json) {
    final locationid = json['locationID'].toString();
    final locationname = json['locationName'];
    final selected = json['selected'] ?? false;
    final distance = json['selected'] ?? 00.00;
    final locationaddress = json['locationAddress'] != null
        ? Locationaddress.fromJson(json['locationAddress'])
        : null;
    final locationfeatures = json['locationFeatures'] != null
        ? Locationfeatures.fromJson(json['locationFeatures'])
        : null;
    final locationcontact = json['locationContact'] != null
        ? Locationcontact.fromJson(json['locationContact'])
        : null;

    return Locations(
        locationid: locationid,
        locationname: locationname,
        selected: selected,
        distance: distance,
        locationaddress: locationaddress,
        locationfeatures: locationfeatures,
        locationcontact: locationcontact);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locationID'] = locationid;
    data['locationName'] = locationname;
    if (locationaddress != null) {
      data['locationAddress'] = locationaddress!.toJson();
    }
    if (locationfeatures != null) {
      data['locationFeatures'] = locationfeatures!.toJson();
    }
    if (locationcontact != null) {
      data['locationContact'] = locationcontact!.toJson();
    }
    return data;
  }
}

class Locationaddress {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? locationlat;
  String? locationlong;

  Locationaddress(
      {this.address,
      this.city,
      this.state,
      this.zip,
      this.locationlat,
      this.locationlong});

  factory Locationaddress.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    final city = json['city'];
    final state = json['state'];
    final zip = json['zip'];
    final locationlat = json['locationlat'];
    final locationlong = json['locationlong'];

    return Locationaddress(
        address: address,
        city: city,
        state: state,
        zip: zip,
        locationlat: locationlat,
        locationlong: locationlong);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['locationlat'] = locationlat;
    data['locationlong'] = locationlong;
    return data;
  }
}

class Locationfeatures {
  String? delivery;
  String? pickup;
  String? curbside;
  bool? curbSideEnabled;

  Locationfeatures(
      {this.delivery, this.pickup, this.curbside, this.curbSideEnabled});

  factory Locationfeatures.fromJson(Map<String, dynamic> json) {
    final delivery = json['Delivery'];
    final pickup = json['Pickup'];
    final curbside = json['Curbside'];
    const curbsideEnabled = false;

    return Locationfeatures(
        delivery: delivery,
        pickup: pickup,
        curbside: curbside,
        curbSideEnabled: curbsideEnabled);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Delivery'] = delivery;
    data['Pickup'] = pickup;
    data['Curbside'] = curbside;
    return data;
  }
}

class Locationcontact {
  String? phone;

  Locationcontact({this.phone});

  factory Locationcontact.fromJson(Map<String, dynamic> json) {
    final phone = json['phone'];

    return Locationcontact(phone: phone);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    return data;
  }
}
