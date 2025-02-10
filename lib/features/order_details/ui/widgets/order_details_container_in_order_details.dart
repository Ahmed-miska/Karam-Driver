import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../client_orders/logic/client_orders_controller.dart';


class OrderDetailsContainerInOrderDetails extends StatelessWidget {
  const OrderDetailsContainerInOrderDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('تفاصيل الطلب', style: AppStyles.font15Main500),
            verticalSpace(10),
            ListView.builder(
              itemCount: controller.orderDetailsResponseModel!.responseData!.orderInfo!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      Text(controller.orderDetailsResponseModel!.responseData!.orderInfo![index].value ?? '', style: AppStyles.font13Gray500),
                      const Spacer(),
                      Text(controller.orderDetailsResponseModel!.responseData!.orderInfo![index].label ?? '', style: AppStyles.font14Black500),
                    ],
                  ),
                );
              },
            ),
            verticalSpace(14),
            const Divider(height: 0),
            verticalSpace(14),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 35.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Text('د.ع', style: AppStyles.font16Main500),
                      Text(' ', style: AppStyles.font16Main500),
                      Text(controller.orderDetailsResponseModel!.responseData!.totalPrice.toString(), style: AppStyles.font16Main500),
                    ],
                  ),
                ),
                const Spacer(),
                Text('إجمالي المبلغ', style: AppStyles.font15Main500),
              ],
            )
          ],
        ),
      );
    });
  }
}
