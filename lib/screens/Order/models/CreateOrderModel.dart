import 'package:e_commerce/screens/CurbSide/CurbSideOrder/model/CurbSideOrderModel.dart';
import 'package:e_commerce/screens/Order/models/PaymentModel.dart';

import 'OrderModel.dart';

class CreateOrder {
  String? orderID;
  String? userID;
  String? addressID;
  String? phoneNo;
  String? orderType;
  String? orderDateTime;
  String? orderstatus;
  String? orderSubTotalPrice;
  String? locationid;
  String? locationname;
  String? notes;
  Receipt? receipt;
  PaymentModel? accountDetail;
  CurbSideOrderModel? curbsidePickup;
  DeliveryAddress? deliveryAddress;

  CreateOrder({
    this.orderID,
    this.userID,
    this.addressID,
    this.phoneNo,
    this.orderType,
    this.orderDateTime,
    this.orderstatus,
    this.orderSubTotalPrice,
    this.locationid,
    this.locationname,
    this.notes,
    this.receipt,
    this.accountDetail,
    this.curbsidePickup,
    this.deliveryAddress,
  });

  CreateOrder.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    userID = json['userID'];
    addressID = json['AddressID'];
    phoneNo = json['phoneNo'];
    orderType = json['orderType'];
    orderDateTime = json['orderDateTime'];
    orderstatus = json['orderstatus'];
    orderSubTotalPrice = json['orderSubTotalPrice'];
    locationid = json['locationid'];
    locationname = json['locationname'];
    notes = json['notes'];

    receipt =
        (json['receipt'] != null ? Receipt.fromJson(json['receipt']) : null)!;
    accountDetail = json['accountDetail'] != null
        ? PaymentModel.fromJson(json['accountDetail'])
        : null;
    curbsidePickup = json['curbsidePickup'] != null
        ? CurbSideOrderModel.fromJson(json['curbsidePickup'])
        : null;
    deliveryAddress = json['deliveryAddress'] != null
        ? DeliveryAddress.fromJson(json['deliveryAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderID'] = orderID;
    data['userID'] = userID;
    data['AddressID'] = addressID;
    data['phoneNo'] = phoneNo;
    data['orderType'] = orderType;
    data['orderDateTime'] = orderDateTime;
    data['orderstatus'] = orderstatus;
    data['orderSubTotalPrice'] = orderSubTotalPrice;
    data['locationid'] = locationid;
    data['locationname'] = locationname;
    data['notes'] = notes;

    if (receipt != null) {
      data['receipt'] = receipt?.toJson();
    }
    if (accountDetail != null) {
      data['accountDetail'] = accountDetail?.toJson();
    }
    if (curbsidePickup != null) {
      data['curbsidePickup'] = curbsidePickup!.toJson();
    }
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }

    return data;
  }
}

class DeliveryAddress {
  String? address;
  String? city;
  String? state;
  String? stateName;
  String? zip;
  String? locationlat;
  String? locationlong;
  String? contactNo;

  DeliveryAddress(
      {this.address,
      this.city,
      this.state,
      this.stateName,
      this.zip,
      this.locationlat,
      this.locationlong,
      this.contactNo});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateName = json['stateName'];
    zip = json['zip'];
    locationlat = json['locationlat'];
    locationlong = json['locationlong'];
    contactNo = json['contactNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{}; //Map<String, dynamic>()
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateName'] = stateName;
    data['zip'] = zip;
    data['locationlat'] = locationlat;
    data['locationlong'] = locationlong;
    data['contactNo'] = contactNo;
    return data;
  }
}
