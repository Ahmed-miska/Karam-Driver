class SignInRequestModel {
  final String username;
  final String password;

  SignInRequestModel( {required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "user_login": username,
      "password": password,
    };
  }
}
