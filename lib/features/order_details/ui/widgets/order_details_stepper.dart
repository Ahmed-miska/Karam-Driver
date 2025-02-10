import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theming/colors.dart';
import '../../../client_orders/logic/client_orders_controller.dart';


class OrderDetailsStepper extends StatelessWidget {
  const OrderDetailsStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersController>(
      builder: (controller) {
        return SizedBox(
          height: 100.h,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.orderStatusList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  print('wcfdddddddddddddddddddddd');
                  print(controller.orderStatusList[int.parse(controller.orderDetailsResponseModel!.responseData!.orderStatus!) - 1].id);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        // ignore: unrelated_type_equality_checks
                        Icon(Icons.check_circle,
                            color: int.parse(controller.orderStatusList[int.parse(controller.orderDetailsResponseModel!.responseData!.orderStatus!) - 1].id!) == index
                                ? AppColors.main
                                : AppColors.grey2),
                        Text(controller.orderStatusList[index].statusName ?? '',
                            style: TextStyle(
                                color: int.parse(controller.orderStatusList[int.parse(controller.orderDetailsResponseModel!.responseData!.orderStatus!) - 1].id!) == index
                                    ? AppColors.main
                                    : AppColors.grey2)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
