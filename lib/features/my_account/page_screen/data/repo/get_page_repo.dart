import 'package:dio/dio.dart';
import 'package:karam_driver/core/helpers/functions.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_response.dart';


class GetPageRepo {
  Dio dio = Dio();
  Future<ApiResponse> getPage(String page) async {
    try {
      Response response = await dio.post( ApiConstants.apiBaseUrl + ApiConstants.getPage, data: {
        'page_link': page,
      });
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
