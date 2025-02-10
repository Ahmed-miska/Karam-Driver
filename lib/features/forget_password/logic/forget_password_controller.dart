import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/binging_helper.dart';
import '../../../core/networking/api_error_handler.dart';
import '../../../core/networking/api_response.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/repo/forget_password_repo.dart';


class ForgetPasswordController extends GetxController {
  final ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordController(this.forgetPasswordRepo);
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var error = '';
  String code = '';
  Future<ApiResponse> forgetPassword(String mobile) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    var response = await forgetPasswordRepo.activeForgetPassword(mobile);
    Get.back();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        code = response.response!.data['response_data'].toString();
        update();
        Get.toNamed(AppRoutes.otpPageURL, arguments:[ phoneController.text,'forgetPassword']);
      } else if (response.response!.data['response_code'] == 400) {
        
        customSnackbar('خطا', response.response!.data['response_message']);
      }
      else{
        customSnackbar('خطا', response.response!.data['response_message']);
      }
    } else {
      error = ApiErrorHandler.handle(response.error);
      customSnackbar('خطا', error);
    }
    print(code);
    return response;
  }
}
