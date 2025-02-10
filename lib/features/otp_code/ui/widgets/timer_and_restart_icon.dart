import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/otp_controller.dart';


class TimerAndRestartIcon extends StatefulWidget {
  const TimerAndRestartIcon({super.key});

  @override
  State<TimerAndRestartIcon> createState() => _TimerAndRestartIconState();
}

class _TimerAndRestartIconState extends State<TimerAndRestartIcon> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(builder: (controller) {
      return Column(
        children: [
          Obx(
            () => Text(controller.time.value, style: AppStyles.font16Main400),
          ),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.resetTimer();
                },
                child: SvgPicture.asset(AppAssets.restartSvg),
              ),
              horizontalSpace(10),
              Text(
                'اذا لم يصلك الكود برجاء الضغط على',
                style: AppStyles.font12Main500,
              )
            ],
          ),
        ],
      );
    });
  }
}
