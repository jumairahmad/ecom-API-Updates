// class AuthDataObject {
//   String? token;
//   String? brandid;
//   String? appToken;
//   String? locationid;
//   String? username;

//   AuthDataObject(
//       {this.token,
//       this.brandid,
//       this.appToken,
//       this.locationid,
//       this.username});

//   factory AuthDataObject.fromJson(Map<String, dynamic> json) {
//     final token = json['token'];
//     final brandid = json['brandid'];
//     final appToken = json['AppToken'];
//     final locationid = json['locationid'];
//     final username = json['username'];

//     return AuthDataObject(
//         token: token,
//         brandid: brandid,
//         appToken: appToken,
//         locationid: locationid,
//         username: username);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['token'] = token;
//     data['brandid'] = brandid;
//     data['AppToken'] = appToken;
//     data['locationid'] = locationid;
//     data['username'] = username;
//     return data;
//   }
// }

class Action {
  String? name;
  dynamic contents;

  Action({this.name, this.contents});

  factory Action.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final contents = json['contents'];
    return Action(name: name, contents: contents);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['contents'] = contents;
    return data;
  }
}

class ApiResponse {
  Action? action;
  Response? response;

  ApiResponse({this.action, this.response});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    final action =
        json['action'] != null ? Action.fromJson(json['action']) : null;
    final response =
        json['response'] != null ? Response.fromJson(json['response']) : null;

    return ApiResponse(action: action, response: response);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (action != null) {
      data['action'] = action!.toJson();
    }
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  String? success;
  String? failreason;
  dynamic successcode;

  Response({this.success, this.failreason, this.successcode});

  factory Response.fromJson(Map<String, dynamic> json) {
    final success = json['success'];
    final failreason = json['failreason'];
    final successcode = json['successcode'];

    return Response(
        success: success, failreason: failreason, successcode: successcode);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['failreason'] = failreason;
    if (successcode != null) {
      data['successcode'] = successcode!.toJson();
    }
    return data;
  }
}

class ApiHeaders {
  String? token;
  String? brandid;
  String? appToken;
  String? locationid;
  String? userphone;

  ApiHeaders(
      {this.token,
      this.brandid,
      this.appToken,
      this.locationid,
      this.userphone});

  factory ApiHeaders.fromJson(Map<String, dynamic> json) {
    final token = json['token'];
    final brandid = json['BrandId'];
    final appToken = json['AppToken'];
    final locationid = json['Locationid'];
    final userphone = json['UserPhoneNo'];

    return ApiHeaders(
        token: token,
        brandid: brandid,
        appToken: appToken,
        locationid: locationid,
        userphone: userphone);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['BrandId'] = brandid;
    data['AppToken'] = appToken;
    data['Locationid'] = locationid;
    data['UserPhoneNo'] = userphone;
    return data;
  }
}
