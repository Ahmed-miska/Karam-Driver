class RenewPasswordRequestModel {
  final String userId;
  final String oldPassword;
  final String newPassword;
  final String mobile;

  RenewPasswordRequestModel({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
    required this.mobile,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'old_password': oldPassword,
        'new_password': newPassword,
        'mobile': mobile,
      };
}
