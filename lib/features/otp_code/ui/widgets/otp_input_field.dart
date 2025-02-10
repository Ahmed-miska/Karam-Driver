import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/otp_controller.dart';


class OtpInputField extends StatelessWidget {
  const OtpInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: Get.find<OtpController>().formKey,
      child: Pinput(
        controller: Get.find<OtpController>().otpController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        errorPinTheme: errorPinThem,
        length: 5,
        autofillHints: const [AutofillHints.oneTimeCode],
        autofocus: true,
        textInputAction: TextInputAction.done, // Add this line
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        keyboardType: TextInputType.number,
        showCursor: true,
        // onClipboardFound: (value) {
        //   // Automatically paste the clipboard value into the OTP field
        //   if (value.length == 5) {
        //     Get.find<OtpController>().otpController.text = value;
        //   } else {
        //     // Handle cases where the clipboard value is not valid
        //     debugPrint('Invalid clipboard value: $value');
        //   }
        // },
        // onCompleted: (pin) {
        //   debugPrint(pin);
        //   Get.find<OtpController>().focusNode.unfocus(); // Dismiss the keyboard
        // },
        // onSubmitted: (_) {
        //   Get.find<OtpController>().focusNode.unfocus(); // Dismiss the keyboard
        // },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
        // onTapOutside: (event) {
        //   Get.find<OtpController>().focusNode.unfocus(); // Dismiss the keyboard
        // },
      ),
    );
  }
}

// Pin Theme Definitions
final defaultPinTheme = PinTheme(
  width: 46.h,
  height: 46.h,
  textStyle: AppStyles.font18Black500,
  decoration: BoxDecoration(
    border: Border.all(color: const Color(0xFFECECEC), width: 1),
    borderRadius: BorderRadius.circular(12),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.main),
  borderRadius: BorderRadius.circular(12),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: const Color.fromRGBO(234, 239, 243, 1),
  ),
);

final errorPinThem = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.red),
  borderRadius: BorderRadius.circular(12),
);
