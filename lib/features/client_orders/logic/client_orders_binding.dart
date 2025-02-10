import 'package:get/get.dart';

import '../data/repo/add_order_repo.dart';
import 'client_orders_controller.dart';



class ClientOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddOrderRepo());
    Get.put(ClientOrdersController(Get.find<AddOrderRepo>()), permanent: true);
  }
}
