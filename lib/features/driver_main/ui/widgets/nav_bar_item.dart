import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/colors.dart';
import 'package:karam_driver/core/theming/styles.dart';


class NavBarItem extends StatelessWidget {
  final bool isActive;
  final String title;
  final String icon;
  final Function()? onTap;
  const NavBarItem({
    super.key,
    required this.isActive,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: isActive
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    icon,
                    // ignore: deprecated_member_use
                    color: AppColors.main,
                  ),
                  verticalSpace(9),
                  Text(
                    title,
                    style: AppStyles.font8Grey500.copyWith(color: AppColors.main),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SvgPicture.asset(icon),
                  verticalSpace(9),
                  Text(
                    title,
                    style: AppStyles.font8Grey500,
                  )
                ],
              ),
            ),
    );
  }
}
