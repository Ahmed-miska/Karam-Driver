import 'package:flutter/material.dart';

import '../theming/colors.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      icon: isChecked
          ? const Icon(
              Icons.check_box,
              color: AppColors.main,
            )
          : const Icon(
              Icons.check_box_outline_blank,
              color: AppColors.grey2,
            ),
    );
  }
}
