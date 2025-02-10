import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import 'widgets/otp_button.dart';
import 'widgets/otp_input_field.dart';
import 'widgets/timer_and_restart_icon.dart';



class OtpCodeScreen extends StatelessWidget {
  const OtpCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpace(20),
                    SvgPicture.asset(AppAssets.logoSvg),
                    verticalSpace(10),
                    Text('كود التفعيل', style: AppStyles.font20Main500),
                    verticalSpace(30),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: ' ادخل الرمز التي تم ارساله الى رقم', style: AppStyles.font14Black400),
                          TextSpan(
                            text: '  الواتس اب',
                            style: AppStyles.font14Black400.copyWith(
                              color: const Color(0xff35B066),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(7),
                    Text(Get.arguments[0], style: AppStyles.font14Main400),
                    verticalSpace(17),
                    const OtpInputField(),
                    verticalSpace(7),
                    const TimerAndRestartIcon(),
                    verticalSpace(20),
                    OtpButton(text: Get.arguments[1]),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
