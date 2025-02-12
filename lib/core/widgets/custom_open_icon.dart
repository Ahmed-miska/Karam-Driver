import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karam_driver/core/widgets/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath; // مسار الأيقونة
  final String platform; // التطبيق المراد فتحه
  final String? phoneNumber; // رقم الهاتف (في حالة واتساب أو الاتصال)
  final String? url; // الرابط (في حالة إنستجرام أو فيسبوك)

  const CustomIconButton({
    super.key,
    required this.iconPath,
    required this.platform,
    this.phoneNumber,
    this.url,
  });

  void _openApp(BuildContext context) async {
    Uri uri;

    switch (platform.toLowerCase()) {
      case 'whatsapp':
        if (phoneNumber != null) {
          uri = Uri.parse("https://wa.me/$phoneNumber");
        } else {
          customSnackbar('خطأ', 'رقم الهاتف غير متوفر لفتح الواتساب');
          return;
        }
        break;

      case 'call':
        if (phoneNumber != null) {
          uri = Uri.parse("tel:$phoneNumber");
        } else {
          customSnackbar('خطأ', 'رقم الهاتف غير متوفر للاتصال');
          return;
        }
        break;
      default:
        customSnackbar('خطأ', 'التطبيق غير مدعوم');
        return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      customSnackbar('خطأ', 'لا يمكن فتح $platform');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        iconPath,
        width: 30.h,
        height: 30.h,
        fit: BoxFit.fill,
      ), // الأيقونة بصيغة SVG
      onPressed: () => _openApp(context), // استدعاء الدالة عند الضغط
    );
  }
}
