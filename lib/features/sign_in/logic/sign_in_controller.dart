import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';
import 'package:karam_driver/core/networking/api_response.dart';
import 'package:karam_driver/features/sign_in/data/data/models/sign_in_response_model.dart';

import '../../../core/helpers/binging_helper.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/data/models/sign_in_request_model.dart';
import '../data/data/repo/sign_in_repo.dart';

class SignInController extends GetxController {
  final SignInRepo signInRepo;
  final SaveUserData saveUserData = Get.find<SaveUserData>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  SignInResponseModel? signInResponseModel;

  SignInController(this.signInRepo);
  Future<ApiResponse> signIn() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    final responseModel = await signInRepo.signIn(SignInRequestModel(username: phoneController.text, password: passwordController.text));
    Get.back();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      if (responseModel.response!.data['response_code'] == 200 && responseModel.response!.data['response_data'] != null) {
        customSnackbar('تم الدخول بنجاح', responseModel.response!.data['response_message']);
        signInResponseModel = SignInResponseModel.fromJson(responseModel.response!.data);
        await saveUserData.saveUserData(signInResponseModel!);
        await saveUserData.saveUserId(signInResponseModel!.responseData!.user!.id ?? '1');
        phoneController.clear();
        passwordController.clear();
        Get.offAllNamed(AppRoutes.driverMain);
        update();
      } else {
        customSnackbar('خطأ', responseModel.response!.data['response_message']);
      }
    } else {
      customSnackbar('خطأ', responseModel.error);
    }
    return responseModel;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      signIn();
    }
  }
}
