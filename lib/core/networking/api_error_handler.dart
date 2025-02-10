import 'package:dio/dio.dart';
import 'package:karam_driver/core/networking/error_response.dart';

class ApiErrorHandler {
  static dynamic handle(error) {
    dynamic errorDescription = "";
    try {
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioExceptionType.connectionTimeout:
            errorDescription = "Connection timeout";
            break;
          case DioExceptionType.connectionError:
            errorDescription = "Connection error";
            break;
          case DioExceptionType.unknown:
            errorDescription = "Connection to API server failed due to internet connection";
            break;
          case DioExceptionType.receiveTimeout:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioExceptionType.badResponse:
            switch (error.response?.statusCode) {
              case 404:
              case 500:
              case 503:
                errorDescription = "There is a problem with the server";
                // errorDescription = error.response?.statusMessage;
                break;
              case 422:
                Error401Response error422Response = Error401Response.fromJson(error.response?.data);
                if (error422Response.code != null && error422Response.code == 422) {
                  errorDescription = error422Response.message.toString();
                } else {
                  errorDescription = "Failed to handel error - status code: ${error.response?.statusCode}";
                }

              case 401:
                Error401Response error401Response = Error401Response.fromJson(error.response?.data);
                if (error401Response.code != null && error401Response.code == 401) {
                  errorDescription = error401Response.message.toString();
                } else {
                  errorDescription = "Failed to handel error - status code: ${error.response?.statusCode}";
                }

                break;
              default:
                ErrorResponse errorResponse = ErrorResponse.fromJson(error.response?.data);
                if (errorResponse.errors != null && errorResponse.errors!.isNotEmpty) {
                  errorDescription = errorResponse;
                } else {
                  errorDescription = "Failed to load data - status code: ${error.response?.statusCode}";
                }
            }
            break;
          case DioExceptionType.sendTimeout:
            errorDescription = "Send timeout with server";
            break;
          case DioExceptionType.badCertificate:
            errorDescription = "Bad certificate";
            break;
        }
      } else {
        errorDescription = error.toString();
      }
    } on FormatException catch (e) {
      errorDescription = e.toString();
    }

    return errorDescription;
  }
}
