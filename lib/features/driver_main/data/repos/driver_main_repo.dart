import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';
import 'package:karam_driver/core/networking/api_constants.dart';
import 'package:karam_driver/features/driver_main/data/models/change_order_status_request_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';

class DriverMainRepo {
  Dio dio = Dio();
  Future<ApiResponse> searchClient(String mobile) async {
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.searchClient,
        queryParameters: {
          'mobile': mobile,
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        logOut();
      }
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> cangeOrderStatus(ChangeOrderStatusRequestModel model) async {
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.changeOrderStatus,
        queryParameters: model.toJson(),

      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        logOut();
      }
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }

  }

  Future <ApiResponse> sendMapLink(String mobile) async {
     dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.sendMapLink,
        queryParameters: {
          'client_mobile': mobile,
          'user_id': SaveUserData().getUserId(),
        },
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        logOut();
      }
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> uploadDoorPhoto(Uint8List capturedImage) async {
    // التأكد من عدم إرسال بيانات فارغة
    if (capturedImage.isEmpty) {
      print("❌ Error: No image data found!");
    }

    MultipartFile multipartFile = MultipartFile.fromBytes(
      capturedImage,
      filename: "image.png",
      contentType: MediaType("image", "png"), // تحديد نوع الملف
    );
    FormData formData = FormData.fromMap({
      "door_photo": multipartFile,
      'user_id': SaveUserData().getUserId(),
    });

    print("📌 بيانات الـ FormData:");
    print(formData.fields);
    print(formData.files);
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}', 'Content-Type': 'multipart/form-data', 'Accept': 'application/json'};
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true, requestHeader: true));
    try {
      Response response = await dio.post(
        ApiConstants.apiBaseUrl + ApiConstants.uploadDoorPhoto,
        data: formData,
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        logOut();
      }
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
