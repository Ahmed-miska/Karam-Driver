import 'package:get/get.dart';
import 'package:karam_driver/features/driver_main/data/repos/driver_main_repo.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_controller.dart';

class DriverMainBinding with Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DriverMainRepo(), fenix: true);
    Get.lazyPut(() => DriverMainController(driverMainRepo: Get.find<DriverMainRepo>()), fenix: true);
  }
}
