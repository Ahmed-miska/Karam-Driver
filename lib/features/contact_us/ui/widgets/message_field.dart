import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theming/colors.dart';
import '../../logic/contact_us_controller.dart';


class MessageField extends StatelessWidget {
  final Function(String) validator;
  const MessageField({
    super.key,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(builder: (controller) {
      return TextFormField(
        controller: controller.messageController,
        textAlign: TextAlign.end,
        minLines: 5,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.white2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.white2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.main, width: 1),
            borderRadius: BorderRadius.circular(14),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.3),
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: AppColors.white,
        ),
        validator: (value) {
          return validator(value!);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );
    });
  }
}
