import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/helpers/app_assets.dart';
import '../../../core/helpers/binging_helper.dart';
import '../../../core/helpers/functions.dart';
import '../../../core/helpers/save_user_data.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../data/model/row_model.dart';
import 'widgets/logout_bottom_sheet.dart';
import 'widgets/my_account_container.dart';
import 'widgets/whats_notification_row.dart';



class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});
  static List<MyAcounntRowModel> list = [
    MyAcounntRowModel(title: 'الملف الشخصي', icon: AppAssets.solidPersonSvg),
    MyAcounntRowModel(title: 'سياسة الخصوصية', icon: AppAssets.solidOrderSvg),
    MyAcounntRowModel(title: 'عن التطبيق', icon: AppAssets.solidAboutSvg),
    MyAcounntRowModel(title: 'الشروط والاحكام', icon: AppAssets.condationSvg),
    MyAcounntRowModel(title: 'تواصل معنا', icon: AppAssets.solidcontactSvg),
  ];
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        //    Get.offAllNamed(AppRoutes.mainPageURL);
        return Future.value(true);
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                Text('حسابي', style: AppStyles.font16Main400),

                //     BackAppBar(
                //       title: 'حسابي',
                //       onTap: () {
                // //    Get.offAllNamed(AppRoutes.mainPageURL);
                //       },
                //     ),
                verticalSpace(30),
                Column(
                  children: list
                      
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: MyAccountContainer(
                            title: e.title,
                            icon: e.icon,
                            onTap: () {
                               if (e.title == 'الشروط والاحكام') {
                                Get.toNamed(AppRoutes.pageScreen, parameters: {'pageName': 'terms_and_conditions'});
                              } else if (e.title == 'عن التطبيق') {
                                Get.toNamed(AppRoutes.pageScreen, parameters: {'pageName': 'about_us'});
                              } else if (e.title == 'سياسة الخصوصية') {
                                Get.toNamed(AppRoutes.pageScreen, parameters: {'pageName': 'privacy_policy'});
                              } else if (e.title == 'تواصل معنا') {
                                Get.toNamed(AppRoutes.contactUs);
                              } else if (e.title == 'الملف الشخصي') {
                                
                                  Get.toNamed(AppRoutes.profile);
                                
                              }
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
                const WhatsNotificationRow(),
                // verticalSpace(12),
                // MyAccountContainer(
                //   title: 'البحث بالكود التعريفي',
                //   icon: AppAssets.peopleSvg,
                //   trailing: const SizedBox(),
                //   onTap: () {
                //     Get.toNamed(AppRoutes.searchCustomer);
                //   },
                // ),
                verticalSpace(12),
                 SaveUserData().getUserToken() != ''&& SaveUserData().getUserToken().isNotEmpty
                    ? MyAccountContainer(
                        title: 'تسجيل الخروج',
                        icon: AppAssets.logoutSvg,
                        trailing: SvgPicture.asset(AppAssets.exitRedSvg),
                        onTap: () {
                          Get.bottomSheet(const LogoutBottomSheet());
                        },
                      )
                    : AppTextButton(
                        text: 'تسجيل الدخول',
                        onTap: () {
                          Get.toNamed(AppRoutes.signInPage);
                        },
                      ),
                verticalSpace(50),
                FutureBuilder<Map<String, dynamic>>(
                  future: getVersion(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Error loading version"));
                    } else {
                      return Center(child: Text('Version: ${snapshot.data!['version']} (${snapshot.data!['build_number']})', style: AppStyles.font12Main400Expo));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
