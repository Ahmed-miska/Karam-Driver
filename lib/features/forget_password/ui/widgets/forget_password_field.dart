import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/forget_password_controller.dart';


class ForgetPasswordField extends StatelessWidget {
  const ForgetPasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: AppTextFormField(
            textDirection: TextDirection.ltr,
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            hintText: 'رقم الجوال',
            suffixIcon: Padding(
              padding: EdgeInsets.only(left: 10.w, top: 8.h, bottom: 8.h, right: 10.w),
              child: SvgPicture.asset(AppAssets.phoneSvg),
            ),
            validator: (val) {
              // ignore: unnecessary_null_comparison
              if (val == null || val.isEmpty) {
                return 'هذا الحقل مطلوب';
              } else if (AppRegex.isPhoneNumberValid(val)) {
                return null;
              }
              return 'رقم الجوال غير صالح';
            },
          ),
        );
      },
    );
  }
}
