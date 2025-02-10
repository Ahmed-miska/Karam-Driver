import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';


class ShowCommericalNotificationRepo {
  Dio dio = Dio();

  Future<ApiResponse> getShowCommercialNotifications(String status) async {
        dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.getShowCommercialNotifications,
        queryParameters: {
          'user_id': SaveUserData().getUserId(),
          'status': status,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
