import 'package:dio/dio.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';
import 'package:karam_driver/core/networking/api_constants.dart';
import 'package:karam_driver/core/networking/api_error_handler.dart';
import 'package:karam_driver/core/networking/api_response.dart';
import 'package:karam_driver/features/contact_us/data/model/contact_us_request_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


class ContactUsRepo {
  Dio dio = Dio();

  Future<ApiResponse> contactUs(ContactUsRequestModel contactUsRequestModel) async {
    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true));

    dio.options.headers = {
      'Authorization': 'Bearer ${SaveUserData().getUserToken()}',
    };
    try {
      Response response = await dio.get(
        ApiConstants.apiBaseUrl + ApiConstants.contactUs,
        queryParameters: contactUsRequestModel.toJson(),
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
