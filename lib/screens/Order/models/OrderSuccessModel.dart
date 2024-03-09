class OrderSuccessModel {
  int? orderID;
  String? orderDateTime;

  OrderSuccessModel({this.orderID, this.orderDateTime});

  OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    orderDateTime = json['orderDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderID'] = orderID;
    data['orderDateTime'] = orderDateTime;
    return data;
  }
}
