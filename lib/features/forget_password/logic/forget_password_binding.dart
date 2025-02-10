import 'package:get/get.dart';

import '../data/repo/forget_password_repo.dart';
import 'forget_password_controller.dart';


class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordRepo());
    Get.lazyPut(() => ForgetPasswordController(ForgetPasswordRepo()));
  }
}
