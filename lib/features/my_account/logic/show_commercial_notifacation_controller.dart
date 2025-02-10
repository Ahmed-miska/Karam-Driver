import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/networking/api_response.dart';
import 'package:karam_driver/core/widgets/custom_snack_bar.dart';
import 'package:karam_driver/features/my_account/data/repo/show_commerical_notification_repo.dart';

import '../../../core/networking/api_error_handler.dart';


class ShowCommercialNotifacationController extends GetxController {
  final ShowCommericalNotificationRepo showCommericalNotificationRepo;

  ShowCommercialNotifacationController(this.showCommericalNotificationRepo);
  bool iserror = false;

  Future<ApiResponse> getShowCommercialNotifications(String status) async {
    iserror = false;
    update();
    Get.dialog(const Center(child: CircularProgressIndicator()));
    ApiResponse response = await showCommericalNotificationRepo.getShowCommercialNotifications(status);

    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        Get.back();
        customSnackbar('تم', response.response!.data['response_message']);
      } else {
        Get.back();
        customSnackbar('خطأ', response.response!.data['response_message']);

        iserror = true;
        update();
      }
    } else {
      Get.back();
      customSnackbar('خطأ', ApiErrorHandler.handle(response.error));

      iserror = true;
      update();
    }

    return response;
  }
}
