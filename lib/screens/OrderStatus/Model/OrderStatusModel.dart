class OrderStatusModel {
  String? orderStatus;
  String? orderDateTime;

  OrderStatusModel({this.orderStatus, this.orderDateTime});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    orderStatus = json['orderStatus'];
    orderDateTime = json['orderDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderStatus'] = orderStatus;
    data['orderDateTime'] = orderDateTime;
    return data;
  }
}
