import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/client_orders_controller.dart';


class OrdersTabs extends StatelessWidget {
  const OrdersTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersController>(
      builder: (controller) {
        return Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  controller.isLoading = true;
                  controller.update();
                  controller.activeStep = 2;
                  controller.page = 1;
                  controller.orders = [];
                  controller.update();
                  await controller.getOrders('2');
                  if (controller.orders.isEmpty) {
                    controller.error = 'لا يوجد طلبات';
                    controller.isLoading = false;
                    controller.isError = true;
                    controller.update();
                  }
                },
                child: Container(
                  width: 135.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.activeStep == 2 ? AppColors.main : AppColors.white,
                  ),
                  child: Center(
                    child: Text(
                      'الطلبات السابقة',
                      style: controller.activeStep == 2 ? AppStyles.font14White400 : AppStyles.font14White400.copyWith(color: const Color(0xff727171)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  controller.isLoading = true;
                  controller.update();
                  controller.activeStep = 1;
                  controller.page = 1;
                  controller.orders = [];
                  controller.update();
                  await controller.getOrders('1');
                  if (controller.orders.isEmpty) {
                    controller.error = 'لا يوجد طلبات';
                    controller.isLoading = false;
                    controller.isError = true;
                    controller.update();
                  }
                },
                child: Container(
                  width: 135.w,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.activeStep == 1 ? AppColors.main : AppColors.white,
                  ),
                  child: Center(
                    child: Text(
                      'طلبات اليوم',
                      style: controller.activeStep == 1 ? AppStyles.font14White400 : AppStyles.font14White400.copyWith(color: const Color(0xff727171)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
