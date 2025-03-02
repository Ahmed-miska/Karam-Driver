class SignUpRequestModel {
  final String fullName;
  final String mobile;
  final String password;

  final String deleveryCompany;
  final String address;

  SignUpRequestModel({required this.fullName, required this.mobile, required this.password, required this.deleveryCompany, required this.address});

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "mobile": mobile,
        "password": password,
        "delivery_company": deleveryCompany,
        "address": address,
      };
}
