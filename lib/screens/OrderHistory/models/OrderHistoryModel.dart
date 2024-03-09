class OrderHistoryModel {
  int? orderID;
  String? locationName;
  int? totalItems;
  String? orderStatus;
  String? orderDateTime;
  double? totalAmount;

  OrderHistoryModel(
      {this.orderID,
      this.locationName,
      this.totalItems,
      this.orderStatus,
      this.orderDateTime,
      this.totalAmount});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    final orderID = json['OrderID'];
    final locationName = json['LocationName'];
    final totalItems = json['totalItems'];
    final orderStatus = json['orderStatus'];
    final orderDateTime = json['orderDateTime'];
    final totalAmount = json['totalAmount'];

    return OrderHistoryModel(
        orderID: orderID,
        locationName: locationName,
        totalItems: totalItems,
        orderDateTime: orderDateTime,
        orderStatus: orderStatus,
        totalAmount: totalAmount);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderID'] = orderID;
    data['LocationName'] = locationName;
    data['totalItems'] = totalItems;
    data['orderStatus'] = orderStatus;
    data['orderDateTime'] = orderDateTime;
    data['totalAmount'] = totalAmount;
    return data;
  }
}
