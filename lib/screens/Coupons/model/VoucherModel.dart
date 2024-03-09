class VoucherModel {
  String? id;
  String? code;
  String? desc;
  String? discount;
  String? startDate;
  String? endDate;
  String? isValid;

  VoucherModel({
    this.id,
    this.code,
    this.desc,
    this.discount,
    this.startDate,
    this.endDate,
    this.isValid,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final code = json['code'];
    final desc = json['desc'];
    final discount = json['discount'];
    final startDate = json['startDate'];
    final endDate = json['endDate'];
    final isValid = json['isValid'];

    return VoucherModel(
      id: id,
      code: code,
      desc: desc,
      discount: discount,
      startDate: startDate,
      endDate: endDate,
      isValid: isValid,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['desc'] = desc;
    data['discount'] = discount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['isValid'] = isValid;

    return data;
  }
}
