import 'package:get/get.dart';

import '../data/repo/sign_up_repo.dart';
import 'sign_up_controller.dart';


class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AreasListRepo>(() => AreasListRepo());
    Get.lazyPut<SignUpRepo>(() => SignUpRepo());
    Get.lazyPut<SignUpController>(() => SignUpController(Get.find<SignUpRepo>()));
  }
  
}