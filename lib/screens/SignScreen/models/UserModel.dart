// ignore_for_file: prefer_collection_literals

class User {
  String? userID;
  String? userfullName;
  String? firstName;
  String? lastName;
  Billingaddress? billingaddress;
  Billingaddress? deliveryaddress;
  String? userEmail;
  String? userPhone;
  String? active;
  String? customerBalance;
  String? loyaltyPoints;
  String? loyaltyUsed;
  String? token;
  bool? isPhoneVerified;

  User(
      {this.userID,
      this.userfullName,
      this.firstName,
      this.lastName,
      this.billingaddress,
      this.deliveryaddress,
      this.userEmail,
      this.userPhone,
      this.active,
      this.customerBalance,
      this.loyaltyPoints,
      this.loyaltyUsed,
      this.token,
      this.isPhoneVerified});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'].toString();
    userfullName = json['userfullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    billingaddress = Billingaddress.fromJson(json['billingAddress']);
    deliveryaddress = Billingaddress.fromJson(json['deliveryAddress']);
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    active = json['active'];
    customerBalance = json['customerBalance'];
    loyaltyPoints = json['loyaltyPoints'];
    loyaltyUsed = json['loyaltyUsed'];
    token = json['token'];
    isPhoneVerified = json['isPhoneVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userID'] = userID;
    data['userfullName'] = userfullName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    if (billingaddress != null) {
      data['billingAddress'] = billingaddress?.toJson();
    }
    if (deliveryaddress != null) {
      data['deliveryAddress'] = deliveryaddress?.toJson();
    }
    data['userEmail'] = userEmail;
    data['userPhone'] = userPhone;
    data['active'] = active;
    data['customerBalance'] = customerBalance;
    data['loyaltyPoints'] = loyaltyPoints;
    data['loyaltyUsed'] = loyaltyUsed;
    data['token'] = token;
    return data;
  }
}

class Billingaddress {
  String? address;
  String? city;
  String? state;
  String? stateName;
  String? zip;
  String? locationlat;
  String? locationlong;

  Billingaddress(
      {this.address,
      this.city,
      this.state,
      this.zip,
      this.locationlat,
      this.locationlong});

  Billingaddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateName = json['stateName'];
    zip = json['zip'];
    locationlat = json['locationlat'];
    locationlong = json['locationlong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateName'] = stateName;
    data['zip'] = zip;
    data['locationlat'] = locationlat;
    data['locationlong'] = locationlong;
    return data;
  }
}
