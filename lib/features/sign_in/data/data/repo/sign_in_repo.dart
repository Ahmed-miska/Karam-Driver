import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_response.dart';
import '../models/sign_in_request_model.dart';


class SignInRepo {

  final Dio dio = Dio();

  Future<ApiResponse> signIn(SignInRequestModel query) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.signIn,
        queryParameters: query.toJson(),
      );

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
