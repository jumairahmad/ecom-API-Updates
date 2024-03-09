// ignore_for_file: prefer_collection_literals

import 'package:e_commerce/screens/Coupons/model/CouponModel.dart';
import 'package:e_commerce/screens/Home/models/DealsModel.dart';
import 'package:e_commerce/screens/Home/models/ProductModel.dart';
import 'package:e_commerce/screens/SignScreen/models/UserModel.dart';
import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';

class OrderModel {
  String? orderID;
  String? orderDateTime;
  String? orderstatus;
  String? orderSubTotalPrice;
  String? locationid;
  String? locationname;
  Billingaddress? deliveryAddress;
  Receipt? receipt;

  OrderModel(
      {this.locationid,
      this.locationname,
      this.orderID,
      this.orderDateTime,
      this.orderstatus,
      this.orderSubTotalPrice,
      this.deliveryAddress,
      this.receipt});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final orderID = json['orderID'];
    final orderDateTime = json['orderDateTime'];
    final orderstatus = json['orderstatus'];
    final orderSubTotalPrice = json['orderSubTotalPrice'];
    final locationid = json['locationid'];
    final locationname = json['locationname'];
    final deliveryAddress = Billingaddress.fromJson(json['deliveryAddress']);
    final receipt = Receipt.fromJson(json["receipt"]);

    return OrderModel(
        orderID: orderID,
        orderDateTime: orderDateTime,
        orderstatus: orderstatus,
        orderSubTotalPrice: orderSubTotalPrice,
        locationid: locationid,
        locationname: locationname,
        deliveryAddress: deliveryAddress,
        receipt: receipt);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['orderID'] = orderID;
    data['orderDateTime'] = orderDateTime;
    data['orderstatus'] = orderstatus;
    data['orderSubTotalPrice'] = orderSubTotalPrice;
    data['locationid'] = locationid;
    data['locationname'] = locationname;
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress?.toJson();
    }
    data['receipt'] = receipt?.toJson();
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
  Locationaddress({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.locationlat,
    this.locationlong,
  });

  factory Locationaddress.fromJson(Map<String, dynamic> json) =>
      Locationaddress(
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        locationlat: json["locationlat"],
        locationlong: json["locationlong"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "locationlat": locationlat,
        "locationlong": locationlong,
      };
}

class Orderdetails {
  String? ordertype;
  DateTime? ordercompleteon;
  String? curbsidelocation;
  String? curbsidedroppedby;
  Orderdetails({
    this.ordertype,
    this.ordercompleteon,
    this.curbsidelocation,
    this.curbsidedroppedby,
  });

  factory Orderdetails.fromJson(Map<String, dynamic> json) => Orderdetails(
        ordertype: json["ordertype"],
        ordercompleteon: DateTime.parse(json["ordercompleteon"]),
        curbsidelocation: json["curbsidelocation"],
        curbsidedroppedby: json["curbsidedroppedby"],
      );

  Map<String, dynamic> toJson() => {
        "ordertype": ordertype,
        "ordercompleteon": ordercompleteon?.toIso8601String(),
        "curbsidelocation": curbsidelocation,
        "curbsidedroppedby": curbsidedroppedby,
      };
}

class Receipt {
  String? ordertotal;
  String? tip;
  CouponModel? coupon;
  Fees? fees;
  Tax? tax;
  List<Entry>? entries;
  Receipt({
    this.ordertotal,
    this.tip,
    this.coupon,
    this.fees,
    this.tax,
    this.entries,
  });

  Receipt.fromJson(Map<String, dynamic> json) {
    ordertotal = json['ordertotal'];
    tip = json['tip'];
    coupon = json['coupon'] != null ? CouponModel.fromJson(json['fees']) : null;
    fees = json['fees'] != null ? Fees.fromJson(json['fees']) : null;
    tax = json['tax'] != null ? Tax.fromJson(json['tax']) : null;
    if (json['entries'] != null) {
      entries = <Entry>[];
      json['entries'].forEach((v) {
        entries!.add(Entry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "ordertotal": ordertotal,
        "Tip": tip,
        "coupon": coupon?.toJson(),
        "fees": fees?.toJson(),
        "Tax": tax?.toJson(),
        "entries": List<dynamic>.from(entries!.map((x) => x.toJson())),
      };
}

class Entry {
  String? entryId;
  String? itemEntryDate;
  String? name;
  String? qty;
  String? special;
  String? regularprice;
  String? finalprice;
  String? linetotal;
  OrderDeal? deal;
  ItemModel? item;
  List<IngredientModel>? ingredients;

  Entry({
    this.entryId,
    this.itemEntryDate,
    this.name,
    this.qty,
    this.special,
    this.regularprice,
    this.finalprice,
    this.linetotal,
    this.deal,
    this.item,
    this.ingredients,
  });

  Entry.fromJson(Map<String, dynamic> json) {
    entryId = json['entryId'];
    itemEntryDate = (json["itemEntryDate"]);
    name = json['name'];
    qty = json['qty'];
    special = json['special'];
    regularprice = json['regularprice'];
    finalprice = json['finalprice'];
    linetotal = json['linetotal'];

    deal = json['deal'] != null ? OrderDeal.fromJson(json['deal']) : null;
    item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
    if (json['ingredients'] != null) {
      ingredients = <IngredientModel>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(IngredientModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['entryId'] = entryId;
    data['itemEntryDate'] = itemEntryDate;
    data['name'] = name;
    data['qty'] = qty;
    data['special'] = special;
    data['regularprice'] = regularprice;
    data['finalprice'] = finalprice;
    data['linetotal'] = linetotal;
    data['deal'] = deal;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fees {
  String? regularFee;
  String? deliveryFee;
  String? serviceFee;
  Fees({
    this.regularFee,
    this.deliveryFee,
    this.serviceFee,
  });

  factory Fees.fromJson(Map<String, dynamic> json) => Fees(
        regularFee: json["Regular Fee"],
        deliveryFee: json["Delivery Fee"],
        serviceFee: json["Service Fee"],
      );

  Map<String, dynamic> toJson() => {
        "Regular Fee": regularFee,
        "Delivery Fee": deliveryFee,
        "Service Fee": serviceFee,
      };
}

class Tax {
  String? tax1;
  String? cityTax;
  Tax({
    this.tax1,
    this.cityTax,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        tax1: json["Tax 1"],
        cityTax: json["City Tax"],
      );

  Map<String, dynamic> toJson() => {
        "Tax 1": tax1,
        "City Tax": cityTax,
      };
}

class OrderDeal {
  DealsModel? deal;
  List<ItemModel>? itemList;
  OrderDeal({this.deal, this.itemList});

  factory OrderDeal.fromJson(Map<String, dynamic> json) => OrderDeal(
        deal: DealsModel.fromJson(json["deal"]),
        itemList: List<ItemModel>.from(
            json["itemList"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deal": deal?.toJson(),
        "itemList": List<dynamic>.from(itemList!.map((x) => x.toJson())),
      };
}
