// To parse this JSON data, do
//
//     final signInResponseModel = signInResponseModelFromJson(jsonString);

import 'dart:convert';

SignInResponseModel signInResponseModelFromJson(String str) => SignInResponseModel.fromJson(json.decode(str));

String signInResponseModelToJson(SignInResponseModel data) => json.encode(data.toJson());

class SignInResponseModel {
  int? responseCode;
  String? responseStatus;
  String? responseMessage;
  ResponseData? responseData;

  SignInResponseModel({
    this.responseCode,
    this.responseStatus,
    this.responseMessage,
    this.responseData,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) => SignInResponseModel(
        responseCode: json["response_code"],
        responseStatus: json["response_status"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? null : ResponseData.fromJson(json["response_data"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_status": responseStatus,
        "response_message": responseMessage,
        "response_data": responseData?.toJson(),
      };
}

class ResponseData {
  User? user;
  String? token;

  ResponseData({
    this.user,
    this.token,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  String? id;
  String? username;
  String? fullName;
  String? mobile;
  String? userType;
  String? status;
  String? active;
  String? lastActive;
  String? createdAt;
  dynamic updatedAt;
  String? groupId;
  dynamic deletedAt;
  String? isDeleted;
  dynamic statusMessage;
  String? pass;
  String? activationCode;
  String? avatar;
  String? showCommercialNotifications;
  String? clientLocation;
  String? addressId;

  User({
    this.id,
    this.username,
    this.fullName,
    this.mobile,
    this.userType,
    this.status,
    this.active,
    this.lastActive,
    this.createdAt,
    this.updatedAt,
    this.groupId,
    this.deletedAt,
    this.isDeleted,
    this.statusMessage,
    this.pass,
    this.activationCode,
    this.avatar,
    this.showCommercialNotifications,
    this.clientLocation,
    this.addressId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        mobile: json["mobile"],
        userType: json["user_type"],
        status: json["status"],
        active: json["active"],
        lastActive: json["last_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        groupId: json["group_id"],
        deletedAt: json["deleted_at"],
        isDeleted: json["is_deleted"],
        statusMessage: json["status_message"],
        pass: json["pass"],
        activationCode: json["activation_code"],
        avatar: json["avatar"],
        showCommercialNotifications: json["show_commercial_notifications"],
        clientLocation: json["client_location"],
        addressId: json["address_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "mobile": mobile,
        "user_type": userType,
        "status": status,
        "active": active,
        "last_active": lastActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "group_id": groupId,
        "deleted_at": deletedAt,
        "is_deleted": isDeleted,
        "status_message": statusMessage,
        "pass": pass,
        "activation_code": activationCode,
        "avatar": avatar,
        "show_commercial_notifications": showCommercialNotifications,
        "client_location": clientLocation,
        "address_id": addressId,
      };
}
