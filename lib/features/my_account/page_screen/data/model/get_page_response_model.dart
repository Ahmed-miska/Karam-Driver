
class GetPageResponseModel {
  int? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  GetPageResponseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  factory GetPageResponseModel.fromJson(Map<String, dynamic> json) => GetPageResponseModel(
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
  String? pageId;
  String? pageTitle;
  String? pageDesc;
  String? pageContent;

  ResponseData({
    this.pageId,
    this.pageTitle,
    this.pageDesc,
    this.pageContent,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        pageId: json["page_id"],
        pageTitle: json["page_title"],
        pageDesc: json["page_desc"],
        pageContent: json["page_content"],
      );

  Map<String, dynamic> toJson() => {
        "page_id": pageId,
        "page_title": pageTitle,
        "page_desc": pageDesc,
        "page_content": pageContent,
      };
}
