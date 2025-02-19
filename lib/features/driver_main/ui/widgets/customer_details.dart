import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/binging_helper.dart';
import 'package:karam_driver/core/helpers/functions.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/core/widgets/custom_open_icon.dart';
import 'package:karam_driver/features/driver_main/data/models/change_order_status_request_model.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_controller.dart';
import '../../../../core/widgets/cached_network_image.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverMainController>(builder: (controller) {
      if (controller.isLoading.value) {
        return const SizedBox();
      }
      if (controller.isError.value) {
        if (controller.error.value == '400') {
          return SizedBox(
            child: Column(
              children: [
                Text(
                  'عفوا هذا العميل غير متواجد يمكنك ارسال طلب الموقع الحالي ',
                  textAlign: TextAlign.right,
                  style: AppStyles.font14Black400,
                ),
                verticalSpace(20),
                AppTextButton(
                  text: 'ارسال',
                  onTap: () {
                    controller.sendMapLink();
                  },
                ),
                verticalSpace(20),
              ],
            ),
          );
        }
        return Center(child: Text(controller.error.value));
      }
      if (controller.clientSearchResponseData == null && controller.isLoading.value == false && controller.isError.value == false) {
        return const SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomIconButton(iconPath: 'assets/svgs/whats_app.svg', platform: 'whatsapp', phoneNumber: controller.clientSearchResponseData!.mobile),
              CustomIconButton(iconPath: 'assets/svgs/phone_call.svg', platform: 'call', phoneNumber: controller.clientSearchResponseData!.mobile),
              const Spacer(),
              Text('تفاصيل العميل', style: AppStyles.font16Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(controller.clientSearchResponseData!.orderId ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': كود الطلب', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(controller.clientSearchResponseData!.mobile ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': رقم العميل', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(controller.clientSearchResponseData!.address ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': العنوان', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(controller.clientSearchResponseData!.areaName ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': المنطقه', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (controller.clientSearchResponseData!.location != null) {
                    String lat = controller.clientSearchResponseData!.location.split(',')[0];
                    String long = controller.clientSearchResponseData!.location.split(',')[1];
                    openMap(lat, long);
                  }
                },
                child: Text('عرض الموقع', style: AppStyles.font14Main500),
              ),
              const Spacer(),
              Text(': الموقع', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  text: 'صوره باب المنزل',
                  onTap: () {
                    if (controller.clientSearchResponseData!.doorPhoto != null) {
                      Get.dialog(AlertDialog(
                        title: const Text('صوره باب المنزل', textAlign: TextAlign.right),
                        content: CachedImage(image: controller.clientSearchResponseData!.doorPhoto!),
                        actions: [
                          TextButton(
                            child: const Text('اغلاق'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ));
                    } else if (controller.selectedImage != null) {
                      Get.dialog(AlertDialog(
                        title: const Text('صوره باب المنزل', textAlign: TextAlign.right),
                        content: SizedBox(height: 500.h, child: Image.memory(controller.selectedImage!, fit: BoxFit.cover)),
                        actions: [
                          TextButton(
                            child: const Text('اغلاق'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ));
                    } else {
                      Get.toNamed(AppRoutes.cameraScreen);
                    }
                  },
                ),
              ),
              horizontalSpace(20),
              Expanded(
                child: AppTextButton(
                  text: 'استلام الطلب',
                  onTap: () async {
                    await controller.changeOrderStatus(
                      ChangeOrderStatusRequestModel(orderId: controller.clientSearchResponseData!.orderId!, userId: SaveUserData().getUserId(), orderStatus: '3'),
                    );
                  },
                ),
              ),
            ],
          ),
          verticalSpace(30),
        ],
      );
    });
  }
}
