import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';


class CancelOrderButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  const CancelOrderButton({
    super.key,
    required this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.red,
          ),
        ),
        child: Center(
          child: Text(text, style: AppStyles.font16Red400),
        ),
      ),
    );
  }
}
