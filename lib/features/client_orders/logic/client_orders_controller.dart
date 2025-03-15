import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/networking/api_error_handler.dart';
import '../../../core/networking/api_response.dart';
import '../../../core/widgets/custom_snack_bar.dart';
import '../data/model/client_order_response_model.dart';
import '../data/model/order_details_response_model.dart';
import '../data/model/order_status_response_model.dart';
import '../data/repo/add_order_repo.dart';



class ClientOrdersController extends GetxController {
  final AddOrderRepo addOrderRepo;

  ClientOrdersController(this.addOrderRepo);
  List<Order> orders = [];
  List<OrderStatusModel> orderStatusList = [];
  ClientOrderResponseModel? clientOrderResponseModel;
  OrderDetailsResponseModel? orderDetailsResponseModel;
  OrderStatusResponseModel? orderStatusResponseModel;
  bool isLoading = false;
  bool isError = false;
  var error = '';
  bool isLoadingdetails = false;
  bool isErrordetails = false;
  bool loadStatus = false;
  bool isErrorStatus = false;
  bool noOrders = false;
  var errorStatus = '';
  var errordetails = '';
  var addressId = '1';
  int page = 1;
  ScrollController scrollController = ScrollController();
  int activeStep = 1;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        page = page + 1;
        getOrders(activeStep.toString());
        update();
      }
    });
  }

  Future<ApiResponse> getOrders(String orderStatus) async {
    isLoading = true;
    isError = false;
    error = '';
    update();
    var response = await addOrderRepo.getOrders(orderStatus, page);
    if (response.response != null && response.response!.statusCode == 200) {
      clientOrderResponseModel = ClientOrderResponseModel.fromJson(response.response!.data);
      if (clientOrderResponseModel!.responseData!.orders!.isNotEmpty) {
        orders.addAll(clientOrderResponseModel!.responseData!.orders!);
        isLoading = false;
        isError = false;
        error = '';
        update();
      } else {
        isError = false;
        noOrders = true;
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      isError = true;
      error = ApiErrorHandler.handle(response.error);
      update();
    }

    return response;
  }



  Future<ApiResponse> changeOrderStatus(String orderStatus) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));
    var response = await addOrderRepo.changeOrderStatus(orderDetailsResponseModel!.responseData!.orderId!, orderStatus);
    Get.back();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200) {
        customSnackbar('تم', response.response!.data['response_message']);
        page = 1;
        orders = [];
        await getOrders(activeStep.toString());
        await orderDetails(orderDetailsResponseModel!.responseData!.orderId!);
        update();
        
          Get.back();
        
      } else {
        customSnackbar('خطأ', response.response!.data['response_message']);
        // Future.delayed(const Duration(milliseconds: 800), () {
        //   Get.back();
        // });.
      }
    } else {
      var error = ApiErrorHandler.handle(response.error);
      customSnackbar('خطأ', error);
      // Future.delayed(const Duration(milliseconds: 800), () {
      //   Get.back();
      // });
    }

    return response;
  }

  Future<ApiResponse> orderDetails(String orderId) async {
    await getOrderStatus();
    isErrordetails = false;
    isLoadingdetails = true;
    update();
    var response = await addOrderRepo.orderDetails(orderId);
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_data'].isNotEmpty) {
        orderDetailsResponseModel = OrderDetailsResponseModel.fromJson(response.response!.data);
        isLoadingdetails = false;
        isErrordetails = false;
        errordetails = '';
        update();
      } else {
        isLoadingdetails = false;
        isErrordetails = true;
        errordetails = 'لا يوجد تفاصيل لهذا الطلب';
        update();
      }
    } else {
      isLoadingdetails = false;
      isErrordetails = true;
      errordetails = ApiErrorHandler.handle(response.error);
      update();
    }
    return response;
  }

  Future<ApiResponse> getOrderStatus() async {
    var response = await addOrderRepo.orederStatus();
    if (response.response != null && response.response!.statusCode == 200) {
      if (response.response!.data['response_code'] == 200 && response.response!.data['response_data'] != null) {
        orderStatusResponseModel = OrderStatusResponseModel.fromJson(response.response!.data);
        orderStatusList = orderStatusResponseModel!.responseData!;
        update();
      }
    } else {}
    return response;
  }

  Future<void> restart(){
    page = 1;
    orders = [];
    return  getOrders(activeStep.toString());
  }
}
