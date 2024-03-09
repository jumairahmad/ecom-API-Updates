class CouponModel {
  int? couponIssuedID;
  String? storeName;
  String? couponCode;
  double? couponAmount;
  String? couponDate;
  String? couponMessage;

  CouponModel(
      {this.couponIssuedID,
      this.storeName,
      this.couponCode,
      this.couponAmount,
      this.couponDate,
      this.couponMessage});

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    final couponIssuedID = json['couponIssuedID'];
    final storeName = json['storeName'];
    final couponCode = json['couponCode'];
    final couponAmount = json['couponAmount'];
    final couponDate = json['couponDate'];
    final couponMessage = json['couponMessage'];

    return CouponModel(
        couponIssuedID: couponIssuedID,
        storeName: storeName,
        couponCode: couponCode,
        couponAmount: couponAmount,
        couponDate: couponDate,
        couponMessage: couponMessage);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['couponIssuedID'] = couponIssuedID;
    data['storeName'] = storeName;
    data['couponCode'] = couponCode;
    data['couponAmount'] = couponAmount;
    data['couponDate'] = couponDate;
    data['couponMessage'] = couponMessage;

    return data;
  }
}
