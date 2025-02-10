import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/contact_us/data/model/contact_us_request_model.dart';

import '../../../core/helpers/save_user_data.dart';
import '../../../core/networking/api_response.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/repo/contact_us_repo.dart';


class ContactUsController extends GetxController {
  final ContactUsRepo contactUsRepo;
  ContactUsController(this.contactUsRepo);
  TextEditingController phoneController = TextEditingController();

  TextEditingController messageAddressController = TextEditingController();

  TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isEroor = false;
  var error = '';

  @override
  void onInit() {
   
      phoneController.text = SaveUserData().getUserData()!.mobile!;
  

    super.onInit();
  }

  Future<ApiResponse> contactUs() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    isLoading = true;
    isEroor = false;
    update();
    var response = await contactUsRepo.contactUs(
      ContactUsRequestModel(
        mobile: phoneController.text,
        message: messageController.text,
        subject: messageAddressController.text,
      ),
    );
    Get.back();
    if (response.response!.statusCode == 200) {
      isLoading = true;
      isEroor = false;
      Get.back();
      customSnackbar('تم الارسال بنجاح', response.response!.data['response_message']);
    } else {
      isLoading = false;
      isEroor = true;
     
      customSnackbar('خطا', response.response!.data['response_message']);
    }
    return response;
  }

  void sendMessage() {
    if (formKey.currentState!.validate()) {
      contactUs();
    }
  }
}
