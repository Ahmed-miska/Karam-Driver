import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/binging_helper.dart';
import '../../../core/helpers/save_user_data.dart';
import '../../../core/networking/api_response.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../../forget_password/logic/forget_password_controller.dart';
import '../../sign_in/data/data/models/sign_in_response_model.dart';
import '../../sign_up/logic/sign_up_controller.dart';
import '../data/models/active_user_request_model.dart';
import '../data/repo/otp_repo.dart';


class OtpController extends GetxController {
  final OtpRepo otpRepo;
  OtpController(this.otpRepo);

  // Controllers and Helpers
  final otpController = TextEditingController();
  final SaveUserData saveUserData = Get.find<SaveUserData>();

  // Focus and Form Handling
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  // Timer Variables
  Timer? _timer;
  int remainingSeconds = 30;
  final time = '00:30'.obs;

  // State Variables
  bool isVaild = false;
  SignInResponseModel? signInResponseModel;

  @override
  void onInit() {
    super.onInit();
    _startTimer(30);
    otpController.addListener(() {
      isVaild = otpController.text.length == 5;
      update();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  Future<ApiResponse> activeUser(ActiveUserRequestModel activeUserRequestModel) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    final responseModel = await otpRepo.activeUser(activeUserRequestModel);
    Get.back();

    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      final responseData = responseModel.response!.data;

      if (responseData['response_code'] == 200 && responseData['response_data'] != null) {
        customSnackbar('تم الدخول بنجاح', responseData['response_message']);
        signInResponseModel = SignInResponseModel.fromJson(responseData);

        await saveUserData.saveUserData(signInResponseModel!);
        await saveUserData.saveUserId(signInResponseModel!.responseData!.user!.id ?? '1');
        Get.offAllNamed(AppRoutes.driverMain);

        update();
      } else {
        customSnackbar('خطأ', responseData['response_message']);
      }
    } else {
      customSnackbar('خطأ', responseModel.error);
    }

    return responseModel;
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;

    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == -1) {
        timer.cancel();
      } else {
        int minutes = (remainingSeconds / 60).floor();
        int seconds = remainingSeconds % 60;
        time.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
      }
    });
  }

  void resetTimer() {
    otpController.clear();
    if (remainingSeconds == -1) {
      _startTimer(30);
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      activeUser(
        ActiveUserRequestModel(
          userId: Get.find<SignUpController>().signUpResponseModel!.responseData!.id,
          actvationCode: otpController.text,
          uuid: SaveUserData().getUserId(),
        ),
      );
    }
  }

  void verify() {
    if (otpController.text == Get.find<ForgetPasswordController>().code) {
      Get.offAndToNamed(AppRoutes.confirmPassword);
    } else {
      customSnackbar('خطأ', 'كود التحقق غير صحيح');
    }
  }
}
