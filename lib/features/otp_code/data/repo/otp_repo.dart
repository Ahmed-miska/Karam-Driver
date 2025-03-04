import 'package:dio/dio.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:karam_driver/core/networking/api_error_handler.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_response.dart';
import '../models/active_user_request_model.dart';


class OtpRepo {

  Dio dio = Dio();

  Future<ApiResponse> activeUser(ActiveUserRequestModel activeUserRequestModel) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.activeUser,
        queryParameters: activeUserRequestModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        logOut();
      }
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    } catch (e) {
      return ApiResponse.withError(e.toString());
    }
  }
}
