/////
///
class NotificationModel {
  String? message;
  String? notificationType;
  String? notificationTime;

  NotificationModel(
      {this.message, this.notificationType, this.notificationTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    notificationType = json['notificationType'];
    notificationTime = json['notificationTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['notificationType'] = notificationType;
    data['notificationTime'] = notificationTime;
    return data;
  }
}
