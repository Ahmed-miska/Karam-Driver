import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import 'custom_toggle_switch.dart';


class WhatsNotificationRow extends StatelessWidget {
  const WhatsNotificationRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: AppColors.white2,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Row(
          children: [
            const CustomToggleSwitch(),
            const Spacer(),
            Text('اشعارات الواتس اب الترويجية', style: AppStyles.font14Main500),
            horizontalSpace(10),
            SvgPicture.asset(AppAssets.solidWhatsSvg)
          ],
        ),
      ),
    );
  }
}
