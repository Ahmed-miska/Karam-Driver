import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/binging_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/custom_check_box.dart';



class RememberAndForgetPassword extends StatelessWidget {
  const RememberAndForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.forgetPassword);
          },
          child: Text('هل نسيت كلمة المرور؟', style: AppStyles.font14Main400),
        ),
        const Spacer(),
        Text('تذكرني', style: AppStyles.font16Black500),
        horizontalSpace(8),
        const CustomCheckBox(),
      ],
    );
  }
}
