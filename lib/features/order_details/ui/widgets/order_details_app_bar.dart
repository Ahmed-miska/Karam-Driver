import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theming/styles.dart';


class OrderDetailsAppBar extends StatelessWidget {
  const OrderDetailsAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        
        Text('تفاصيل الطلب', style: AppStyles.font16Main400),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: SvgPicture.asset(AppAssets.backArrowSvg),
        ),
      ],
    );
  }
}
