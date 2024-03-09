class GetUserCardsPaymentDetailsModel {
  String? success;
  String? failreason;
  List<Successcode>? successcode;

  GetUserCardsPaymentDetailsModel(
      {this.success, this.failreason, this.successcode});

  GetUserCardsPaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    failreason = json['failreason'];
    if (json['successcode'] != null) {
      successcode = <Successcode>[];
      json['successcode'].forEach((v) {
        successcode!.add(Successcode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['failreason'] = failreason;
    if (successcode != null) {
      data['successcode'] = successcode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Successcode {
  String? cardNumber;
  String? issuingCountry;
  String? expiryDate;
  String? securityCode;

  Successcode(
      {this.cardNumber,
      this.issuingCountry,
      this.expiryDate,
      this.securityCode});

  Successcode.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    issuingCountry = json['issuingCountry'];
    expiryDate = json['expiryDate'];
    securityCode = json['securityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardNumber'] = cardNumber;
    data['issuingCountry'] = issuingCountry;
    data['expiryDate'] = expiryDate;
    data['securityCode'] = securityCode;
    return data;
  }
}
