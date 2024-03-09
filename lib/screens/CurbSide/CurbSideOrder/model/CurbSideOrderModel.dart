class CurbSideOrderModel {
  String? orderID;
  String? curbSideParkingID;
  String? vehicleColor;
  String? vehicleType;
  String? vehicleMakeAndModel;

  CurbSideOrderModel(
      {this.orderID,
      this.curbSideParkingID,
      this.vehicleColor,
      this.vehicleType,
      this.vehicleMakeAndModel});

  CurbSideOrderModel.fromJson(Map<String, dynamic> json) {
    orderID = json['OrderID'];
    curbSideParkingID = json['CurbSideParkingID'];
    vehicleColor = json['VehicleColor'];
    vehicleType = json['VehicleType'];
    vehicleMakeAndModel = json['VehicleMakeAndModel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OrderID'] = orderID;
    data['CurbSideParkingID'] = curbSideParkingID;
    data['VehicleColor'] = vehicleColor;
    data['VehicleType'] = vehicleType;
    data['VehicleMakeAndModel'] = vehicleMakeAndModel;
    return data;
  }
}
