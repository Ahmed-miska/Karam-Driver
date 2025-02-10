import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/widgets/app_text_button.dart';
import '../../logic/sign_in_controller.dart';


class SigninButton extends StatelessWidget {
  const SigninButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
      builder: (controller) {
        return AppTextButton(
          radius: 14,
          text: 'تسجيل الدخول',
          onTap: () {
            controller.login();
          },
        );
      },
    );
  }
}
