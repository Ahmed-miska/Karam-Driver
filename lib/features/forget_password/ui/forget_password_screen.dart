import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../logic/forget_password_controller.dart';
import 'widgets/forget_password_field.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                verticalSpace(10),
                const BackAppBar(title: ''),
                verticalSpace(15),
                Container(
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
                          verticalSpace(25),
                          Text('هل نسيت كلمة المرور', style: AppStyles.font20Main500),
                          verticalSpace(30),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('أدخل الرقم الجوال', style: AppStyles.font14Black400),
                          ),
                          verticalSpace(10),
                          const ForgetPasswordField(),
                          verticalSpace(45),
                          AppTextButton(
                            text: 'ارسال',
                            onTap: () {
                              if (Get.find<ForgetPasswordController>().formKey.currentState!.validate()) {
                                Get.find<ForgetPasswordController>().forgetPassword(Get.find<ForgetPasswordController>().phoneController.text);
                              }
                            },
                          ),
                          verticalSpace(20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
