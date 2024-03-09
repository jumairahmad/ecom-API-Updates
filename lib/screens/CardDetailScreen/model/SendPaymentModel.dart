class SendPaymentModel {
  String? cardNumber;
  String? issuingCountry;
  String? expiryDate;
  String? securityCode;
  String? cardHolder;
  String? amount;
  bool? isDetailSave;

  SendPaymentModel(
      {this.cardNumber,
      this.issuingCountry,
      this.expiryDate,
      this.securityCode,
      this.cardHolder,
      this.amount,
      this.isDetailSave});

  SendPaymentModel.fromJson(Map<String, dynamic> json) {
    cardNumber = json['CardNo'];
    issuingCountry = json['IssuingCountry'];
    expiryDate = json['ExpiryDate'];
    securityCode = json['CVV'];
    cardHolder = json['CardHolder'];
    amount = json['Amount'];
    isDetailSave = json['IsDetailSave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CardNo'] = cardNumber;
    data['IssuingCountry'] = issuingCountry;
    data['ExpiryDate'] = expiryDate;
    data['CVV'] = securityCode;
    data['CardHolder'] = cardHolder;
    data['Amount'] = amount;
    data['IsDetailSave'] = isDetailSave;
    return data;
  }
}
