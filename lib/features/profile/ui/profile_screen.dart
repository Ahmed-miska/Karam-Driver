import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../my_account/profile/logic/profile_controller.dart';
import '../../my_account/profile/ui/widgets/delete_account_button.dart';
import '../../my_account/profile/ui/widgets/profile_text_field.dart';
import '../../my_account/profile/ui/widgets/select_image_container.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                const BackAppBar(title: 'الملف الشخصي'),
                verticalSpace(20),
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
                              verticalSpace(50),
                              Text('الاسم كاملا', style: AppStyles.font15Main500),
                              verticalSpace(15),
                              const ProfileTextFields(),
                              verticalSpace(100),
                              const DeleteAccountButton(),
                              verticalSpace(30),
                              AppTextButton(
                                text: 'حفظ التعديلات',
                                onTap: () {
                                  Get.find<ProfileController>().updateProfile();
                                },
                                color: AppColors.main,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: SelectImageContianer(),
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
