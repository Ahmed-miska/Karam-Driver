class ActiveForgetUserRequestModel {
 final String newPassword;
 final String activationCode;
 final String mobile;

  ActiveForgetUserRequestModel({required this.newPassword, required this.activationCode, required this.mobile});

  Map<String, dynamic> toJson() {
    return {
      'new_password': newPassword,
      'activation_code': activationCode,
      'mobile': mobile  
    };
  }
 
}