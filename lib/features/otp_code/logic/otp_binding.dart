import 'package:get/get.dart';

import '../data/repo/otp_repo.dart';
import 'otp_controller.dart';


class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpRepo());
    Get.lazyPut(() => OtpController(Get.find<OtpRepo>()));
  }
}
