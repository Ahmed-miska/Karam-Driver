import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/app_assets.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/colors.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/core/widgets/back_app_bar.dart';
import 'package:karam_driver/features/contact_us/logic/contact_us_controller.dart';
import 'package:karam_driver/features/contact_us/ui/widgets/contact_us_text_fields.dart';



class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                const BackAppBar(title: 'تواصل معنا'),
                verticalSpace(40),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 55.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white2,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              verticalSpace(70),
                              Center(child: Text('يمكنك التواصل مع فريق الدعم الفني ', style: AppStyles.font14Main500)),
                              verticalSpace(20),
                              Text('رقم الجوال', style: AppStyles.font15Black500),
                              verticalSpace(15),
                              const ContactUsTextFields(),
                              verticalSpace(70),
                              AppTextButton(
                                text: 'ارسال',
                                onTap: () {
                                  Get.find<ContactUsController>().sendMessage();
                                },
                                color: AppColors.main,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 110.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white2,
                          border: Border.all(color: AppColors.white, width: 5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: SvgPicture.asset(AppAssets.logoSvg),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
