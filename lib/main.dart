import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/binging_helper.dart';
import 'package:karam_driver/deep_linking.dart';
import 'package:karam_driver/init_binding.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await InitBinding().dependencies();

  if (kIsWeb) {
    WebViewPlatform.instance = WebWebViewPlatform();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeDeepLinking();
  }

  Future<void> _initializeDeepLinking() async {
    try {
      await AppLinkService().initialize();
    } catch (e) {
      debugPrint('Deep linking initialization failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          routingCallback: (routing) {
            print('Previous route: ${routing?.previous}');
            print('Current route: ${routing?.current}');
          },
          initialRoute: AppRoutes.signInPage,
          initialBinding: InitBinding(),
          getPages: AppPages.pages,
          enableLog: true,
          debugShowCheckedModeBanner: false,
          title: 'Dalleni',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
