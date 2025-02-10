import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/profile/ui/widgets/delete_account_bottom_sheet.dart';


import '../../../../core/helpers/binging_helper.dart';
import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_response.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../data/model/renew_password_request_model.dart';
import '../data/repo/renew_password_repo.dart';
import '../ui/widgets/change_password_bottom_sheet.dart';


class ProfileController extends GetxController {
  final RenewPasswordRepo renewPasswordRepo;
  ProfileController(this.renewPasswordRepo);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    nameController.text = SaveUserData().getUserData()!.fullName!;
    phoneController.text = SaveUserData().getUserData()!.mobile!;
    passwordController.text = SaveUserData().getUserData()!.pass!;
    super.onInit();
  }

  void updateProfile() {
    update();
    print(nameController.text);
    print(phoneController.text);
    print(passwordController.text);
  }

  void deleteAccount() {
    Get.bottomSheet(
      const DeleteAccountBottomSheet(),
    );
    print('deleteAccount');
  }

  void changePassword() {
    Get.bottomSheet(
      const ChangePasswordBottomSheet(),
    );
    print('changePassword');
  }


  Future<ApiResponse> renewPassword(RenewPasswordRequestModel model) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    final response = await renewPasswordRepo.renewPassword(model);
    Get.back();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
       customSnackbar('تم', response.response!.data['response_message']);
        Get.offAllNamed(AppRoutes.signInPage);
      } else {
      customSnackbar('خطأ', response.response!.data['response_message']);
      }
    } else {
      var error = ApiErrorHandler.handle(response.error);
     customSnackbar('خطأ', error);
    }

    return response;
  }
}
