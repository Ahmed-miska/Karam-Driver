import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/sign_up_controller.dart';

class SignUpFields extends StatefulWidget {
  const SignUpFields({super.key});

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  bool obscureText = true;
  bool obscureText2 = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Column(
            children: [
              AppTextFormField(
                focusNode: controller.nameFocus,
                hintText: 'الاسم كاملا',
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.userSvg),
                ),
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (value.length < 5) {
                    return 'الاسم غير صالح';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.phoneFocus);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.phoneFocus,
                textDirection: TextDirection.ltr,
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
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
                  FocusScope.of(context).requestFocus(controller.addressFocus);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.addressFocus,
                controller: controller.addressController,
                readOnly: true,
                onTap: () async {},
                hintText: 'المحافظه',
                keyboardType: TextInputType.name,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.addressSvg),
                ),
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (value.length < 5) {
                    return 'العنوان غير صالح';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.workplaceFocus);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.workplaceFocus,
                controller: controller.workplaceController,
                hintText: 'اسم شركه التوصيل',
                keyboardType: TextInputType.name,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.locationSvg),
                ),
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (value.length < 5) {
                    return 'العنوان غير صالح';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.passwordFocus);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.passwordFocus,
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
                    child: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xffC3C3D5),
                      size: 22,
                    ),
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
                  FocusScope.of(context).requestFocus(controller.confirmPasswordFocus);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.confirmPasswordFocus,
                textDirection: TextDirection.ltr,
                controller: controller.confirmPasswordController,
                hintText: 'تأكيد كلمة المرور',
                isObscureText: obscureText2,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.lockSvg),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                    child: Icon(
                      obscureText2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xffC3C3D5),
                      size: 22,
                    ),
                  ),
                ),
                validator: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val == null || val.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (val != controller.passwordController.text) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
                onEditingComplete: () {
                  controller.confirmPasswordFocus.unfocus();
                },
              ),
              verticalSpace(15),
            ],
          ),
        );
      },
    );
  }
}
