import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/widgets/custom_snack_bar.dart';
import 'package:karam_driver/features/driver_main/data/models/change_order_status_request_model.dart';
import 'package:karam_driver/features/driver_main/data/models/client_search_response_model.dart';
import 'package:karam_driver/features/driver_main/data/repos/driver_main_repo.dart';

class DriverMainController extends GetxController {
  final DriverMainRepo driverMainRepo;

  DriverMainController({required this.driverMainRepo});

  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ClientSearchResponseData? clientSearchResponseData;
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxString error = ''.obs;

  Future<void> searchClient() async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    isLoading.value = true;
    isError.value = false;
    error.value = '';
    update();
    final response = await driverMainRepo.searchClient(searchController.text);
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        clientSearchResponseData = ClientSearchResponseData.fromJson(response.response!.data['response_data']);
        isLoading.value = false;
        isError.value = false;
        error.value = '';

        update();
      } else {
        isLoading.value = false;
        isError.value = true;
        error.value = response.response!.data['response_message'];
        update();
      }
    } else {
      isLoading.value = false;
      isError.value = true;
      error.value = response.error.toString();
      update();
    }
    Get.back();
  }

  Future<void> changeOrderStatus(ChangeOrderStatusRequestModel model) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    final response = await driverMainRepo.cangeOrderStatus(model);
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        Get.back();
        customSnackbar('تم تغيير حالة الطلب بنجاح', response.response!.data['response_message']);
      } else {
        Get.back();

        customSnackbar('خطا', response.response!.data['response_message']);
      }
    } else {
      Get.back();

      customSnackbar('', response.error.toString());
    }
  }

  Future<void> uploadDoorPhoto(Uint8List capturedImage) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    final response = await driverMainRepo.uploadDoorPhoto(capturedImage);
    if (response.response != null && response.response!.statusCode == 200) {
      Get.back();
      if (response.response!.data['response_code'] == 200) {
        Get.back();
        customSnackbar('تم تحميل الصورة بنجاح', response.response!.data['response_message']);
      } else {
        customSnackbar('خطا', response.response!.data['response_message']);
      }
    } else {
      customSnackbar('', response.error.toString());
    }
  }
}
