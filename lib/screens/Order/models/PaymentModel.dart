class PaymentModel {
  String? cardHolder;
  String? cardNumber;
  String? cVV;
  String? expiryDate;
  String? cardType;
  String? isDefault;

  PaymentModel(
      {this.cardHolder,
      this.cardNumber,
      this.cVV,
      this.expiryDate,
      this.cardType,
      this.isDefault});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    cardHolder = json['cardHolder'];
    cardNumber = json['cardNumber'];
    cVV = json['cVV'];
    expiryDate = json['expiryDate'];
    cardType = json['cardType'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardHolder'] = cardHolder;
    data['cardNumber'] = cardNumber;
    data['cVV'] = cVV;
    data['expiryDate'] = expiryDate;
    data['cardType'] = cardType;
    data['isDefault'] = isDefault;
    return data;
  }
}
