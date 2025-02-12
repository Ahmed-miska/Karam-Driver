class ClientSearchResponseModel {
  int? responseCode;
  String? responseMessage;
  ClientSearchResponseData? responseData;

  ClientSearchResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory ClientSearchResponseModel.fromJson(Map<String, dynamic> json) => ClientSearchResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? null : ClientSearchResponseData.fromJson(json["response_data"]),
      );

}

class ClientSearchResponseData {
  String? orderCode;
  String? mobile;
  String? fullName;
  String? title;
  String? address;
  String? orderId;
  dynamic location;
  String? areaName;
  String? doorPhoto;

  ClientSearchResponseData({
    this.orderCode,
    this.mobile,
    this.fullName,
    this.title,
    this.address,
    this.orderId,
    this.location,
    this.areaName,
    this.doorPhoto,
  });

  factory ClientSearchResponseData.fromJson(Map<String, dynamic> json) => ClientSearchResponseData(
        orderCode: json["order_code"],
        mobile: json["mobile"],
        fullName: json["full_name"],
        title: json["title"],
        address: json["address"],
        orderId: json["order_id"],
        location: json["location"],
        areaName: json["area_name"],
        doorPhoto: json["door_photo"],
      );
}
