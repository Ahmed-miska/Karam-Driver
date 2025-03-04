import 'package:dio/dio.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:karam_driver/core/networking/api_constants.dart';
import 'package:karam_driver/core/networking/api_error_handler.dart';
import 'package:karam_driver/core/networking/api_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/active_forget_user_request_model.dart';

class ConfirmPasswordRepo {
  Dio dio = Dio();
  Future<ApiResponse> activeForgetPassword(ActiveForgetUserRequestModel activeForgetUserRequestModel) async {
        dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.activeForgetPassword,
        queryParameters: activeForgetUserRequestModel.toJson(),
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
