import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../logic/client_orders_controller.dart';
import 'type_of_order_item.dart';


class TypesOfOrderList extends StatefulWidget {
  const TypesOfOrderList({super.key});

  @override
  State<TypesOfOrderList> createState() => _TypesOfOrderListState();
}

class _TypesOfOrderListState extends State<TypesOfOrderList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientOrdersController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: controller.orderStatusResponseModel!.responseData!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(left: index == 3 ? 12.w : 8.w, right: index == 0 ? 12.w : 0),
              child: InkWell(
                onTap: () async {
                  controller.isLoading = true;
                  selectedIndex = index;
                  controller.activeStep = index;
                  controller.page = 1;
                  controller.orders = [];
                  controller.update();
                  await controller.getOrders(controller.orderStatusResponseModel!.responseData![index].id ?? '1');
                  if (controller.orders.isEmpty) {
                    controller.error = 'لا يوجد طلبات';
                    controller.isLoading = false;
                    controller.isError = true;
                    controller.update();
                  }
                },
                child: TypeOfOrderItem(
                  isSelected: index == selectedIndex,
                  title: controller.orderStatusResponseModel!.responseData![index].statusName ?? '',
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
