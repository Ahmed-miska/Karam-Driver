import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../my_account/profile/logic/profile_controller.dart';


class ProfileTextFields extends StatelessWidget {
  const ProfileTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AppTextFormField(
            controller: controller.nameController,
            prefixIcon: const Icon(Icons.edit, color: AppColors.grey2),
            hintText: '',
            validator: (value) => null,
          ),
          verticalSpace(10),
          Text('رقم الجوال', style: AppStyles.font15Main500),
          verticalSpace(15),
          AppTextFormField(
            controller: controller.phoneController,
            prefixIcon: const Icon(Icons.edit, color: AppColors.grey2),
            hintText: '',
            validator: (value) => null,
          ),
          verticalSpace(10),
          Text('كلمة المرور', style: AppStyles.font15Main500),
          verticalSpace(15),
          AppTextFormField(
            readOnly: true,
            onTap: () {
              controller.changePassword();
            },
            controller: controller.passwordController,
            prefixIcon: const Icon(Icons.edit, color: AppColors.grey2),
            hintText: '',
            validator: (value) => null,
            isObscureText: true,
          ),
        ],
      );
    });
  }
}
