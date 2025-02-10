import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/binging_helper.dart';
import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';


class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      height: 415.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffF9F9F9),
      ),
      child: Column(
        children: [
          verticalSpace(8),
          Container(
            height: 5,
            width: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFD2D2D2),
            ),
          ),
          verticalSpace(20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                  boxShadow: [BoxShadow(color: AppColors.black.withOpacity(.05), blurRadius: 6, spreadRadius: 0, offset: const Offset(0, 6))]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(AppAssets.alertSvg, height: 95.h, width: 95.h),
                  Text(
                    'هل أنت متأكد من عملية تسجيل الخروج؟',
                    style: AppStyles.font18Main400,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextButton(
                          text: 'تسجيل خروج',
                          onTap: () async {
                            Get.dialog(const Center(child: CircularProgressIndicator()));
                            await SaveUserData().clearSharedData();

                            Get.back();
                            Get.offAllNamed(AppRoutes.signInPage);
                            // await OneSignal.logout();
                            // if (!kIsWeb) {
                            //   await OneSignal.logout();
                            //   print("User logged out successfully.");
                            // } else {
                            //   try {
                            //     await js.context.callMethod('logoutOneSignal');
                            //     print("User logged out successfully on the web.");
                            //   } catch (e) {
                            //     print('Error during OneSignal logout: ' + e.toString());
                            //   }
                            // }

                            // await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
                            // OneSignal.initialize("83bf44d9-7476-43d1-b9ff-e362021e18dd");
                            // // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
                            // await OneSignal.Notifications.requestPermission(true);
                            // await OneSignal.logout();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          verticalSpace(18),
        ],
      ),
    );
  }
}
