class AddOrderRequestModel {
  final String userId;
  final String addressId;
  final String notes;

  AddOrderRequestModel({
    required this.userId,
    required this.addressId,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "address_id": addressId,
        "notes": notes,
      };
}
