import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karam_driver/core/theming/colors.dart';
import 'package:karam_driver/core/theming/styles.dart';


class AppTextButton extends StatelessWidget {
  final String text;
  final double? radius;
  final Function() onTap;
  final double? hight;
  final Color? color;
  final TextStyle? style; 
  const AppTextButton({super.key, required this.text, required this.onTap, this.radius, this.color, this.hight, this.style});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height:hight?? 45.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8.0),
          color: color ?? AppColors.main,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Center(
            child: Text(
              text,
              style:style?? AppStyles.font16White400,
            ),
          ),
        ),
      ),
    );
  }
}
