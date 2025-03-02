import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/sign_up/ui/widgets/sign_up_fields.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/helpers/binging_helper.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import 'widgets/sign_up_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            verticalSpace(20),
            Expanded(
              child: SingleChildScrollView(
                reverse: false,
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.logoSvg),
                    verticalSpace(20),
                    Align(alignment: Alignment.centerRight, child: Text('خلينا نتعرف عليك', style: AppStyles.font18Black500)),
                    verticalSpace(30),
                    const SignUpFields(),
                    verticalSpace(60),
                    const SignupButton(),
                    verticalSpace(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.offAndToNamed(AppRoutes.signInPage);
                            },
                            child: Text('تسجيل الدخول ', style: AppStyles.font16Main400)),
                        Text(' لديك حساب ؟ ', style: AppStyles.font16Black500),
                      ],
                    ),
                    verticalSpace(30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
