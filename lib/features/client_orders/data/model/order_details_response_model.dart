// To parse this JSON data, do
//
//     final orderDetailsResponseModel = orderDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsResponseModel orderDetailsResponseModelFromJson(String str) => OrderDetailsResponseModel.fromJson(json.decode(str));

String orderDetailsResponseModelToJson(OrderDetailsResponseModel data) => json.encode(data.toJson());

class OrderDetailsResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  OrderDetailsResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailsResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? null : ResponseData.fromJson(json["response_data"]),
      );

  Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "response_message": responseMessage,
        "response_data": responseData?.toJson(),
      };
}

class ResponseData {
  String? orderId;
  String? marketId;
  int? totalPrice;
  String? orderCode;
  String? orderStatus;
  List<Action>? actions;
  List<OrderInfo>? orderInfo;
  String? defaultAddress;
  List<Item>? items;

  ResponseData({
    this.orderId,
    this.marketId,
    this.totalPrice,
    this.orderCode,
    this.orderStatus,
    this.actions,
    this.orderInfo,
    this.defaultAddress,
    this.items,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        orderId: json["order_id"],
        marketId: json["market_id"],
        totalPrice: json["total_price"],
        orderCode: json["order_code"],
        orderStatus: json["order_status"],
        actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromJson(x))),
        orderInfo: json["order_info"] == null ? [] : List<OrderInfo>.from(json["order_info"]!.map((x) => OrderInfo.fromJson(x))),
        defaultAddress: json["default_address"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "market_id": marketId,
        "total_price": totalPrice,
        "order_code": orderCode,
        "order_status": orderStatus,
        "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toJson())),
        "order_info": orderInfo == null ? [] : List<dynamic>.from(orderInfo!.map((x) => x.toJson())),
        "default_address": defaultAddress,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Action {
  String? statusName;
  int? statusNumber;

  Action({
    this.statusName,
    this.statusNumber,
  });

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        statusName: json["status_name"],
        statusNumber: json["status_number"],
      );

  Map<String, dynamic> toJson() => {
        "status_name": statusName,
        "status_number": statusNumber,
      };
}

class Item {
  String? itemId;
  int? itemPrice;

  String? itemName;
  String? itemDesc;
  int? quantity;
  dynamic image;

  Item({
    this.itemId,
    this.itemPrice,
    this.itemName,
    this.itemDesc,
    this.quantity,
    this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["item_id"],
        itemPrice: json["item_price"],
        itemName: json["item_name"],
        itemDesc: json["item_desc"],
        quantity: json["quantity"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_price": itemPrice,
        "item_name": itemName,
        "item_desc": itemDesc,
        "quantity": quantity,
        "image": image,
      };
}

class OrderInfo {
  String? label;
  String? value;

  OrderInfo({
    this.label,
    this.value,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
