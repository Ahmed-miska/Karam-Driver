import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import 'order_details_stepper.dart';


class OrderDetailsStepperContainer extends StatelessWidget {

  const OrderDetailsStepperContainer({
    super.key,
  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white2,
      ),
      child: const OrderDetailsStepper(),
    );
  }
}
