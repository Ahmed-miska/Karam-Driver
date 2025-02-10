class ActiveUserRequestModel {
  String userId;
  String actvationCode;
  String uuid;

  ActiveUserRequestModel({
    required this.userId,
    required this.actvationCode,
    required this.uuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'activation_code': actvationCode,
      'uuid': uuid
    };
  }
}
