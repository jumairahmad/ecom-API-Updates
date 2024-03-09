class OTPModel {
  String? otp;
  String? phoneNumber;
  bool? isPhoneVerified;
  int? activeUntil;
  int? storeID;

  OTPModel(
      {this.otp,
      this.phoneNumber,
      this.isPhoneVerified,
      this.activeUntil,
      this.storeID});

  OTPModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    phoneNumber = json['phoneNumber'];
    isPhoneVerified = json['isPhoneVerified'];
    activeUntil = json['activeUntil'];
    storeID = json['storeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['phoneNumber'] = phoneNumber;
    data['isPhoneVerified'] = isPhoneVerified;
    data['activeUntil'] = activeUntil;
    data['storeID'] = storeID;
    return data;
  }
}
