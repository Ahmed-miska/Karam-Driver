import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/client_orders/logic/client_orders_binding.dart';
import 'package:karam_driver/features/confirm_password/logic/confirm_password_binding.dart';
import 'package:karam_driver/features/confirm_password/ui/confirm_password_screen.dart';
import 'package:karam_driver/features/contact_us/logic/contact_us_binding.dart';
import 'package:karam_driver/features/contact_us/ui/contact_us_screen.dart';
import 'package:karam_driver/features/driver_main/ui/driver_main.dart';
import 'package:karam_driver/features/forget_password/logic/forget_password_binding.dart';
import 'package:karam_driver/features/forget_password/ui/forget_password_screen.dart';
import 'package:karam_driver/features/my_account/page_screen/logic/get_page_binding.dart';
import 'package:karam_driver/features/my_account/page_screen/ui/page_screen.dart';
import 'package:karam_driver/features/my_account/profile/logic/profile_binding.dart';
import 'package:karam_driver/features/my_account/profile/ui/profile_screen.dart';
import 'package:karam_driver/features/order_details/ui/order_details_screen.dart';
import 'package:karam_driver/features/otp_code/logic/otp_binding.dart';
import 'package:karam_driver/features/otp_code/ui/otp_code_screen.dart';
import 'package:karam_driver/features/sign_in/logic/sign_in_binding.dart';
import 'package:karam_driver/features/sign_in/ui/sign_in_screen.dart';
import 'package:karam_driver/features/sign_up/logic/sign_up_binding.dart';
import 'package:karam_driver/features/sign_up/ui/sign_up_screen.dart';


class AppRoutes {
  static const signInPage = '/login';
  static const signUpPageURL = '/register';
  static const forgetPassword = '/forgetPassword';
  static const otpPageURL = '/otp';
  static const confirmPassword = '/confirmPassword';
  static const driverMain = '/driverMain';
  static const pageScreen = '/page';
  static const profile = '/profile';
  static const contactUs = '/conatctUs';
  static const clientOrderDetailsScreen = '/clientOrderDetailsScreen';
}

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.signInPage,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const SignInScreen(),
      bindings: [
        SignInBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.signUpPageURL,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.otpPageURL,
      transition: Transition.zoom,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const OtpCodeScreen(),
      bindings: [
        OtpBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.confirmPassword,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ConfirmPasswordScreen(),
      binding: ConfirmPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      transition: Transition.fadeIn,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
        name: AppRoutes.driverMain,
        transition: Transition.fadeIn,
        curve: Curves.easeInOut,
        transitionDuration: const Duration(milliseconds: 500),
        page: () => const DriverMain(),
        bindings: [
          ClientOrdersBinding(),
        ]),
    GetPage(
      name: AppRoutes.pageScreen,
      transition: Transition.zoom,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const PageScreen(),
      binding: GetPageBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.contactUs,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ContactUsScreen(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: AppRoutes.clientOrderDetailsScreen,
      transition: Transition.rightToLeftWithFade,
      curve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      page: () => const ClientOrderDetailsScreen(),
      bindings: [
        ClientOrdersBinding(),
      ],
    ),
  ];
}
