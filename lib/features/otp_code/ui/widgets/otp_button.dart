import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../logic/otp_controller.dart';


class OtpButton extends StatelessWidget {
  final String text;
  const OtpButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
      builder: (controller) {
        return AppTextButton(
          text: 'تأكيد',
          color: controller.isVaild ? AppColors.main : AppColors.grey,
          onTap: () {
            if (controller.isVaild && controller.formKey.currentState!.validate()) {
              if (text == 'signUp') {
                controller.submit();
              }
              else{
                controller.verify();
              }
              
            }
          },
        );
      },
    );
  }
}
