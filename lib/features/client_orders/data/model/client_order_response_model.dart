// To parse this JSON data, do
//
//     final clientOrderResponseModel = clientOrderResponseModelFromJson(jsonString);

import 'dart:convert';

ClientOrderResponseModel clientOrderResponseModelFromJson(String str) => ClientOrderResponseModel.fromJson(json.decode(str));

String clientOrderResponseModelToJson(ClientOrderResponseModel data) => json.encode(data.toJson());

class ClientOrderResponseModel {
  int? responseCode;
  String? responseMessage;
  Orders? responseData;

  ClientOrderResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory ClientOrderResponseModel.fromJson(Map<String, dynamic> json) => ClientOrderResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? null : Orders.fromJson(json["response_data"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "response_data": responseData?.toJson(),
      };
}

class Orders {
  int? ordersCount;
  List<Order>? orders;

  Orders({
    this.ordersCount,
    this.orders,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        ordersCount: json["orders_count"],
        orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders_count": ordersCount,
        "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  String? id;
  String? orderCode;
  String? createdAt;
  String? orderStatus;
  String? statusName;
  String? clientName;
  String? marketName;
  String? totalPrice;
  String? totalQuantity;

  Order({
    this.id,
    this.orderCode,
    this.createdAt,
    this.orderStatus,
    this.statusName,
    this.clientName,
    this.marketName,
    this.totalPrice,
    this.totalQuantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderCode: json["order_code"],
        createdAt: json["created_at"],
        orderStatus: json["order_status"],
        statusName: json["status_name"],
        clientName: json["client_name"],
        marketName: json["market_name"],
        totalPrice: json["total_price"],
        totalQuantity: json["total_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_code": orderCode,
        "created_at": createdAt,
        "order_status": orderStatus,
        "status_name": statusName,
        "client_name": clientName,
        "market_name": marketName,
        "total_price": totalPrice,
        "total_quantity": totalQuantity,
      };
}
