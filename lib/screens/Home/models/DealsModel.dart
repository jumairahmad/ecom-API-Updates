class DealsModel {
  String? dealid;
  String? dealname;
  String? image;
  String? odditemdiscount;
  String? discounttype;
  List<Dealrules>? dealrules;

  DealsModel({
    this.dealid,
    this.dealname,
    this.image,
    this.odditemdiscount,
    this.discounttype,
    this.dealrules,
  });

  factory DealsModel.fromJson(Map<String, dynamic> json) {
    final dealid = json['dealid'];
    final dealname = json['dealname'];
    final image = json['image'];
    final odditemdiscount = json['odditemdiscount'];
    final discounttype = json['discounttype'];
    final dealrules = <Dealrules>[];
    if (json['dealrules'] != null) {
      json['dealrules'].forEach((v) {
        dealrules.add(Dealrules.fromJson(v));
      });
    }

    return DealsModel(
      dealid: dealid,
      dealname: dealname,
      image: image,
      odditemdiscount: odditemdiscount,
      discounttype: discounttype,
      dealrules: dealrules,
    );
  }
  Map<String, dynamic> toJson() => {
        "dealid": dealid,
        "dealname": dealname,
        "image": image,
        "odditemdiscount": odditemdiscount,
        "discounttype": discounttype,
        "dealrules": List<dynamic>.from(dealrules!.map((x) => x.toJson())),
      };
}

class Dealrules {
  String? qty;
  String? priceeach;

  Dealrules({this.qty, this.priceeach});

  factory Dealrules.fromJson(Map<String, dynamic> json) {
    final qty = json['qty'];
    final priceeach = json['priceeach'];

    return Dealrules(
      qty: qty,
      priceeach: priceeach,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['priceeach'] = priceeach;
    return data;
  }
}
