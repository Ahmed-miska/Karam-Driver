import 'package:get/get.dart';

import '../data/repo/show_commerical_notification_repo.dart';
import 'show_commercial_notifacation_controller.dart';


class ShowCommercialNotifacationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowCommericalNotificationRepo(),fenix: true);
    Get.lazyPut(() => ShowCommercialNotifacationController(Get.find<ShowCommericalNotificationRepo>()),fenix: true);
  }
}
