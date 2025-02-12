class SignUpRequestModel {
  final String fullName;
  final String mobile;
  final String password;
  final String address;
  final String nearstPoint;
  final String? location;
  final String areaID;
  final String userType = '3';

  SignUpRequestModel({
    required this.fullName,
    required this.mobile,
    required this.password,
    required this.address,
    required this.nearstPoint,
    this.location,
    required this.areaID,
  });

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "mobile": mobile,
        "password": password,
        "address": address,
        "location": location,
        "area_id": areaID,
        "user_type": userType,
        "nearest_reference_point":nearstPoint
      };
}
