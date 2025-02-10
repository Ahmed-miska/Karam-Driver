import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';



class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contantPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final Function(String) validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextDirection? textDirection;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;

  const AppTextFormField({
    super.key,
    this.contantPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    required this.validator,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.textDirection, this.focusNode, this.onEditingComplete, this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:textInputAction ,
      focusNode:focusNode ,
      onEditingComplete:onEditingComplete ,
      textDirection: textDirection ?? TextDirection.rtl,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contantPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.main, width: 1),
              borderRadius: BorderRadius.circular(14),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffCFD1D3), width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16),
        ),
        hintStyle: hintStyle ?? AppStyles.font13White400.copyWith(color: const Color(0xffC3C3D5)),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? AppColors.white,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: AppStyles.font16Black500,
      textAlign: TextAlign.right,
      validator: (value) {
        return validator(value!);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
