import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../logic/client_orders_controller.dart';
import 'widgets/order_item_client_order.dart';
import 'widgets/orders_tabs.dart';

class DriverOrderScreen extends StatefulWidget {
  const DriverOrderScreen({super.key});

  @override
  State<DriverOrderScreen> createState() => _DriverOrderScreenState();
}

class _DriverOrderScreenState extends State<DriverOrderScreen> {
  @override
  void initState() {
    Get.find<ClientOrdersController>().page = 1;
    Get.find<ClientOrdersController>().isLoading = true;
    Get.find<ClientOrdersController>().orders = [];
    Get.find<ClientOrdersController>().getOrders(Get.find<ClientOrdersController>().activeStep.toString());
    // if (Get.find<ClientOrdersController>().orders.isEmpty) {
    //   Get.find<ClientOrdersController>().isError = true;
    //   Get.find<ClientOrdersController>().error = 'لا توجد طلبات';
    // }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            verticalSpace(30),
            const OrdersTabs(),
            verticalSpace(20),
            Expanded(
              child: GetBuilder<ClientOrdersController>(
                builder: (controller) {
                  if (controller.isLoading && controller.page == 1) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.orders.isEmpty && controller.page == 1) {
                    return Center(child: Text('لا يوجد طلبات', style: AppStyles.font14Black400));
                  }
                  if (controller.isError) {
                    return Center(child: Text(controller.error, style: AppStyles.font14Black400));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      controller.page = 1;
                      controller.orders.clear();
                      controller.isLoading = true;
                      controller.isError = false;
                      controller.update();
                      await controller.getOrders(controller.activeStep.toString());
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: controller.scrollController,
                      shrinkWrap: true,
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 13.h),
                          child: InkWell(
                            onTap: () async {
                             

                              // Get.toNamed(AppRoutes.clientOrderDetailsScreen, parameters: {
                              //   'id': controller.orders[index].id!,
                              // });
                            },
                            child: OrderItemClientOrder(
                              order: controller.orders[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
