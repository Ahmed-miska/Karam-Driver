import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/app_assets.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/features/my_account/page_screen/logic/get_page_controller.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform; // Import to check for mobile platforms
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:webview_flutter_web/webview_flutter_web.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/back_app_bar.dart'; // To check if it's web

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  String page = Get.parameters['pageName'] ?? '';
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    Get.find<GetPageController>().getPage(page);

    if (kIsWeb) {
      // Web specific initialization
      WebViewPlatform.instance = WebWebViewPlatform();
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Initialize WebViewController for Android or iOS
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(AppColors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: GetBuilder<GetPageController>(builder: (controllerr) {
            if (controllerr.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controllerr.isError) {
              return Center(
                child: Text(controllerr.error),
              );
            }

            // Load content for web or mobile
            if (kIsWeb) {
              controller = WebViewController()..loadHtmlString(Get.find<GetPageController>().getPageResponseModel!.responseData!.pageContent!);
            } else if (Platform.isAndroid || Platform.isIOS) {
              controller.loadHtmlString(Get.find<GetPageController>().getPageResponseModel!.responseData!.pageContent!);
            }

            return Column(
              children: [
                BackAppBar(title: controllerr.getPageResponseModel!.responseData!.pageTitle!),
                verticalSpace(20),
                SvgPicture.asset(AppAssets.logoSvg),
                Expanded(
                  child: kIsWeb || Platform.isAndroid || Platform.isIOS ? WebViewWidget(controller: controller) : const Center(child: Text('WebView is not supported on this platform.')),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
