class AddressModel {
  int? id;
  String? label;
  String? address;
  String? city;
  String? state;
  String? zip;
  String? locationLat;
  String? locationLong;
  bool? isDefault;
  String? contactNo;

  AddressModel(
      {this.id,
      this.label,
      this.address,
      this.city,
      this.state,
      this.zip,
      this.locationLat,
      this.locationLong,
      this.isDefault,
      this.contactNo});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    locationLat = json['locationLat'];
    locationLong = json['locationLong'];
    isDefault = json['isDefault'];
    contactNo = json['contactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['locationLat'] = locationLat.toString();
    data['locationLong'] = locationLong.toString();
    data['isDefault'] = isDefault;
    data['contactNo'] = contactNo;
    return data;
  }

  Map<String, dynamic> toJsonCreate() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['label'] = label;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['locationLat'] = locationLat.toString();
    data['locationLong'] = locationLong.toString();
    data['isDefault'] = isDefault;
    data['contactNo'] = contactNo;
    return data;
  }
}
