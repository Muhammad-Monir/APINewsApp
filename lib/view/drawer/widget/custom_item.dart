import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/custom_divider.dart';
import '../../../provider/notification_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class CustomDrawerItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String svgName;
  final bool isToggleable;
  final VoidCallback? onTap;
  final NotificationProvider? switchProvider;

  const CustomDrawerItem(
      {super.key,
        required this.text,
        this.icon,
        required this.svgName,
        this.onTap,
        this.isToggleable = false,
        this.switchProvider});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .016,
            vertical: Utils.scrHeight * .016),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Utils.showSvgPicture(svgName),
                SizedBox(width: Utils.scrHeight * .016),
                Text(text, style: mediumTS(homeTabTextColor)),
                const Spacer(),
                isToggleable
                    ? Consumer<NotificationProvider>(
                  builder: (context, provider, child) => Switch(
                      value: provider.isSwitchToggled,
                      onChanged: (newValue) => provider.toggleSwitch(),
                      activeColor: appThemeColor,
                      activeTrackColor: const Color(0xffEBF3FF),
                      inactiveTrackColor: const Color(0xffB7C1D2),
                      inactiveThumbColor: const Color(0xff4E617E)),
                )
                    : icon != null
                    ? Icon(icon,
                    size: Utils.scrHeight * .016,
                    color: homeTabTextColor)
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(height: Utils.scrHeight * .01),
            const CustomDivider()
          ],
        ),
      ),
    );
  }
}
