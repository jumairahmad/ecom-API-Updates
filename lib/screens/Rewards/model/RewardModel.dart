class RewardModel {
  double? redeemed;
  double? earned;
  double? balance;

  RewardModel({this.redeemed, this.earned, this.balance});

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    final redeemed = json['redeemed'];
    final earned = json['earned'];
    final balance = json['balance'];

    return RewardModel(
      redeemed: redeemed,
      earned: earned,
      balance: balance,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['redeemed'] = redeemed;
    data['earned'] = earned;
    data['balance'] = balance;

    return data;
  }
}
