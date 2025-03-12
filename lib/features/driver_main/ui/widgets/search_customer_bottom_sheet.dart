import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/app_assets.dart';
import 'package:karam_driver/core/helpers/app_regex.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/core/widgets/app_text_form_field.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_controller.dart';
import 'package:karam_driver/features/driver_main/ui/widgets/customer_details.dart';

class SearchCustomerBottomSheet extends StatefulWidget {
  const SearchCustomerBottomSheet({super.key});

  @override
  State<SearchCustomerBottomSheet> createState() => _SearchCustomerBottomSheetState();
}

class _SearchCustomerBottomSheetState extends State<SearchCustomerBottomSheet> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: GetBuilder<DriverMainController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              verticalSpace(20),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'ابحث عن العميل',
                  style: AppStyles.font16Main400,
                ),
              ),
              verticalSpace(20),
              Text('رقم الجوال', style: AppStyles.font14Black400),
              verticalSpace(20),
              Form(
                key: controller.formKey,
                child: AppTextFormField(
                  controller: controller.searchController,
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.phone,
                  hintText: 'رقم الجوال',
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
                ),
              ),
              verticalSpace(20),
              AppTextButton(
                  text: 'بحث',
                  onTap: () async {
                    if (controller.formKey.currentState!.validate()) {
                      await controller.searchClient();
                    }
                  }),
              verticalSpace(30),
              // const CustomerDetails(),
            ],
          );
        },
      ),
    );
  }
}
