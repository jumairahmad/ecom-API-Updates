class LoyaltyHistoryModel {
  String price;
  String title;
  String idNumber;
  String date;
  String time;
  LoyaltyHistoryModel(
      {required this.price,
      required this.title,
      required this.idNumber,
      required this.date,
      required this.time});
}

class LoyaltyHistoryModel1 {
  List<EarnedHistoryList>? earnedHistoryList;
  List<RedeemedHistoryList>? redeemedHistoryList;
  LoyaltyHistoryModel1({this.earnedHistoryList, this.redeemedHistoryList});

  factory LoyaltyHistoryModel1.fromJson(Map<String, dynamic> json) =>
      LoyaltyHistoryModel1(
        earnedHistoryList: List<EarnedHistoryList>.from(
            json["earnedHistoryList"]
                .map((x) => EarnedHistoryList.fromJson(x))),
        redeemedHistoryList: List<RedeemedHistoryList>.from(
            json["redeemedHistoryList"]
                .map((x) => RedeemedHistoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "earnedHistoryList":
            List<dynamic>.from(earnedHistoryList!.map((x) => x.toJson())),
        "redeemedHistoryList":
            List<dynamic>.from(redeemedHistoryList!.map((x) => x.toJson())),
      };
}

class EarnedHistoryList {
  String? storeName;
  String? couponCode;
  double? couponAmount;
  String? expireDate;
  String? expireTime;

  EarnedHistoryList(
      {this.storeName,
      this.couponCode,
      this.couponAmount,
      this.expireDate,
      this.expireTime});

  factory EarnedHistoryList.fromJson(Map<String, dynamic> json) {
    final storeName = json['storeName'];
    final couponCode = json['couponCode'];
    final couponAmount = json['couponAmount'];
    final expireDate = json['expireDate'];
    final expireTime = json['expireTime'];

    return EarnedHistoryList(
        storeName: storeName,
        couponCode: couponCode,
        couponAmount: couponAmount,
        expireDate: expireDate,
        expireTime: expireTime);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['couponCode'] = couponCode;
    data['couponAmount'] = couponAmount;
    data['expireDate'] = expireDate;
    data['expireTime'] = expireTime;

    return data;
  }
}

class RedeemedHistoryList {
  String? storeName;
  String? couponCode;
  double? couponAmount;
  String? usedDate;
  String? usedTime;

  RedeemedHistoryList(
      {this.storeName,
      this.couponCode,
      this.couponAmount,
      this.usedDate,
      this.usedTime});

  factory RedeemedHistoryList.fromJson(Map<String, dynamic> json) {
    final storeName = json['storeName'];
    final couponCode = json['couponCode'];
    final couponAmount = json['couponAmount'];
    final usedDate = json['usedDate'];
    final usedTime = json['usedTime'];

    return RedeemedHistoryList(
        storeName: storeName,
        couponCode: couponCode,
        couponAmount: couponAmount,
        usedDate: usedDate,
        usedTime: usedTime);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['couponCode'] = couponCode;
    data['couponAmount'] = couponAmount;
    data['usedDate'] = usedDate;
    data['usedTime'] = usedTime;

    return data;
  }
}
