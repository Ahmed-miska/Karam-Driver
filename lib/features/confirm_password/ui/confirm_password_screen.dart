import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/core/widgets/app_text_form_field.dart';
import 'package:karam_driver/features/confirm_password/data/model/active_forget_user_request_model.dart';
import 'package:karam_driver/features/confirm_password/logic/confirm_password_controller.dart';
import 'package:karam_driver/features/forget_password/logic/forget_password_controller.dart';

import '../../../core/theming/colors.dart';


class ConfirmPasswordScreen extends StatefulWidget {
  const ConfirmPasswordScreen({super.key});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: GetBuilder<ConfirmPasswordController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(child: Text('تغيير كلمة المرور', style: AppStyles.font20Main500)),
                    verticalSpace(40),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(' كلمة المرور', style: AppStyles.font16Black400),
                          verticalSpace(10),
                          AppTextFormField(
                            hintText: 'كلمة المرور',
                            isObscureText: obscureText1,
                            controller: controller.passwordController,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    obscureText1 = !obscureText1;
                                  });
                                },
                                child: Icon(
                                  obscureText1 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xffC3C3D5),
                                  size: 22,
                                ),
                              ),
                            ),
                            validator: (controllerr) {
                              // ignore: unnecessary_null_comparison
                              if (controllerr == null || controllerr.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (controllerr.length < 5) {
                                return 'كلمة المرور غير صالحة';
                              }

                              return null;
                            },
                          ),
                          verticalSpace(20),
                          Text('تاكيد كلمة المرور', style: AppStyles.font16Black400),
                          verticalSpace(10),
                          AppTextFormField(
                            hintText: 'تاكيد كلمة المرور',
                            isObscureText: obscureText2,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    obscureText2 = !obscureText2;
                                  });
                                },
                                child: Icon(
                                  obscureText2 ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xffC3C3D5),
                                  size: 22,
                                ),
                              ),
                            ),
                            validator: (controllerr) {
                              if (controllerr.isEmpty) {
                                return 'هذا الحقل مطلوب';
                              }
                              if (controllerr != controller.passwordController.text) {
                                return 'كلمة المرور غير متطابقة';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(60),
                    AppTextButton(
                      text: 'تغيير كلمة المرور',
                      onTap: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.activeForgetPassword(
                            ActiveForgetUserRequestModel(
                              newPassword: controller.passwordController.text,
                              activationCode: Get.find<ForgetPasswordController>().code,
                              mobile: Get.find<ForgetPasswordController>().phoneController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
