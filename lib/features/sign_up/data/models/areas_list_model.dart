class AreasListResponseModel {
  int responseCode;
  String responseMessage;
  List<AreasItem>? responseData;

  AreasListResponseModel({
    required this.responseCode,
    required this.responseMessage,
    this.responseData,
  });

  factory AreasListResponseModel.fromJson(Map<String, dynamic> json) => AreasListResponseModel(
        responseCode: json["response_code"],
        responseMessage: json["response_message"],
        responseData: json["response_data"] == null ? [] : List<AreasItem>.from(json["response_data"]!.map((x) => AreasItem.fromJson(x))),
      );
}

class AreasItem {
  String? id;
  String? areaName;

  AreasItem({
    this.id,
    this.areaName,
  });

  factory AreasItem.fromJson(Map<String, dynamic> json) => AreasItem(
        id: json["id"],
        areaName: json["area_name"],
      );
}
