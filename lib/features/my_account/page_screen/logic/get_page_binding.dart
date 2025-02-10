import 'package:get/get.dart';
import 'package:karam_driver/features/my_account/page_screen/data/repo/get_page_repo.dart';

import 'get_page_controller.dart';


class GetPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetPageRepo());

    Get.lazyPut(() => GetPageController(Get.find<GetPageRepo>()), fenix: true);
  }
}
