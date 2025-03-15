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
}

class Order {
  String? orderId;
  String? orderCode;
  String? createdAt;
  String? orderStatus;
  String? statusName;
  String? clientName;
  String? marketName;
  String? mobile;
  String? title;
  String? address;
  String? location;
  String? areaName;
  String? nearstReferencePoint;
  String? doorPhoto;

  Order({
    this.orderId,
    this.orderCode,
    this.createdAt,
    this.orderStatus,
    this.statusName,
    this.clientName,
    this.marketName,
    this.address,
    this.nearstReferencePoint,
    this.location,
    this.areaName,
    this.doorPhoto,
    this.mobile,
    this.title,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        orderCode: json["order_code"],
        createdAt: json["created_at"],
        orderStatus: json["order_status"],
        statusName: json["status_name"],
        clientName: json["client_name"],
        marketName: json["market_name"],
        nearstReferencePoint: json["nearst_reference_point"],
        mobile: json["mobile"],
        title: json["title"],
        address: json["address"],
        location: json["location"],
        areaName: json["area_name"],
        doorPhoto: json["door_photo"],
      );
}
