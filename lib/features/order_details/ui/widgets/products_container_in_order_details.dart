import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karam_driver/core/theming/colors.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import 'products_list_view_in_order_details.dart';


class ProductsContainerInOrderDetails extends StatelessWidget {
  const ProductsContainerInOrderDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('منتجات الطلب', style: AppStyles.font16Main500),
          verticalSpace(10),
          const ProductsListViewInOrderDetails(),
        ],
      ),
    );
  }
}
