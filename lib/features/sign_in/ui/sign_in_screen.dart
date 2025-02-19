import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/helpers/binging_helper.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../data/data/repo/sign_in_repo.dart';
import '../logic/sign_in_controller.dart';
import 'widgets/phone_and_password_field.dart';
import 'widgets/remember_and_forget_password.dart';
import 'widgets/sign_in_button.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SignInController>()) {
      Get.put(SignInRepo());
      Get.put(SignInController(Get.find<SignInRepo>()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                verticalSpace(30),
                SvgPicture.asset(AppAssets.logoSvg),
                verticalSpace(40),
                Text('مرحبا بك في تطبيق دليني ', style: AppStyles.font16Black500),
                verticalSpace(16),
                Text('يرجى ادخال رقم الجوال لتسجيل الدخول', style: AppStyles.font14gray400),
                verticalSpace(40),
                const PhoneAndPasswordField(),
                verticalSpace(15),
                const RememberAndForgetPassword(),
                verticalSpace(80),
                const SigninButton(),
                verticalSpace(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.offAndToNamed(AppRoutes.signUpPageURL);
                      },
                      child: Text('انشاء حساب ', style: AppStyles.font16Main400),
                    ),
                    Text('ليس لديك حساب ؟', style: AppStyles.font16Black500),
                  ],
                ),
                verticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
