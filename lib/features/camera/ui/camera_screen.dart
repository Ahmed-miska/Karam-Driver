import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karam_driver/core/helpers/spacing.dart';
import 'package:karam_driver/core/widgets/app_text_button.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_binding.dart';
import 'package:karam_driver/features/driver_main/logic/driver_main_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;
  Uint8List? capturedImage; // تخزين الصورة الملتقطة

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      cameraController = CameraController(_cameras.first, ResolutionPreset.high);
      await cameraController!.initialize();
      setState(() {
        cameras = _cameras;
      });
    }
  }

  void _takePicture() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      final XFile image = await cameraController!.takePicture();
      Uint8List imageBytes = await image.readAsBytes();
      setState(() {
        capturedImage = imageBytes;
        cameraController!.dispose(); // إيقاف الكاميرا بعد التقاط الصورة
        cameraController = null; // إخفاء الكاميرا
      });
    }
  }

  void _retakePicture() async {
    setState(() {
      capturedImage = null;
    });

    // إعادة تشغيل الكاميرا بعد حذف الصورة
    _setupCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  capturedImage == null
                      ? (cameraController == null || !cameraController!.value.isInitialized ? const Center(child: CircularProgressIndicator()) : CameraPreview(cameraController!))
                      : Image.memory(capturedImage!, fit: BoxFit.cover),
                  const Positioned(top: 10, left: 10, child: BackButton()),
                ],
              ),
            ),
            verticalSpace(20),
            Container(
              width: double.infinity,
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (capturedImage == null)
                    Expanded(child: AppTextButton(text: 'التقاط صورة', onTap: _takePicture))
                  else
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: AppTextButton(
                                  text: 'حفظ وعوده',
                                  onTap: () async {
                                    if (!Get.isRegistered<DriverMainController>()) {
                                      DriverMainBinding().dependencies();
                                    }
                                    Get.find<DriverMainController>().uploadDoorPhoto(capturedImage!);
                                  })),
                          horizontalSpace(10),
                          Expanded(child: AppTextButton(text: 'اعاده التقاط', onTap: _retakePicture)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
