import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/save_user_data.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/show_commercial_notifacation_binding.dart';
import '../../logic/show_commercial_notifacation_controller.dart';


class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({
    super.key,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    ShowCommercialNotifacationBinding().dependencies();
    if (SaveUserData().getUserToken() != '' && SaveUserData().getUserToken().isNotEmpty) {
      if (SaveUserData().getUserData()!.showCommercialNotifications == '0') {
        isSwitched = false;
      } else {
        isSwitched = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowCommercialNotifacationController>(builder: (controller) {
      return SizedBox(
        width: 50,
        child: Transform.scale(
          scale: .9,
          child: Switch(
            value: isSwitched,
            onChanged: (value) async {
              await controller.getShowCommercialNotifications(value ? '1' : '0');
              if (!controller.iserror) {
                setState(() {
                  isSwitched = value;
                  SaveUserData().updateShowCommercialNotifications(value ? '1' : '0');
                });
              }
            },
            activeTrackColor: AppColors.main,
            activeColor: AppColors.white,
            inactiveTrackColor: AppColors.white,
            inactiveThumbColor: AppColors.dark,
          ),
        ),
      );
    });
  }
}
