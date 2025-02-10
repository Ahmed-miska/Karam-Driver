import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../client_orders/logic/client_orders_controller.dart';


class DeleteOrderButtomSheet extends StatelessWidget {
  const DeleteOrderButtomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      height: 415.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffF9F9F9),
      ),
      child: Column(
        children: [
          verticalSpace(8),
          Container(
            height: 5,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFD2D2D2),
            ),
          ),
          verticalSpace(20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                  boxShadow: [BoxShadow(color: AppColors.black.withOpacity(.05), blurRadius: 6, spreadRadius: 0, offset: const Offset(0, 6))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(AppAssets.warningSvg, height: 95.h, width: 95.h),
                  Text(
                    'هل انت متأكد من عملية إلغاء الطلب ؟',
                    style: AppStyles.font18Main400,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextButton(
                          text: 'إلغاء',
                          onTap: () {
                            Get.find<ClientOrdersController>().changeOrderStatus('4');
                            Get.find<ClientOrdersController>().getOrders('1');
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          verticalSpace(18),
        ],
      ),
    );
  }
}
