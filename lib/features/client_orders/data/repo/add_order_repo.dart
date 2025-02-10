import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';


class AddOrderRepo {
  Dio dio = Dio();



  Future<ApiResponse> getOrders(String orderStatus, int page) async {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
      ),
    );
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.getOrders,
        queryParameters: {
          'user_id': SaveUserData().getUserId(),
          'order_status': orderStatus,
          'page': page,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> orderDetails(String orderId) async {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
      ),
    );
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.getOrderDetails,
        queryParameters: {
          'order_id': orderId,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> changeOrderStatus(String orderId, String orderStatus) async {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
      ),
    );
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.cancelOrder,
        queryParameters: {
          'user_id': SaveUserData().getUserId(),
          'order_id': orderId,
          'order_status': orderStatus,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> orederStatus() async {
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
       responseBody: true,
      ),
    );
    dio.options.headers = {'Authorization': 'Bearer ${SaveUserData().getUserToken()}'};
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.orederStatus,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }
}
