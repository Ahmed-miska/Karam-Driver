import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:karam_driver/core/theming/styles.dart';
import 'package:karam_driver/core/widgets/custom_snack_bar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import 'package:geolocator/geolocator.dart';

import 'package:url_launcher/url_launcher.dart';
import "package:universal_html/js.dart" as js;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: unused_import, avoid_web_libraries_in_flutter
import 'dart:js_util' as js_util;
// Used to detect standalone mode in web apps

class PWAUtils {
  // Checks if the PWA installation prompt is deferred
  static bool isDeferredNotNull() {
    return js.context.callMethod('isDeferredNotNull') as bool;
  }

  // Checks if the PWA is installed
  static bool isPWAInstalled() {
    return js.context.callMethod('isPWAInstalled') as bool;
  }

  // Checks if the installation prompt has been shown
  static Future<bool> hasInstallationPromptBeenShown() async {
    final isPromptShown = js.context.callMethod('localStorage.getItem', ['installPromptShown']);
    return isPromptShown == 'true';
  }
}

Future<Position> getCurrentPosition() async {
  try {
    // Check and request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return Future.error("أذونات الموقع مرفوضة. يرجى تمكين الأذونات من الإعدادات.");
      }
    }
    // Use Future.timeout to handle timeouts manually
    return await Geolocator.getCurrentPosition().timeout(
      const Duration(seconds: 15), // Set timeout duration here
      onTimeout: () {
        return Future.error("تعذر الحصول على الموقع خلال الوقت المحدد. تحقق من الاتصال وحاول مرة أخرى.");
      },
    );
  } catch (e) {
    return Future.error("تعذر الحصول على الموقع. تحقق من الاتصال وحاول مرة أخرى.");
  }
}

// Function to detect if the app is running in standalone mode (PWA)
// Detect if the app is running in PWA standalone mode

void openMap(String destinationLat, String destinationLong) async {
  Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

  try {
    String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$destinationLat,$destinationLong';
    String appleMapsUrl = 'http://maps.apple.com/?q=$destinationLat,$destinationLong';

    String mapUrl = GetPlatform.isIOS ? appleMapsUrl : googleMapsUrl;

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl), mode: LaunchMode.externalApplication);
    } else {
      customSnackbar("خطأ", "لا يمكننا فتح الخريطة");
    }
  } catch (e) {
    Get.snackbar("Error", "حدث خطأ أثناء محاولة فتح الخريطة: $e", colorText: Colors.red);
  } finally {
    Get.back(); // إغلاق مؤشر التحميل سواء نجحت العملية أو فشلت
  }
}

void shareLink(String url) async {
  await Share.share(url, subject: 'Check out this link!');
}

// lib/utils/time_utils.dart
bool isStoreOpen(String openTime, String closeTime) {
  DateTime now = DateTime.now();

  // Parse the open and close times
  List<String> openParts = openTime.split(':');
  List<String> closeParts = closeTime.split(':');

  // Create DateTime objects for today with the open and close times
  DateTime openDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(openParts[0]), // hour
    int.parse(openParts[1]), // minute
    int.parse(openParts[2]), // second
  );

  DateTime closeDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(closeParts[0]), // hour
    int.parse(closeParts[1]), // minute
    int.parse(closeParts[2]), // second
  );

  // Handle case where closing time is past midnight
  if (closeDateTime.isBefore(openDateTime)) {
    closeDateTime = closeDateTime.add(const Duration(days: 1));
  }

  // Check if the current time is within the open and close times
  return now.isAfter(openDateTime) && now.isBefore(closeDateTime);
}

String getTimeDifferenceAsString(String pastTimeString) {
  // Parse the past time string into a DateTime object
  DateTime pastTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(pastTimeString);

  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the difference
  Duration difference = now.difference(pastTime);

  // Extract days, hours, and minutes from the difference
  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;

  // Build the result string, omitting any zero values
  List<String> parts = [];

  if (days > 0) parts.add('$days ${days == 1 ? 'day' : 'days'}');
  if (hours > 0) parts.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
  if (minutes > 0) parts.add('$minutes ${minutes == 1 ? 'minute' : 'minutes'}');

  // Join the parts into a single string
  return parts.isEmpty ? 'Just now' : '${parts.join(', ')} ago';
}

// Future<void> initNotification() async {
//   //Remove this method to stop OneSignal Debugging
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

//   OneSignal.initialize("83bf44d9-7476-43d1-b9ff-e362021e18dd");

// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.Notifications.requestPermission(true);
// }
int stringToIntParse(String input) {
  return int.parse(input);
}

String generateUniqueId() {
  final random = Random();
  final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(0, 5); // First 5 digits of the timestamp
  final randomNumber = random.nextInt(10000).toString().padLeft(4, '0'); // 4-digit random number
  return '$timestamp$randomNumber';
}

bool getBrowserType() {
  if (!kIsWeb) {
    return false; // This is not a web platform, so no need for the alert.
  }

  String userAgent = html.window.navigator.userAgent.toLowerCase();

  // Check if the app is running in standalone mode
  bool isStandalone = html.window.matchMedia('(display-mode: standalone)').matches;

  // Detect Safari (but exclude standalone mode and Chrome on iOS)
  if (!isStandalone && userAgent.contains('safari') && !userAgent.contains('chrome') && !userAgent.contains('crios')) {
    // Show alert message only for Safari in non-standalone mode
    html.window.alert("This application is not supported on Safari. Please use Chrome.");
    return true;
  }
  return false;
}

String extractTime(String dateTimeString) {
  try {
    // Parse the string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the hours and minutes
    return DateFormat('HH:mm').format(dateTime);
  } catch (e) {
    // Handle invalid input
    return 'Invalid date format';
  }
}

Future<Map<String, dynamic>> getVersion() async {
  try {
    // الحصول على معلومات الحزمة من منصة التطبيق
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // إنشاء خريطة (Map) تحتوي على الإصدار ورقم البناء
    return {
      'version': packageInfo.version,
      'build_number': packageInfo.buildNumber,
    };
  } catch (e) {
    // إذا حدث خطأ، يمكن إرجاع خريطة فارغة أو رسالة خطأ
    print("Error fetching version info: $e");
    return {
      'version': 'N/A',
      'build_number': 'N/A',
    };
  }
}

Future<void> checkForUpdates() async {
  print('Checking for updates.....................................');
  try {
    // رابط ملف version.json على السيرفر (تأكد من أن الرابط صحيح)
    final response = await http.get(Uri.parse('https://karamiq.com/version.json'));

    if (response.statusCode == 200) {
      final serverVersion = json.decode(response.body)['version'];
      final buildNumber = json.decode(response.body)['build_number'];

      // الحصول على الإصدار الحالي باستخدام await وانتظار نتيجة getVersion
      Map<String, dynamic> currentVersionInfo = await getVersion();
      final currentVersion = currentVersionInfo['version']; // إصدار التطبيق الحالي
      final currentBuildNumber = currentVersionInfo['build_number']; // رقم البناء التطبيق الحالي
      // فحص إذا كانت القيم غير فارغة أو null
      if (serverVersion != null && currentVersion != null && currentBuildNumber != null && buildNumber != null) {
        print('Server Version: $serverVersion');
        print('server Build Number: $buildNumber');
        print('Current Version: $currentVersion');
        print('Current Build Number: $currentBuildNumber');

        // إذا كان الإصدار على السيرفر مختلفًا عن الإصدار الحالي
        if (serverVersion != currentVersion || currentBuildNumber != buildNumber) {
          // عرض نافذة تطلب من المستخدم تحديث التطبيق
          showUpdateDialog();
        }
      } else {
        print("Error: One of the versions is null.");
      }
    } else {
      print("Error: Unable to fetch version info from the server.");
    }
  } catch (e) {
    print("Error checking for updates: $e");
  }
}

void showUpdateDialog() {
  Get.dialog(
    AlertDialog(
      title: Text("تحديث متاح", style: AppStyles.font16Main600, textAlign: TextAlign.right),
      content: Text("يوجد إصدار جديد من التطبيق. يرجى تحديث التطبيق للاستفادة من المزايا الجديدة.", style: AppStyles.font12Black400, textAlign: TextAlign.right),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // إغلاق النافذة
          },
          child: Text("لاحقًا", style: AppStyles.font12Black400),
        ),
        TextButton(
          onPressed: () {
            // إعادة تحميل الصفحة لتحديث التطبيق
            Get.back(); // إغلاق النافذة
            // إعادة تحميل الصفحة لتحديث التطبيق
            html.window.location.reload(); // هذا سيعيد تحميل التطبيق
          },
          child: Text("تحديث الآن", style: AppStyles.font14Main400),
        ),
      ],
    ),
    barrierDismissible: false, // منع إغلاق النافذة بالضغط خارجها
  );
}
