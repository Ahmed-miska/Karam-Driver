import 'package:get/get.dart';

import '../../my_account/profile/data/repo/renew_password_repo.dart';
import '../../my_account/profile/logic/profile_controller.dart';



class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RenewPasswordRepo());
    Get.lazyPut(() => ProfileController(Get.find<RenewPasswordRepo>()));
  }
}
