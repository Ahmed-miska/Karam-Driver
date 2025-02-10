import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karam_driver/core/theming/styles.dart';

import '../../../../core/theming/colors.dart';


class TypeOfOrderItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  const TypeOfOrderItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.main : AppColors.white,
      ),
      child: Center(
        child: Text(
          title,
          style: isSelected
              ? AppStyles.font14White400
              : AppStyles.font14White400.copyWith(
                  color: const Color(0xff727171),
                ),
        ),
      ),
    );
  }
}
