import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../helpers/app_assets.dart';
import '../helpers/binging_helper.dart';
import '../theming/styles.dart';


class BackAppBar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Function()? onTap;
  const BackAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading ?? const SizedBox(),
        const Spacer(),
        Text(title, style: AppStyles.font16Main400),
        const Spacer(),
        IconButton(
          // behavior: HitTestBehavior.opaque,
          onPressed: onTap ??
              () {
                if (Get.previousRoute.isEmpty) {
                  Get.offAllNamed(AppRoutes.driverMain);
                } else {
                  Get.back();
                }
              },
          icon: SvgPicture.asset(AppAssets.backArrowSvg),
        ),
      ],
    );
  }
}
