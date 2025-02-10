import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/back_app_bar.dart';
import '../../../core/widgets/cancel_order_button.dart';
import '../../client_orders/logic/client_orders_controller.dart';
import 'widgets/order_details_container_in_order_details.dart';
import 'widgets/order_details_stepper_container.dart';
import 'widgets/products_container_in_order_details.dart';


class ClientOrderDetailsScreen extends StatefulWidget {
  const ClientOrderDetailsScreen({super.key});

  @override
  State<ClientOrderDetailsScreen> createState() => _ClientOrderDetailsScreenState();
}

class _ClientOrderDetailsScreenState extends State<ClientOrderDetailsScreen> {
  String id = Get.parameters['id']!;
  @override
  void initState() {
    Get.find<ClientOrdersController>().orderDetails(id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                BackAppBar(
                  title: 'تفاصيل الطلب',
                  onTap: () async {
                    Get.find<ClientOrdersController>().page = 1;
                    Get.find<ClientOrdersController>().orders = [];
                    Get.find<ClientOrdersController>().getOrders(Get.find<ClientOrdersController>().activeStep.toString());
                    Get.back();
                  },
                ),
                verticalSpace(30),
                GetBuilder<ClientOrdersController>(
                  builder: (controller) {
                    if (controller.isLoadingdetails || controller.orderStatusList.isEmpty) {
                      return Column(
                        children: [
                          verticalSpace(300),
                          const Center(child: CircularProgressIndicator()),
                        ],
                      );
                    }
                    if (controller.isErrordetails) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          verticalSpace(300),
                          Center(
                            child: Text(
                              controller.errordetails,
                              style: AppStyles.font14Black400,
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        const OrderDetailsStepperContainer(),
                        verticalSpace(12),
                        const ProductsContainerInOrderDetails(),
                        verticalSpace(12),
                        const OrderDetailsContainerInOrderDetails(),
                        verticalSpace(50),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.orderDetailsResponseModel!.responseData!.actions!.length,
                          itemBuilder: (context, index) {
                            if (controller.orderDetailsResponseModel!.responseData!.actions![index].statusNumber == 2) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppTextButton(
                                  text: controller.orderDetailsResponseModel!.responseData!.actions![index].statusName ?? '',
                                  onTap: () async {
                                    await controller.changeOrderStatus(
                                      controller.orderDetailsResponseModel!.responseData!.actions![index].statusNumber.toString(),
                                    );
                                    // Get.back();
                                    // await Get.find<OrderStatusController>().changeOrderStatus(
                                    //   controller.sellerOrderDetailsResponseModel!.responseData!.orderId!,
                                    //   controller.sellerOrderDetailsResponseModel!.responseData!.actions![index].statusNumber.toString(),
                                    // );
                                  },
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CancelOrderButton(
                                  text: controller.orderDetailsResponseModel!.responseData!.actions![index].statusName ?? '',
                                  onTap: () async {
                                    await controller.changeOrderStatus(
                                      controller.orderDetailsResponseModel!.responseData!.actions![index].statusNumber.toString(),
                                    );
                                    //  Get.back();
                                    // await Get.find<OrderStatusController>().changeOrderStatus(
                                    //   controller.sellerOrderDetailsResponseModel!.responseData!.orderId!,
                                    //   controller.sellerOrderDetailsResponseModel!.responseData!.actions![index].statusNumber.toString(),
                                    // );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
