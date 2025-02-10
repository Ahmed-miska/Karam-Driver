// To parse this JSON data, do
//
//     final orderStatusResponseModel = orderStatusResponseModelFromJson(jsonString);

import 'dart:convert';

OrderStatusResponseModel orderStatusResponseModelFromJson(String str) => OrderStatusResponseModel.fromJson(json.decode(str));

String orderStatusResponseModelToJson(OrderStatusResponseModel data) => json.encode(data.toJson());

class OrderStatusResponseModel {
  int? responseCode;
  String? responseMessage;
  List<OrderStatusModel>? responseData;

  OrderStatusResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory OrderStatusResponseModel.fromJson(Map<String, dynamic> json) => OrderStatusResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? [] : List<OrderStatusModel>.from(json["response_data"]!.map((x) => OrderStatusModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "response_data": responseData == null ? [] : List<dynamic>.from(responseData!.map((x) => x.toJson())),
      };
}

class OrderStatusModel {
  String? id;
  String? statusName;

  OrderStatusModel({
    this.id,
    this.statusName,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => OrderStatusModel(
        id: json["id"],
        statusName: json["status_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_name": statusName,
      };
}
