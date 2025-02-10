import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white2,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(order.statusName ?? '', style: AppStyles.font16Main500),
                const Spacer(),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    openMap(30.565178, 31.012927);
                  },
                  icon: SvgPicture.asset(AppAssets.locationSelectedSvg),
                ),
                const Spacer(),
                Text('${order.orderCode}#', style: AppStyles.font15Black500),
              ],
            ),
          ),
          verticalSpace(10),
          const Divider(height: 0),
          verticalSpace(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(order.createdAt ?? '', style: AppStyles.font13Gray500),
                    const Spacer(),
                    Text('تاريخ و توقيت الطلب', style: AppStyles.font13Black500),
                  ],
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Text(order.totalQuantity ?? '', style: AppStyles.font13Gray500),
                    const Spacer(),
                    Text('عدد المنتجات', style: AppStyles.font13Black500),
                  ],
                ),
                verticalSpace(10),
                Row(
                  children: [
                    Text(order.marketName ?? '', style: AppStyles.font13Gray500),
                    const Spacer(),
                    Text('اسم المتجر', style: AppStyles.font13Black500),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(10),
          const Divider(height: 0),
          verticalSpace(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('د.ع', style: AppStyles.font15Main600),
                horizontalSpace(5),
                Text(order.totalPrice ?? '', style: AppStyles.font15Main600),
                const Spacer(),
                Text('السعر الإجمالي', style: AppStyles.font15Main600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
