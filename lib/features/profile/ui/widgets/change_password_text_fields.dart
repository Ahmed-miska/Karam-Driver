import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../my_account/profile/data/model/renew_password_request_model.dart';
import '../../../my_account/profile/logic/profile_controller.dart';



class ChangePasswordTextFields extends StatefulWidget {
  const ChangePasswordTextFields({
    super.key,
  });

  @override
  State<ChangePasswordTextFields> createState() => _ChangePasswordTextFieldsState();
}

class _ChangePasswordTextFieldsState extends State<ChangePasswordTextFields> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppTextFormField(
              controller: controller.currentPasswordController,
              onTap: () {},
              isObscureText: obscureText1,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText1 = !obscureText1;
                    });
                  },
                  child: Icon(obscureText1 ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xffC3C3D5), size: 22),
                ),
              ),
              hintText: 'كلمة المرور الحالية',
              validator: (value) {
                // ignore: unnecessary_null_comparison
                if (value == null || value.isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                if (value.length < 5) {
                  return 'كلمة المرور يجب الا يقل عن 5 حروف';
                }
                return null;
              },
            ),
            verticalSpace(10),
            Text('كلمة المرور الجديدة', style: AppStyles.font15Black400),
            verticalSpace(10),
            AppTextFormField(
              hintText: 'كلمة المرور الجديدة',
              isObscureText: obscureText2,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText2 = !obscureText2;
                    });
                  },
                  child: Icon(obscureText2 ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xffC3C3D5), size: 22),
                ),
              ),
              controller: controller.newPasswordController,
              validator: (value) {
                // ignore: unnecessary_null_comparison
                if (value == null || value.isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                if (value.length < 5) {
                  return 'كلمة المرور يجب الا يقل عن 5 حروف';
                }
                return null;
              },
            ),
            verticalSpace(10),
            Text('تأكيد كلمة المرور الجديدة', style: AppStyles.font15Black400),
            verticalSpace(10),
            AppTextFormField(
              isObscureText: obscureText3,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      obscureText3 = !obscureText3;
                    });
                  },
                  child: Icon(obscureText3 ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xffC3C3D5), size: 22),
                ),
              ),
              hintText: 'تاكيد كلمة المرور الجديدة',
              controller: controller.confirmPasswordController,
              validator: (value) {
                // ignore: unnecessary_null_comparison
                if (value == null || value.isEmpty) {
                  return 'هذا الحقل مطلوب';
                }
                if (value != controller.newPasswordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
            ),
            verticalSpace(50),
            AppTextButton(
              text: 'حفظ التعديلات',
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.renewPassword(
                    RenewPasswordRequestModel(
                      userId: SaveUserData().getUserId(),
                      oldPassword: controller.currentPasswordController.text,
                      newPassword: controller.newPasswordController.text,
                      mobile: SaveUserData().getUserData()!.mobile.toString(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      );
    });
  }
}
