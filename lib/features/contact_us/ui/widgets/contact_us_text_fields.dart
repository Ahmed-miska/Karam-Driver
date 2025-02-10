import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/app_regex.dart';
import 'package:karam_driver/core/theming/colors.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/features/contact_us/ui/widgets/message_field.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/contact_us_controller.dart';


class ContactUsTextFields extends StatelessWidget {
  const ContactUsTextFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (controller) {
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppTextFormField(
              hintText: '',
              validator: (value) {
                if (!AppRegex.isPhoneNumberValid(value)) {
                  return 'رقم الجوال غير صالح';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              controller: controller.phoneController,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            verticalSpace(10),
            Text('عنوان الرسالة', style: AppStyles.font15Black500),
            verticalSpace(15),
            AppTextFormField(
              hintText: '',
              validator: (value) {
                if (value.isEmpty) {
                  return 'يجب تعبئة الحقل';
                }
                if (value.length < 5) {
                  return 'يجب ان يكون عنوان الرسالة مكون من 5 حروف على الاقل';
                }
                return null;
              },
              controller: controller.messageAddressController,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.white, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            verticalSpace(10),
            Text('نص الرسالة', style: AppStyles.font15Black500),
            verticalSpace(15),
            MessageField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'يجب تعبئة الحقل';
                }
                if (value.length < 10) {
                  return 'يجب ان يكون نص الرسالة مكون من 10 حروف على الاقل';
                }
                return null;
              },
            ),
          ],
        ),
      );
    });
  }
}
