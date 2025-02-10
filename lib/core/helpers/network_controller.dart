import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/theming/styles.dart';


class NetworkController extends GetxController {
  bool isSnackbar = true;
  StreamSubscription? streamSubscription;
  Timer? reconnectionTimer; // Timer to delay the reconnection snackbar
  Duration reconnectionDelay = const Duration(seconds: 5); // Delay to confirm reconnection

  @override
  void onInit() {
    super.onInit();

    streamSubscription = InternetConnection().onStatusChange.listen((event) async {
      _handleNetworkChange(event);
    });
  }

  void _handleNetworkChange(InternetStatus event) {
    switch (event) {
      case InternetStatus.connected:
        _handleReconnection();
        break;

      case InternetStatus.disconnected:
        _handleDisconnection();
        break;
      }
  }

  void _handleDisconnection() {
    // Cancel any pending reconnection timer
    reconnectionTimer?.cancel();

    isSnackbar = true;
    update();

    // Show the snackbar immediately for disconnection
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        duration: const Duration(days: 1),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              color: Colors.white,
              size: 30,
            ),
            horizontalSpace(10),
            Text("لا يوجد اتصال بالانترنت", style: AppStyles.font12white400),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _handleReconnection() {
    // Cancel any existing reconnection timer
    reconnectionTimer?.cancel();
    // Set a delay to confirm that the connection is stable before showing the reconnection snackbar
    reconnectionTimer = Timer(reconnectionDelay, () {
      isSnackbar = false;
      update();

      // Show the snackbar for reconnection after the delay
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 500),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi,
                color: Colors.white,
                size: 30,
              ),
              horizontalSpace(10),
              Text('تم اعاده الاتصال بالانترنت', style: AppStyles.font12white400),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );

      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
      Get.closeAllSnackbars();
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    reconnectionTimer?.cancel(); // Cancel reconnection timer if active
    super.dispose();
  }
}
