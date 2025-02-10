import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import 'type_of_order_list.dart';


class TypeOfOrdersContainer extends StatelessWidget {
  const TypeOfOrdersContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      width: double.infinity,
      height: 85.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white2,
      ),
      child: const TypesOfOrderList(),
    );
  }
}
