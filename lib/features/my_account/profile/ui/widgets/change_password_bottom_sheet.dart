import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../profile/ui/widgets/change_password_text_fields.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        width: double.maxFinite,
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
            Container(
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(.05),
                    blurRadius: 6,
                    spreadRadius: 0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(child: Text('تغيير كلمة المرور', style: AppStyles.font18Main400)),
                  verticalSpace(16),
                  Text('كلمة المرور الحالية', style: AppStyles.font15Black400),
                  verticalSpace(10),
                  const ChangePasswordTextFields()
                ],
              ),
            ),
            verticalSpace(18),
          ],
        ),
      ),
    );
  }
}
