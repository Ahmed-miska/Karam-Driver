import 'package:get/get.dart';

import '../data/data/repo/sign_in_repo.dart';
import 'sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInRepo>(() => SignInRepo());
    Get.lazyPut<SignInController>(() => SignInController(Get.find<SignInRepo>()));
  }
}
