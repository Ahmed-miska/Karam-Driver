class ChangeOrderStatusRequestModel {
  final String userId;
  final String orderId;
  final String orderStatus;

  ChangeOrderStatusRequestModel({required this.userId, required this.orderId, required this.orderStatus});


  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "order_id": orderId,
        "order_status": orderStatus,
      };
}
