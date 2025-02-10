import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:karam_driver/core/theming/colors.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';


class MyAccountContainer extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  final Widget? trailing;
  const MyAccountContainer({
    super.key,
    required this.title,
    required this.icon,
    this.trailing, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppColors.white2,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              trailing ?? RotatedBox(quarterTurns: 3, child: SvgPicture.asset(AppAssets.dropArrowSvg)),
              const Spacer(),
              Text(title, style: AppStyles.font14Main500),
              horizontalSpace(10),
              SvgPicture.asset(icon)
            ],
          ),
        ),
      ),
    );
  }
}
