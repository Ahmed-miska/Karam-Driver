import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/features/sign_up/logic/sign_up_controller.dart';



class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return AppTextButton(
          text: 'تسجيل لاول مره',
          onTap: () {
            if (controller.formKey.currentState!.validate()) {
              controller.signUp();
            }
          },
        );
      },
    );
  }
}
