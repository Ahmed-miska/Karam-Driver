import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/confirm_password/data/model/active_forget_user_request_model.dart';

import '../../../core/helpers/binging_helper.dart';
import '../../../core/networking/api_error_handler.dart';
import '../../../core/networking/api_response.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/repo/confirm_password_repo.dart';



class ConfirmPasswordController extends GetxController {
  final ConfirmPasswordRepo confirmPasswordRepo;

  ConfirmPasswordController(this.confirmPasswordRepo);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var error = '';
  bool isError = false;

  Future<ApiResponse> activeForgetPassword(ActiveForgetUserRequestModel activeForgetUserRequestModel) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    var response = await confirmPasswordRepo.activeForgetPassword(activeForgetUserRequestModel);
    Get.back();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        customSnackbar('تم تغيير كلمة المرور بنجاح', response.response!.data['response_message']);
        Get.offAllNamed(AppRoutes.signInPage);
      } else {
       
        customSnackbar('خطأ', response.response!.data['response_message']);
      }
    } else {
      error = ApiErrorHandler.handle(response.error);
      customSnackbar('خطأ', error);
      update();
    }
    return response;
  }
}
