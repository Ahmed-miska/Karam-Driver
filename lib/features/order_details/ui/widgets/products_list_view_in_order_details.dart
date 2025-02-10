import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../client_orders/logic/client_orders_controller.dart';
import 'product_of_order_details.dart';



class ProductsListViewInOrderDetails extends StatelessWidget {
  const ProductsListViewInOrderDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersController>(builder: (controller) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.orderDetailsResponseModel!.responseData!.items!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ProductOfOrderDetails(
                item: controller.orderDetailsResponseModel!.responseData!.items![index],
              ),
              verticalSpace(10),
              index > controller.orderDetailsResponseModel!.responseData!.items!.length - 1 ? SizedBox(height: 10.h) : const Divider(thickness: 1),
              verticalSpace(5),
            ],
          );
        },
      );
    });
  }
}
