import 'package:dio/dio.dart';

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
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
