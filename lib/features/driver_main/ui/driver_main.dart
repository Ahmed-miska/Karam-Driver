import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karam_driver/features/driver_main/ui/widgets/custom_floating_action_button.dart';
import 'package:karam_driver/features/driver_main/ui/widgets/search_customer_bottom_sheet.dart';
import '../../../core/helpers/app_assets.dart';
import '../../../core/theming/colors.dart';
import '../../client_orders/ui/my_order_screen.dart';
import '../../my_account/ui/my_account_screen.dart';
import 'widgets/nav_bar_item.dart';

class DriverMain extends StatefulWidget {
  const DriverMain({super.key});

  @override
  State<DriverMain> createState() => _DriverMainState();
}

class _DriverMainState extends State<DriverMain> {
  int currentTab = 1;
  final List<Widget> screens = [
    const MyAccountScreen(),
    const DriverOrderScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DriverOrderScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Get.bottomSheet(const SearchCustomerBottomSheet(), isScrollControlled: true);
        },
        icon: const CustomFloatingActionButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),
            notchMargin: 15,
            clipBehavior: Clip.hardEdge,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 40,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      NavBarItem(
                        isActive: currentTab == 0,
                        title: 'حسابي',
                        icon: AppAssets.settingSvg,
                        onTap: () {
                          setState(() {
                            currentScreen = screens[0];
                            currentTab = 0;
                          });
                        },
                      ),
                      NavBarItem(
                        isActive: currentTab == 1,
                        title: 'طلباتي',
                        icon: AppAssets.sellerOrdersSvg,
                        onTap: () {
                          setState(() {
                            currentScreen = screens[1];
                            currentTab = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
