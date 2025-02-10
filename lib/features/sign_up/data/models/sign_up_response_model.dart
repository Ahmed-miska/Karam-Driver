class SignUpResponseModel {
  final int responseCode;
  final String responseStatus;
  final String responseMessage;
  final ResponseData? responseData;

  SignUpResponseModel({
    required this.responseCode,
    required this.responseStatus,
    required this.responseMessage,
    required this.responseData,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      responseCode: json["response_code"],
      responseStatus: json["response_status"],
      responseMessage: json["response_message"],
      responseData: json["response_data"] is Map<String, dynamic> ? ResponseData.fromJson(json["response_data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_status": responseStatus,
        "response_message": responseMessage,
        "response_data": responseData?.toJson(),
      };
}

class ResponseData {
  final String id;
  final dynamic username;
  final String fullName;
  final String mobile;
  final String userType;
  final String status;
  final String active;
  final dynamic lastActive;
  final dynamic createdAt;
  final dynamic updatedAt;
  final String groupId;
  final dynamic deletedAt;
  final String isDeleted;
  final dynamic statusMessage;
  final String pass;
  final String activationCode;

  ResponseData({
    required this.id,
    required this.username,
    required this.fullName,
    required this.mobile,
    required this.userType,
    required this.status,
    required this.active,
    required this.lastActive,
    required this.createdAt,
    required this.updatedAt,
    required this.groupId,
    required this.deletedAt,
    required this.isDeleted,
    required this.statusMessage,
    required this.pass,
    required this.activationCode,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
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
    );
  }

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
      };
}
