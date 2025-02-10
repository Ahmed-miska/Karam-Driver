import 'package:get/get.dart';
import 'package:karam_driver/features/confirm_password/data/repo/confirm_password_repo.dart';
import 'package:karam_driver/features/confirm_password/logic/confirm_password_controller.dart';


class ConfirmPasswordBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmPasswordRepo());
    Get.lazyPut(() => ConfirmPasswordController(Get.find<ConfirmPasswordRepo>()));
  }
}