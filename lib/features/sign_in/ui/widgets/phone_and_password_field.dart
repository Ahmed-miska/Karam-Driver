import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/sign_in_controller.dart';



class PhoneAndPasswordField extends StatefulWidget {
  const PhoneAndPasswordField({super.key});

  @override
  State<PhoneAndPasswordField> createState() => _PhoneAndPasswordFieldState();
}

class _PhoneAndPasswordFieldState extends State<PhoneAndPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (controller) {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            AppTextFormField(
              textInputAction: TextInputAction.next,
              focusNode: controller.phoneFocusNode,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              controller: controller.phoneController,
              hintText: ' 07xxxxxxxxx - كتابه رقم الجوال باللغه الانجليزية',
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
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(controller.passwordFocusNode);
              },
            ),
            verticalSpace(15),
            AppTextFormField(
              textInputAction: TextInputAction.done,
              focusNode: controller.passwordFocusNode,
              textDirection: TextDirection.ltr,
              controller: controller.passwordController,
              hintText: 'كلمة المرور',
              isObscureText: obscureText,
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 12.w),
                child: SvgPicture.asset(AppAssets.lockSvg),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xffC3C3D5), size: 22),
                ),
              ),
              validator: (val) {
                // ignore: unnecessary_null_comparison
                if (val == null || val.isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                if (val.length < 5) {
                  return 'كلمة المرور غير صالحة';
                }
                return null;
              },
              onEditingComplete: () {
                controller.passwordFocusNode.unfocus();
              },
            ),
          ],
        ),
      );
    });
  }
}
