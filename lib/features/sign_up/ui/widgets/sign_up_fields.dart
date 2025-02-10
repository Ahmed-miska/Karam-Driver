import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/map_screen.dart';
import '../../logic/sign_up_controller.dart';
import 'select_area.dart';



class SignUpFields extends StatefulWidget {
  const SignUpFields({super.key});

  @override
  State<SignUpFields> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends State<SignUpFields> {
  bool obscureText = true;
  bool obscureText2 = true;
  String lat = '';
  String long = '';
  LatLng? _savedLocation;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Column(
            children: [
              AppTextFormField(
                focusNode: controller.nameFocusNode,
                hintText: 'الاسم كاملا',
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.userSvg),
                ),
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (value.length < 5) {
                    return 'الاسم غير صالح';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.phoneFocusNode);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.phoneFocusNode,
                textDirection: TextDirection.ltr,
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                hintText: ' 07xxxxxxxxx - كتابه رقم الجوال باللغه الانجليزية',
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 8.h, bottom: 8.h, right: 10.w),
                  child: SvgPicture.asset(AppAssets.phoneSvg),
                ),
                validator: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val == null || val.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (AppRegex.isPhoneNumberValid(val)) {
                    return null;
                  }
                  return 'رقم الجوال غير صالح';
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.addressFocusNode);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                readOnly: true,
                focusNode: controller.addressFocusNode,
                controller: controller.addressController,
                hintText: 'بابل - الحله',
                keyboardType: TextInputType.name,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.addressSvg),
                ),
                validator: (value) {
                  // ignore: unnecessary_null_comparison
                  if (value == null || value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  } else if (value.length < 5) {
                    return 'العنوان غير صالح';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.areaFocusNode);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.areaFocusNode,
                hintText: 'المنطقة',
                readOnly: true,
                controller: controller.areaController,
                onTap: () async {
                  await controller.getAreasList(1, '');
                  Get.bottomSheet(
                    const SelectArea(),
                    isScrollControlled: true,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.passwordFocusNode);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.passwordFocusNode,
                textDirection: TextDirection.ltr,
                controller: controller.passwordController,
                hintText: 'كلمة المرور',
                isObscureText: obscureText,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.lockSvg),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: const Color(0xffC3C3D5),
                      size: 22,
                    ),
                  ),
                ),
                validator: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val == null || val.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (val.length < 5) {
                    return 'كلمة المرور غير صالحة';
                  }
                  return null;
                },
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(controller.confirmPasswordFocusNode);
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                focusNode: controller.confirmPasswordFocusNode,
                textDirection: TextDirection.ltr,
                controller: controller.confirmPasswordController,
                hintText: 'تأكيد كلمة المرور',
                isObscureText: obscureText2,
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h, right: 12.w),
                  child: SvgPicture.asset(AppAssets.lockSvg),
                ),
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
                validator: (val) {
                  // ignore: unnecessary_null_comparison
                  if (val == null || val.isEmpty) {
                    return 'هذا الحقل مطلوب';
                  }
                  if (val != controller.passwordController.text) {
                    return 'كلمة المرور غير متطابقة';
                  }
                  return null;
                },
                onEditingComplete: () {
                  controller.confirmPasswordFocusNode.unfocus();
                },
              ),
              verticalSpace(15),
              AppTextFormField(
                readOnly: true,
                onTap: () async {
                  // Navigate to the MapPage and wait for a result.
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                  if (result != null && result is LatLng) {
                    setState(() {
                      _savedLocation = result;
                      controller.locationController.text = '${_savedLocation!.latitude}, ${_savedLocation!.longitude}';
                    });

                    debugPrint('Saved Location: ${_savedLocation!.latitude}, ${_savedLocation!.longitude}');
                  }
                },
                controller: controller.locationController,
                hintText: 'اختياري',
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 8.h, bottom: 8.h, right: 10.w),
                  child: SvgPicture.asset(AppAssets.earthSvg),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 13.h, bottom: 13.h, right: 10.w),
                  child: SvgPicture.asset(AppAssets.locationSvg),
                ),
                validator: (value) {
                  return null;
                },
              ),
              verticalSpace(20),
            ],
          ),
        );
      },
    );
  }
}
