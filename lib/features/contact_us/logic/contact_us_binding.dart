import 'package:get/get.dart';
import 'package:karam_driver/features/contact_us/data/repo/contact_us_repo.dart';
import 'package:karam_driver/features/contact_us/logic/contact_us_controller.dart';



class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsRepo());
    Get.lazyPut(() => ContactUsController(Get.find<ContactUsRepo>()),fenix: true);
  }
}
