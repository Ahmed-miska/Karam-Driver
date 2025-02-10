import 'package:get/get.dart';

import '../data/repo/renew_password_repo.dart';
import 'profile_controller.dart';



class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RenewPasswordRepo());
    Get.lazyPut(() => ProfileController(Get.find<RenewPasswordRepo>()));
  }
}
