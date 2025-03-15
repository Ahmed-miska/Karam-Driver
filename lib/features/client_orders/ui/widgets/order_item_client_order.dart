import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/binging_helper.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/core/widgets/cached_network_image.dart';
import 'package:karam_driver/core/widgets/custom_open_icon.dart';
import 'package:karam_driver/features/driver_main/data/models/change_order_status_request_model.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_controller.dart';
import '../../../../core/helpers/functions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/model/client_order_response_model.dart';

class OrderItemClientOrder extends StatelessWidget {
  final Order order;
  const OrderItemClientOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          verticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomIconButton(iconPath: 'assets/svgs/whats_app.svg', platform: 'whatsapp', phoneNumber: order.mobile),
              CustomIconButton(iconPath: 'assets/svgs/phone_call.svg', platform: 'call', phoneNumber: order.mobile),
              const Spacer(),
              Text('تفاصيل العميل', style: AppStyles.font16Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(order.orderCode ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': كود الطلب', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(order.mobile ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': رقم العميل', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(order.address ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': العنوان', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(order.areaName ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': المنطقه', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (order.location != null) {
                    String lat = order.location!.split(',')[0];
                    String long = order.location!.split(',')[1];
                    openMap(lat, long);
                  }
                },
                child: Text('عرض الموقع', style: AppStyles.font14Main500),
              ),
              const Spacer(),
              Text(': الموقع', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(10),
          Row(
            children: [
              Text(order.nearstReferencePoint ?? '', style: AppStyles.font14Black400),
              const Spacer(),
              Text(': اقرب نقطه داله', style: AppStyles.font15Black500),
            ],
          ),
          verticalSpace(20),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  text: 'صوره باب المنزل',
                  onTap: () {
                    if (order.doorPhoto != null) {
                      Get.dialog(AlertDialog(
                        title: const Text('صوره باب المنزل', textAlign: TextAlign.right),
                        content: CachedImage(image: order.doorPhoto!),
                        actions: [
                          TextButton(
                            child: const Text('اغلاق'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ));
                    } else if (Get.find<DriverMainController>().selectedImage != null) {
                      Get.dialog(AlertDialog(
                        title: const Text('صوره باب المنزل', textAlign: TextAlign.right),
                        content: SizedBox(height: 500.h, child: Image.memory(Get.find<DriverMainController>().selectedImage!, fit: BoxFit.cover)),
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
                    await Get.find<DriverMainController>().changeOrderStatus(
                      ChangeOrderStatusRequestModel(orderId: order.orderId!, userId: SaveUserData().getUserId(), orderStatus: '3'),
                    );
                  },
                ),
              ),
            ],
          ),
          verticalSpace(30),
        ],
      ),

      // child: Column(
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 20.w),
      //       child: Row(
      //         children: [
      //           Text(order.statusName ?? '', style: AppStyles.font16Main500),
      //           const Spacer(),
      //           IconButton(
      //             padding: EdgeInsets.zero,
      //             onPressed: () {
      //               openMap('30.565178', '31.012927');
      //             },
      //             icon: SvgPicture.asset(AppAssets.locationSelectedSvg),
      //           ),
      //           const Spacer(),
      //           Text('${order.orderCode}#', style: AppStyles.font15Black500),
      //         ],
      //       ),
      //     ),
      //     verticalSpace(10),
      //     const Divider(height: 0),
      //     verticalSpace(12),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 20.w),
      //       child: Column(
      //         children: [
      //           Row(
      //             children: [
      //               Text(order.createdAt ?? '', style: AppStyles.font13Gray500),
      //               const Spacer(),
      //               Text('تاريخ و توقيت الطلب', style: AppStyles.font13Black500),
      //             ],
      //           ),
      //           verticalSpace(10),
      //           Row(
      //             children: [
      //               Text(order.totalQuantity ?? '', style: AppStyles.font13Gray500),
      //               const Spacer(),
      //               Text('عدد المنتجات', style: AppStyles.font13Black500),
      //             ],
      //           ),
      //           verticalSpace(10),
      //           Row(
      //             children: [
      //               Text(order.marketName ?? '', style: AppStyles.font13Gray500),
      //               const Spacer(),
      //               Text('اسم المتجر', style: AppStyles.font13Black500),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //     verticalSpace(10),
      //     const Divider(height: 0),
      //     verticalSpace(10),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 20.w),
      //       child: Row(
      //         children: [
      //           Text('د.ع', style: AppStyles.font15Main600),
      //           horizontalSpace(5),
      //           Text(order.totalPrice ?? '', style: AppStyles.font15Main600),
      //           const Spacer(),
      //           Text('السعر الإجمالي', style: AppStyles.font15Main600),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
