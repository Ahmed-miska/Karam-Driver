import 'package:dio/dio.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../core/helpers/save_user_data.dart';
import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_response.dart';
import '../model/renew_password_request_model.dart';


class RenewPasswordRepo {
  Dio dio = Dio();

  Future<ApiResponse> renewPassword(RenewPasswordRequestModel model) async {
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.renewPassword,
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
}
