import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/network_controller.dart';
import 'package:karam_driver/core/helpers/save_user_data.dart';



class InitBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await SaveUserData.init();
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<SaveUserData>(SaveUserData(), permanent: true);
  }
}
