import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';
import '../models/sign_up_request_model.dart';



class SignUpRepo {

  Dio dio = Dio();

  Future<ApiResponse> signUp(SignUpRequestModel signUpRequestModel) async {
        dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.signUp,
        queryParameters: signUpRequestModel.toJson(),
      );
      debugPrint('response: ${response.data}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      debugPrint('error: ${e.toString()}');
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

    Future<ApiResponse> getAreasList({int page = 1, String keyword = ''}) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));
    try {
      Map<String, dynamic> queryParams = {
        'page': page,
        'keyword': keyword,
      };
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.areasList,
        queryParameters: queryParams,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
