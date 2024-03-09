// ignore_for_file: prefer_collection_literals

import 'package:e_commerce/screens/SingleItem/models/IngredientModel.dart';

class ItemsResult {
  String? itemcount;
  List<ItemModel>? items;

  ItemsResult({this.itemcount, this.items});

  ItemsResult.fromJson(Map<String, dynamic> json) {
    itemcount = json['itemcount'];
    if (json['items'] != null) {
      items = <ItemModel>[];
      json['items'].forEach((v) {
        items!.add(ItemModel.fromJson(v));
      });
    }
  }
}

class ItemModel {
  String? id;
  String? upc;
  String? name;
  String? regularprice;
  String? onspecial;
  String? specialprice;
  String? specialexpires;
  String? specialstarts;
  String? specialtype;
  String? specialID;
  String? contents;
  String? size;
  String? image;
  String? quantity;
  String? dealid;
  String? hasIngredients;
  bool? isItemAddon;

  ItemModel(
      {this.id,
      this.upc,
      this.name,
      this.regularprice,
      this.onspecial,
      this.specialprice,
      this.specialexpires,
      this.specialstarts,
      this.specialtype,
      this.specialID,
      this.contents,
      this.size,
      this.image,
      this.quantity,
      this.dealid,
      this.hasIngredients,
      this.isItemAddon});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final upc = json['upc'];
    final name = json['name'];
    final regularprice = json['regularprice'];
    final onspecial = json['onspecial'];
    final specialprice = json['specialprice'];
    final specialexpires = json['specialexpires'];
    final specialstarts = json['specialstarts'];
    final specialtype = json['specialtype'];
    final specialID = json['specialID'];
    final contents = json['contents'];
    final size = json['size'];
    final image = json['image'];
    final quantity = json['quantity'] ?? "1";
    final dealid = json['dealid'];
    const hasIngredients = "false";
    final isItemAddon = json['isItemAddon'];

    return ItemModel(
      id: id,
      upc: upc,
      name: name,
      regularprice: regularprice,
      onspecial: onspecial,
      specialprice: specialprice,
      specialexpires: specialexpires,
      specialstarts: specialstarts,
      specialtype: specialtype,
      specialID: specialID,
      contents: contents,
      size: size,
      image: image,
      quantity: quantity,
      dealid: dealid,
      hasIngredients: hasIngredients,
      isItemAddon: isItemAddon,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['upc'] = upc;
    data['name'] = name;
    data['regularprice'] = regularprice;
    data['onspecial'] = onspecial;
    data['specialprice'] = specialprice;
    data['specialexpires'] = specialexpires;
    data['specialstarts'] = specialstarts;
    data['specialtype'] = specialtype;
    data['specialID'] = specialID;
    data['contents'] = contents;
    data['size'] = size;
    data['image'] = image;
    data['quantity'] = quantity;
    data['isItemAddon'] = isItemAddon;
    return data;
  }
}
